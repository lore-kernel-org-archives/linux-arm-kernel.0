From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 25 Jun 2014 13:01:31 +0200
Subject: [PATCH v2 2/2] ARM: imx53: globally disable supervisor protect
In-Reply-To: <1403694091-27247-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1403694091-27247-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1403694091-27247-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most peripherals on the i.MX53 have an
	Off-Platform Peripheral Access Control Register (OPACR)
in which the access rights (together with the MPROT registers) can be declared.
However, this does not seem to work for example for SSI1+SDMA, because the
supervisor bit is not set for the SDMA unit.
It does work for SSI2, the QSB for example uses SSI2 for its audio. But SSI2 only
works because it does NOT have an OPACR.

The right solution would be to fix the access rights for the SDMA, but the unit
responsible for this is the Central Security Unit (CSU), which of course is NOT
documented. So, until documentation for this is openly available, turn off the
supervisor protection because it cripples the hardware.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 2bad387..380c7ee 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
@@ -24,11 +25,24 @@
 #include "hardware.h"
 #include "mx53.h"
 
+static const struct of_device_id aips_of_matches[] __initconst = {
+	{ .compatible = "fsl,imx53-aipstz" },
+	{ /*sentinel*/ }
+};
+
 static void __init imx53_dt_init(void)
 {
+	void __iomem *aips_base_addr;
+	struct device_node *np;
+
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	for_each_matching_node(np, aips_of_matches) {
+		aips_base_addr = of_iomap(np, 0);
+		imx_set_aips(aips_base_addr);
+	}
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
-- 
2.0.0
