From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:12 +0200
Subject: [PATCH 36/40] ARM: mx51: add imx-ssi devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-36-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/clock-mx51.c               |   12 ++++++++++++
 arch/arm/mach-mx5/devices-imx51.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-imx-ssi.c |    9 +++++++++
 arch/arm/plat-mxc/include/mach/mx51.h        |   20 ++++++++++----------
 5 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 791927a..65bf34e 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -10,6 +10,7 @@ comment "MX5 platforms:"
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 0cef8c4..5c79011 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -949,6 +949,16 @@ DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
 DEFINE_CLOCK1(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
 	clk_nfc, &emi_slow_clk, NULL);
 
+/* SSI */
+DEFINE_CLOCK(ssi1_ipg_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG8_OFFSET,
+	NULL, NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(ssi1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG9_OFFSET,
+	NULL, NULL, &pll3_sw_clk, &ssi1_ipg_clk);
+DEFINE_CLOCK(ssi2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG10_OFFSET,
+	NULL, NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(ssi2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG11_OFFSET,
+	NULL, NULL, &pll3_sw_clk, &ssi2_ipg_clk);
+
 /* eCSPI */
 DEFINE_CLOCK_FULL(ecspi1_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
 		NULL, NULL, _clk_ccgr_enable_inrun, _clk_ccgr_disable,
@@ -991,6 +1001,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 8235b8c..782b45b 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -13,6 +13,10 @@ extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
 
+extern const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst;
+#define imx51_add_imx_ssi(id, pdata)	\
+	imx_add_imx_ssi(&imx51_imx_ssi_data[id], pdata)
+
 extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst;
 #define imx51_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx51_imx_uart_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index 1535bc9..38a7a0b 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -66,6 +66,15 @@ const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
+#define imx51_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_4K)
+	imx51_imx_ssi_data_entry(0, 1),
+	imx51_imx_ssi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_imx_ssi(
 		const struct imx_imx_ssi_data *data,
 		const struct imx_ssi_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index b7359d7..b47d65b 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -248,14 +248,14 @@
 #define MX51_DMA_REQ_UART1_TX		19
 #define MX51_DMA_REQ_SDHC1		20
 #define MX51_DMA_REQ_SDHC2		21
-#define MX51_DMA_REQ_SSI2_RX2		22
-#define MX51_DMA_REQ_SSI2_TX2		23
-#define MX51_DMA_REQ_SSI2_RX1		24
-#define MX51_DMA_REQ_SSI2_TX1		25
-#define MX51_DMA_REQ_SSI1_RX2		26
-#define MX51_DMA_REQ_SSI1_TX2		27
-#define MX51_DMA_REQ_SSI1_RX1		28
-#define MX51_DMA_REQ_SSI1_TX1		29
+#define MX51_DMA_REQ_SSI2_RX1		22
+#define MX51_DMA_REQ_SSI2_TX1		23
+#define MX51_DMA_REQ_SSI2_RX0		24
+#define MX51_DMA_REQ_SSI2_TX0		25
+#define MX51_DMA_REQ_SSI1_RX1		26
+#define MX51_DMA_REQ_SSI1_TX1		27
+#define MX51_DMA_REQ_SSI1_RX0		28
+#define MX51_DMA_REQ_SSI1_TX0		29
 #define MX51_DMA_REQ_EMI_RD		30
 #define MX51_DMA_REQ_CTI2_0		31
 #define MX51_DMA_REQ_EMI_WR		32
@@ -308,8 +308,8 @@
 #define MX51_MXC_INT_RTIC		26
 #define MX51_MXC_INT_CSU		27
 #define MX51_MXC_INT_SLIM_B		28
-#define MX51_MXC_INT_SSI1		29
-#define MX51_MXC_INT_SSI2		30
+#define MX51_INT_SSI1			29
+#define MX51_INT_SSI2			30
 #define MX51_INT_UART1			31
 #define MX51_INT_UART2			32
 #define MX51_INT_UART3			33
-- 
1.7.2.3
