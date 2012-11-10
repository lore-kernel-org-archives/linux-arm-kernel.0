From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:40 +0530
Subject: [PATCH 1/8] CLK: SPEAr: Fix dev_id & con_id for multiple clocks
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <dae335251207459d59e9b1f8eb87309cfb3df415.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

dev_id & con_id names of multiple clocks are incorrect. This patch fixes these
names with the names that come via DT.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Bhavna Yadav <bhavna.yadav@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c | 30 +++++++++++++-------------
 drivers/clk/spear/spear1340_clock.c | 42 +++++++++++++++++++------------------
 drivers/clk/spear/spear3xx_clock.c  | 12 ++++++-----
 drivers/clk/spear/spear6xx_clock.c  |  6 ++++--
 4 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 0fcec2a..f13b1d2 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -401,7 +401,7 @@ void __init spear1310_clk_init(void)
 	clk = clk_register_gate(NULL, "rtc-spear", "osc_32k_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_RTC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "fc900000.rtc");
+	clk_register_clkdev(clk, NULL, "e0580000.rtc");
 
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
@@ -615,7 +615,7 @@ void __init spear1310_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
@@ -638,7 +638,7 @@ void __init spear1310_clk_init(void)
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_CLCD_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "clcd_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e1000000.clcd");
 
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
@@ -705,35 +705,37 @@ void __init spear1310_clk_init(void)
 	clk = clk_register_gate(NULL, "usbh0_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_UHC0_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "usbh.0_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e4000000.ohci");
+	clk_register_clkdev(clk, NULL, "e4800000.ehci");
 
 	clk = clk_register_gate(NULL, "usbh1_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_UHC1_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "usbh.1_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e5000000.ohci");
+	clk_register_clkdev(clk, NULL, "e5800000.ehci");
 
 	clk = clk_register_gate(NULL, "uoc_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_UOC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "uoc");
+	clk_register_clkdev(clk, NULL, "e3800000.otg");
 
 	clk = clk_register_gate(NULL, "pcie_sata_0_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_0_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "dw_pcie.0");
-	clk_register_clkdev(clk, NULL, "ahci.0");
+	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_1_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_1_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "dw_pcie.1");
-	clk_register_clkdev(clk, NULL, "ahci.1");
+	clk_register_clkdev(clk, NULL, "b1800000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_2_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_2_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "dw_pcie.2");
-	clk_register_clkdev(clk, NULL, "ahci.2");
+	clk_register_clkdev(clk, NULL, "b4000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_SYSRAM0_CLK_ENB, 0,
@@ -754,7 +756,7 @@ void __init spear1310_clk_init(void)
 	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_ADC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "adc_clk");
+	clk_register_clkdev(clk, NULL, "e0080000.adc");
 
 	/* clock derived from apb clk */
 	clk = clk_register_gate(NULL, "ssp0_clk", "apb_clk", 0,
@@ -916,15 +918,15 @@ void __init spear1310_clk_init(void)
 			SPEAR1310_RAS_CTRL_REG1,
 			SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.1");
-	clk_register_clkdev(clk, NULL, "stmmacphy.2");
-	clk_register_clkdev(clk, NULL, "stmmacphy.4");
+	clk_register_clkdev(clk, "stmmacphy.1", NULL);
+	clk_register_clkdev(clk, "stmmacphy.2", NULL);
+	clk_register_clkdev(clk, "stmmacphy.4", NULL);
 
 	clk = clk_register_mux(NULL, "rmii_phy_mclk", rmii_phy_parents,
 			ARRAY_SIZE(rmii_phy_parents), 0,
 			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.3");
+	clk_register_clkdev(clk, "stmmacphy.3", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 2352cee..dae2ba6 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -425,7 +425,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "rtc-spear", "osc_32k_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_RTC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "fc900000.rtc");
+	clk_register_clkdev(clk, NULL, "e0580000.rtc");
 
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
@@ -499,7 +499,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "thermal_gclk", "thermal_clk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_THSENS_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spear_thermal");
+	clk_register_clkdev(clk, NULL, "e07008c4.thermal");
 
 	/* clock derived from pll4 clk */
 	clk = clk_register_fixed_factor(NULL, "ddr_clk", "pll4_clk", 0, 1,
@@ -659,7 +659,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "c3_clk", "c3_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_C3_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "c3");
+	clk_register_clkdev(clk, NULL, "e1800000.c3");
 
 	/* gmac */
 	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
@@ -679,7 +679,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
@@ -702,7 +702,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_CLCD_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "clcd_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e1000000.clcd");
 
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
@@ -769,23 +769,25 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "usbh0_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UHC0_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "usbh.0_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e4000000.ohci");
+	clk_register_clkdev(clk, NULL, "e4800000.ehci");
 
 	clk = clk_register_gate(NULL, "usbh1_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UHC1_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, "usbh.1_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e5000000.ohci");
+	clk_register_clkdev(clk, NULL, "e5800000.ehci");
 
 	clk = clk_register_gate(NULL, "uoc_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UOC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "uoc");
+	clk_register_clkdev(clk, NULL, "e3800000.otg");
 
 	clk = clk_register_gate(NULL, "pcie_sata_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_PCIE_SATA_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "dw_pcie");
-	clk_register_clkdev(clk, NULL, "ahci");
+	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_SYSRAM0_CLK_ENB, 0,
@@ -806,7 +808,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "adc_clk", "adc_syn_gclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_ADC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "adc_clk");
+	clk_register_clkdev(clk, NULL, "e0080000.adc");
 
 	/* clock derived from apb clk */
 	clk = clk_register_gate(NULL, "ssp_clk", "apb_clk", 0,
@@ -827,12 +829,12 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "i2s_play_clk", "apb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_I2S_PLAY_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "b2400000.i2s");
+	clk_register_clkdev(clk, NULL, "b2400000.i2s-play");
 
 	clk = clk_register_gate(NULL, "i2s_rec_clk", "apb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_I2S_REC_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "b2000000.i2s");
+	clk_register_clkdev(clk, NULL, "b2000000.i2s-rec");
 
 	clk = clk_register_gate(NULL, "kbd_clk", "apb_clk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_KBD_CLK_ENB, 0,
@@ -896,7 +898,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "spdif_out_clk", "spdif_out_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_OUT_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "spdif-out");
+	clk_register_clkdev(clk, NULL, "d0000000.spdif-out");
 
 	clk = clk_register_mux(NULL, "spdif_in_mclk", spdif_in_parents,
 			ARRAY_SIZE(spdif_in_parents), 0,
@@ -907,7 +909,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "spdif_in_clk", "spdif_in_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_SPDIF_IN_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spdif-in");
+	clk_register_clkdev(clk, NULL, "d0100000.spdif-in");
 
 	clk = clk_register_gate(NULL, "acp_clk", "acp_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_ACP_CLK_ENB, 0,
@@ -917,7 +919,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "plgpio_clk", "plgpio_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PLGPIO_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "plgpio");
+	clk_register_clkdev(clk, NULL, "e2800000.gpio");
 
 	clk = clk_register_gate(NULL, "video_dec_clk", "video_dec_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_DEC_CLK_ENB,
@@ -937,25 +939,25 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "cam0_clk", "cam0_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM0_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spear_camif.0");
+	clk_register_clkdev(clk, NULL, "d0200000.cam0");
 
 	clk = clk_register_gate(NULL, "cam1_clk", "cam1_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM1_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spear_camif.1");
+	clk_register_clkdev(clk, NULL, "d0300000.cam1");
 
 	clk = clk_register_gate(NULL, "cam2_clk", "cam2_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM2_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spear_camif.2");
+	clk_register_clkdev(clk, NULL, "d0400000.cam2");
 
 	clk = clk_register_gate(NULL, "cam3_clk", "cam3_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM3_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "spear_camif.3");
+	clk_register_clkdev(clk, NULL, "d0500000.cam3");
 
 	clk = clk_register_gate(NULL, "pwm_clk", "pwm_mclk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PWM_CLK_ENB, 0,
 			&_lock);
-	clk_register_clkdev(clk, NULL, "pwm");
+	clk_register_clkdev(clk, NULL, "e0180000.pwm");
 }
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index c315745..e6461f7 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -251,7 +251,7 @@ static void __init spear320_clk_init(void)
 
 	clk = clk_register_fixed_factor(NULL, "pwm_clk", "ras_ahb_clk", 0, 1,
 			1);
-	clk_register_clkdev(clk, "pwm", NULL);
+	clk_register_clkdev(clk, NULL, "a8000000.pwm");
 
 	clk = clk_register_fixed_factor(NULL, "ssp1_clk", "ras_ahb_clk", 0, 1,
 			1);
@@ -271,7 +271,7 @@ static void __init spear320_clk_init(void)
 
 	clk = clk_register_fixed_factor(NULL, "i2s_clk", "ras_apb_clk", 0, 1,
 			1);
-	clk_register_clkdev(clk, NULL, "i2s");
+	clk_register_clkdev(clk, NULL, "a9400000.i2s");
 
 	clk = clk_register_mux(NULL, "i2s_ref_clk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR320_CONTROL_REG,
@@ -480,7 +480,9 @@ void __init spear3xx_clk_init(void)
 	/* clock derived from pll3 clk */
 	clk = clk_register_gate(NULL, "usbh_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
 			USBH_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, "usbh_clk", NULL);
+	clk_register_clkdev(clk, NULL, "e1800000.ehci");
+	clk_register_clkdev(clk, NULL, "e1900000.ohci");
+	clk_register_clkdev(clk, NULL, "e2100000.ohci");
 
 	clk = clk_register_fixed_factor(NULL, "usbh.0_clk", "usbh_clk", 0, 1,
 			1);
@@ -492,7 +494,7 @@ void __init spear3xx_clk_init(void)
 
 	clk = clk_register_gate(NULL, "usbd_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
 			USBD_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "designware_udc");
+	clk_register_clkdev(clk, NULL, "e1100000.usbd");
 
 	/* clock derived from ahb clk */
 	clk = clk_register_fixed_factor(NULL, "ahbmult2_clk", "ahb_clk", 0, 2,
@@ -540,7 +542,7 @@ void __init spear3xx_clk_init(void)
 	/* clock derived from apb clk */
 	clk = clk_register_gate(NULL, "adc_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			ADC_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "adc");
+	clk_register_clkdev(clk, NULL, "d0080000.adc");
 
 	clk = clk_register_gate(NULL, "gpio0_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			GPIO_CLK_ENB, 0, &_lock);
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index a98d086..c7fa67c 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -261,11 +261,13 @@ void __init spear6xx_clk_init(void)
 	/* clock derived from pll3 clk */
 	clk = clk_register_gate(NULL, "usbh0_clk", "pll3_clk", 0,
 			PERIP1_CLK_ENB, USBH0_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "usbh.0_clk");
+	clk_register_clkdev(clk, NULL, "e1800000.ehci");
+	clk_register_clkdev(clk, NULL, "e1900000.ohci");
 
 	clk = clk_register_gate(NULL, "usbh1_clk", "pll3_clk", 0,
 			PERIP1_CLK_ENB, USBH1_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "usbh.1_clk");
+	clk_register_clkdev(clk, NULL, "e2000000.ehci");
+	clk_register_clkdev(clk, NULL, "e2100000.ohci");
 
 	clk = clk_register_gate(NULL, "usbd_clk", "pll3_clk", 0, PERIP1_CLK_ENB,
 			USBD_CLK_ENB, 0, &_lock);
-- 
1.7.12.rc2.18.g61b472e
