From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Oct 2016 09:43:42 +0200
Subject: [PATCH] ARM: integrator: drop EBI access use syscon
Message-ID: <1476863022-7610-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EBI lookup is not longer in use: this has been moved to the
NAND chip driver. The syscon node is better accessed indirectly
using the regmap like the NAND chip driver does, so let's use
the syscon to set the modem control signals RTS/CTS through the
dedicated syscon register.

We also migrate the decoder status "SC_DEC" register that
enumerate the logic modules using syscon.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 54 ++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 23b98fd414bf..a1af634f8709 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -27,6 +27,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/termios.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -37,11 +39,8 @@
 #include "pci_v3.h"
 #include "lm.h"
 
-/* Base address to the AP system controller */
-void __iomem *ap_syscon_base;
-/* Base address to the external bus interface */
-static void __iomem *ebi_base;
-
+/* Regmap to the AP system controller */
+static struct regmap *ap_syscon_map;
 
 /*
  * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
@@ -125,6 +124,7 @@ static void integrator_uart_set_mctrl(struct amba_device *dev,
 {
 	unsigned int ctrls = 0, ctrlc = 0, rts_mask, dtr_mask;
 	u32 phybase = dev->res.start;
+	int ret;
 
 	if (phybase == INTEGRATOR_UART0_BASE) {
 		/* UART0 */
@@ -146,8 +146,17 @@ static void integrator_uart_set_mctrl(struct amba_device *dev,
 	else
 		ctrls |= dtr_mask;
 
-	__raw_writel(ctrls, ap_syscon_base + INTEGRATOR_SC_CTRLS_OFFSET);
-	__raw_writel(ctrlc, ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
+	ret = regmap_write(ap_syscon_map,
+			   INTEGRATOR_SC_CTRLS_OFFSET,
+			   ctrls);
+	if (ret)
+		pr_err("MODEM: unable to write PL010 UART CTRLS\n");
+
+	ret = regmap_write(ap_syscon_map,
+			   INTEGRATOR_SC_CTRLC_OFFSET,
+			   ctrlc);
+	if (ret)
+		pr_err("MODEM: unable to write PL010 UART CRTLC\n");
 }
 
 struct amba_pl010_data ap_uart_data = {
@@ -178,35 +187,32 @@ static const struct of_device_id ap_syscon_match[] = {
 	{ },
 };
 
-static const struct of_device_id ebi_match[] = {
-	{ .compatible = "arm,external-bus-interface"},
-	{ },
-};
-
 static void __init ap_init_of(void)
 {
-	unsigned long sc_dec;
+	u32 sc_dec;
 	struct device_node *syscon;
-	struct device_node *ebi;
+	int ret;
 	int i;
 
+	of_platform_default_populate(NULL, ap_auxdata_lookup, NULL);
+
 	syscon = of_find_matching_node(NULL, ap_syscon_match);
 	if (!syscon)
 		return;
-	ebi = of_find_matching_node(NULL, ebi_match);
-	if (!ebi)
+	ap_syscon_map = syscon_node_to_regmap(syscon);
+	if (IS_ERR(ap_syscon_map)) {
+		pr_crit("could not find Integrator/AP system controller\n");
 		return;
+	}
 
-	ap_syscon_base = of_iomap(syscon, 0);
-	if (!ap_syscon_base)
-		return;
-	ebi_base = of_iomap(ebi, 0);
-	if (!ebi_base)
+	ret = regmap_read(ap_syscon_map,
+			  INTEGRATOR_SC_DEC_OFFSET,
+			  &sc_dec);
+	if (ret) {
+		pr_crit("could not read from Integrator/AP syscon\n");
 		return;
+	}
 
-	of_platform_default_populate(NULL, ap_auxdata_lookup, NULL);
-
-	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
 
-- 
2.7.4
