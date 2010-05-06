From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:03 -0700
Subject: [PATCH 12/34] Davinci: promote da8xx_pinmux_setup()
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-13-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Rename da8xx_pinmux_setup() to davinci_cfg_reg_list() and promote it for use in
other SOCs that may need the ability to configure multiple pins in one shot.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c    |   14 +++++++-------
 arch/arm/mach-davinci/board-da850-evm.c    |   18 +++++++++---------
 arch/arm/mach-davinci/include/mach/da8xx.h |    6 ------
 arch/arm/mach-davinci/include/mach/mux.h   |    5 +++++
 arch/arm/mach-davinci/mux.c                |    3 +--
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index db5ac0f..9257056 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -157,7 +157,7 @@ static __init void da830_evm_usb_init(void)
 				   __func__, ret);
 	}
 
-	ret = da8xx_pinmux_setup(da830_evm_usb11_pins);
+	ret = davinci_cfg_reg_list(da830_evm_usb11_pins);
 	if (ret) {
 		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
 			   __func__, ret);
@@ -254,7 +254,7 @@ static inline void da830_evm_init_mmc(void)
 {
 	int ret;
 
-	ret = da8xx_pinmux_setup(da830_evm_mmc_sd_pins);
+	ret = davinci_cfg_reg_list(da830_evm_mmc_sd_pins);
 	if (ret) {
 		pr_warning("da830_evm_init: mmc/sd mux setup failed: %d\n",
 				ret);
@@ -407,7 +407,7 @@ static inline void da830_evm_init_nand(int mux_mode)
 		return;
 	}
 
-	ret = da8xx_pinmux_setup(da830_evm_emif25_pins);
+	ret = davinci_cfg_reg_list(da830_evm_emif25_pins);
 	if (ret)
 		pr_warning("da830_evm_init: emif25 mux setup failed: %d\n",
 				ret);
@@ -427,7 +427,7 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 {
 	int ret;
 
-	ret = da8xx_pinmux_setup(da830_lcdcntl_pins);
+	ret = davinci_cfg_reg_list(da830_lcdcntl_pins);
 	if (ret)
 		pr_warning("da830_evm_init: lcdcntl mux setup failed: %d\n",
 				ret);
@@ -507,7 +507,7 @@ static __init void da830_evm_init(void)
 		pr_warning("da830_evm_init: edma registration failed: %d\n",
 				ret);
 
-	ret = da8xx_pinmux_setup(da830_i2c0_pins);
+	ret = davinci_cfg_reg_list(da830_i2c0_pins);
 	if (ret)
 		pr_warning("da830_evm_init: i2c0 mux setup failed: %d\n",
 				ret);
@@ -523,7 +523,7 @@ static __init void da830_evm_init(void)
 	soc_info->emac_pdata->mdio_max_freq = DA830_EVM_MDIO_FREQUENCY;
 	soc_info->emac_pdata->rmii_en = 1;
 
-	ret = da8xx_pinmux_setup(da830_cpgmac_pins);
+	ret = davinci_cfg_reg_list(da830_cpgmac_pins);
 	if (ret)
 		pr_warning("da830_evm_init: cpgmac mux setup failed: %d\n",
 				ret);
@@ -542,7 +542,7 @@ static __init void da830_evm_init(void)
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
 
-	ret = da8xx_pinmux_setup(da830_evm_mcasp1_pins);
+	ret = davinci_cfg_reg_list(da830_evm_mcasp1_pins);
 	if (ret)
 		pr_warning("da830_evm_init: mcasp1 mux setup failed: %d\n",
 				ret);
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ef691ae..6c137e0 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -206,12 +206,12 @@ static __init void da850_evm_setup_nor_nand(void)
 	int ret = 0;
 
 	if (ui_card_detected & !HAS_MMC) {
-		ret = da8xx_pinmux_setup(da850_nand_pins);
+		ret = davinci_cfg_reg_list(da850_nand_pins);
 		if (ret)
 			pr_warning("da850_evm_init: nand mux setup failed: "
 					"%d\n", ret);
 
-		ret = da8xx_pinmux_setup(da850_nor_pins);
+		ret = davinci_cfg_reg_list(da850_nor_pins);
 		if (ret)
 			pr_warning("da850_evm_init: nor mux setup failed: %d\n",
 				ret);
@@ -568,12 +568,12 @@ static int __init da850_evm_config_emac(void)
 
 	if (rmii_en) {
 		val |= BIT(8);
-		ret = da8xx_pinmux_setup(da850_rmii_pins);
+		ret = davinci_cfg_reg_list(da850_rmii_pins);
 		pr_info("EMAC: RMII PHY configured, MII PHY will not be"
 							" functional\n");
 	} else {
 		val &= ~BIT(8);
-		ret = da8xx_pinmux_setup(da850_cpgmac_pins);
+		ret = davinci_cfg_reg_list(da850_cpgmac_pins);
 		pr_info("EMAC: MII PHY configured, RMII PHY will not be"
 							" functional\n");
 	}
@@ -626,7 +626,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: edma registration failed: %d\n",
 				ret);
 
-	ret = da8xx_pinmux_setup(da850_i2c0_pins);
+	ret = davinci_cfg_reg_list(da850_i2c0_pins);
 	if (ret)
 		pr_warning("da850_evm_init: i2c0 mux setup failed: %d\n",
 				ret);
@@ -643,7 +643,7 @@ static __init void da850_evm_init(void)
 				ret);
 
 	if (HAS_MMC) {
-		ret = da8xx_pinmux_setup(da850_mmcsd0_pins);
+		ret = davinci_cfg_reg_list(da850_mmcsd0_pins);
 		if (ret)
 			pr_warning("da850_evm_init: mmcsd0 mux setup failed:"
 					" %d\n", ret);
@@ -679,20 +679,20 @@ static __init void da850_evm_init(void)
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART1_BASE) + 0x30);
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART0_BASE) + 0x30);
 
