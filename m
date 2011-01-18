From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:45 -0500
Subject: [PATCH v1 4/5] davinci: da850: move da850_evm specific mmcsd pinmux
	array to board file.
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1295371306-24035-5-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850_mmcsd0_pins pinmux array contains pins that are specific to the
da850 evm board (the write protect and card detect GPIO pins).  Move
the array to the board file.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |    9 ++++++++-
 arch/arm/mach-davinci/da850.c              |    7 -------
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c4c0b75..11f986b 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -690,6 +690,13 @@ static struct davinci_mmc_config da850_mmc_config = {
 	.version	= MMC_CTLR_VERSION_2,
 };
 
+static const short da850_evm_mmcsd0_pins[] __initconst = {
+	DA850_MMCSD0_DAT_0, DA850_MMCSD0_DAT_1, DA850_MMCSD0_DAT_2,
+	DA850_MMCSD0_DAT_3, DA850_MMCSD0_CLK, DA850_MMCSD0_CMD,
+	DA850_GPIO4_0, DA850_GPIO4_1,
+	-1
+};
+
 static void da850_panel_power_ctrl(int val)
 {
 	/* lcd backlight */
@@ -1077,7 +1084,7 @@ static __init void da850_evm_init(void)
 				ret);
 
 	if (HAS_MMC) {
-		ret = davinci_cfg_reg_list(da850_mmcsd0_pins);
+		ret = davinci_cfg_reg_list(da850_evm_mmcsd0_pins);
 		if (ret)
 			pr_warning("da850_evm_init: mmcsd0 mux setup failed:"
 					" %d\n", ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5b98232..8927d4a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -586,13 +586,6 @@ const short da850_lcdcntl_pins[] __initdata = {
 	-1
 };
 
-const short da850_mmcsd0_pins[] __initdata = {
-	DA850_MMCSD0_DAT_0, DA850_MMCSD0_DAT_1, DA850_MMCSD0_DAT_2,
-	DA850_MMCSD0_DAT_3, DA850_MMCSD0_CLK, DA850_MMCSD0_CMD,
-	DA850_GPIO4_0, DA850_GPIO4_1,
-	-1
-};
-
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
 static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
 	[IRQ_DA8XX_COMMTX]		= 7,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 89668b4..18f6c23 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -129,6 +129,5 @@ extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
 extern const short da850_lcdcntl_pins[];
-extern const short da850_mmcsd0_pins[];
 
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
-- 
1.7.0.4
