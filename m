From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 24 Sep 2013 22:28:15 +0300
Subject: [PATCH v2 1/3] ARM: OMAP2: pdata-quirks: set internal clock source
 for MMC2 on N950/N9
In-Reply-To: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
References: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1380050897-6605-2-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set internal clock source for MMC2 on N950/N9.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/pdata-quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 52b4bc3..1a7f492 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -16,6 +16,7 @@
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
+#include "control.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -62,6 +63,17 @@ static inline void omap_init_wl12xx_of(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP3
+static void __init hsmmc2_internal_input_clk(void)
+{
+	u32 reg;
+
+	reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
+}
+#endif /* CONFIG_ARCH_OMAP3 */
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
@@ -86,6 +98,10 @@ static void __init omap5_uevm_legacy_init(void)
 #endif
 
 static struct pdata_init pdata_quirks[] __initdata = {
+#ifdef CONFIG_ARCH_OMAP3
+	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
+	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
+#endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
 	{ "ti,omap4-panda", omap4_panda_legacy_init, },
-- 
1.8.4.rc3