-	ret = da8xx_pinmux_setup(da850_mcasp_pins);
+	ret = davinci_cfg_reg_list(da850_mcasp_pins);
 	if (ret)
 		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
 				ret);
 
 	da8xx_register_mcasp(0, &da850_evm_snd_data);
 
-	ret = da8xx_pinmux_setup(da850_lcdcntl_pins);
+	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
 	if (ret)
 		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",
 				ret);
 
 	/* Handle board specific muxing for LCD here */
-	ret = da8xx_pinmux_setup(da850_evm_lcdc_pins);
+	ret = davinci_cfg_reg_list(da850_evm_lcdc_pins);
 	if (ret)
 		pr_warning("da850_evm_init: evm specific lcd mux setup "
 				"failed: %d\n",	ret);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 03acfd3..33471c9 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -146,10 +146,4 @@ extern const short da850_mmcsd0_pins[];
 extern const short da850_nand_pins[];
 extern const short da850_nor_pins[];
 
-#ifdef CONFIG_DAVINCI_MUX
-int da8xx_pinmux_setup(const short pins[]);
-#else
-static inline int da8xx_pinmux_setup(const short pins[]) { return 0; }
-#endif
-
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 2a68c1d..48888db 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -907,9 +907,14 @@ enum davinci_da850_index {
 #ifdef CONFIG_DAVINCI_MUX
 /* setup pin muxing */
 extern int davinci_cfg_reg(unsigned long reg_cfg);
+extern int davinci_cfg_reg_list(const short pins[]);
 #else
 /* boot loader does it all (no warnings from CONFIG_DAVINCI_MUX_WARNINGS) */
 static inline int davinci_cfg_reg(unsigned long reg_cfg) { return 0; }
+static inline int davinci_cfg_reg_list(const short pins[])
+{
+	return 0;
+}
 #endif
 
 #endif /* __INC_MACH_MUX_H */
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index c942c89..e9d530a 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -21,7 +21,6 @@
 
 #include <mach/mux.h>
 #include <mach/common.h>
-#include <mach/da8xx.h>
 
 /*
  * Sets the DAVINCI MUX register based on the table
@@ -92,7 +91,7 @@ int __init_or_module davinci_cfg_reg(const unsigned long index)
 }
 EXPORT_SYMBOL(davinci_cfg_reg);
 
-int da8xx_pinmux_setup(const short pins[])
+int __init_or_module davinci_cfg_reg_list(const short pins[])
 {
 	int i, error = -EINVAL;
 
-- 
1.7.0.2
