From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Thu, 6 Jan 2011 20:30:32 +0800
Subject: [PATCH 2/3] ARM i.MX53 enable i2c on EVK board
In-Reply-To: <1294317033-9194-1-git-send-email-yong.shen@freescale.com>
References: <1294317033-9194-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294317033-9194-3-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

add i2c platform data and clock

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c           |    7 +++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    2 ++
 arch/arm/mach-mx5/devices-imx53.h            |    5 +++++
 arch/arm/plat-mxc/devices/platform-imx-i2c.c |    9 +++++++++
 5 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 55254b6..632d711 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -124,6 +124,7 @@ config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	help
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index b9ab386..ba6184b 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -65,6 +65,10 @@ static inline void mx53_evk_init_uart(void)
 	imx53_add_imx_uart(2, &mx53_evk_uart_pdata);
 }
 
+static const struct imxi2c_platform_data mx53_evk_i2c_data __initconst = {
+	.bitrate = 100000,
+};
+
 static inline void mx53_evk_fec_reset(void)
 {
 	int ret;
@@ -92,6 +96,9 @@ static void __init mx53_evk_board_init(void)
 	mx53_evk_init_uart();
 	mx53_evk_fec_reset();
 	imx53_add_fec(&mx53_evk_fec_pdata);
+
+	imx53_add_imx_i2c(0, &mx53_evk_i2c_data);
+	imx53_add_imx_i2c(1, &mx53_evk_i2c_data);
 }
 
 static void __init mx53_evk_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index b21bc47..0ade3c4 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1326,6 +1326,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
+	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
+	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index dbf1989..ca1232b 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -15,3 +15,8 @@ extern const struct imx_fec_data imx53_fec_data __initconst;
 extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst;
 #define imx53_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx53_imx_uart_data[id], pdata)
+
+
+extern const struct imx_imx_i2c_data imx53_imx_i2c_data[] __initconst;
+#define imx53_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx53_imx_i2c_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index 72ba880..7ba94e1 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -78,6 +78,15 @@ const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_imx_i2c_data imx53_imx_i2c_data[] __initconst = {
+#define imx53_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX53, _id, _hwid, SZ_4K)
+	imx53_imx_i2c_data_entry(0, 1),
+	imx53_imx_i2c_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_imx_i2c(
 		const struct imx_imx_i2c_data *data,
 		const struct imxi2c_platform_data *pdata)
-- 
1.7.1
