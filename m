From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Jan 2011 17:48:04 +0800
Subject: [PATCH v2 2/2] arm: mx50_rdp: add i2c bus support
In-Reply-To: <1294998484-32361-1-git-send-email-richard.zhao@freescale.com>
References: <1294998484-32361-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1294998484-32361-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-mx5/board-mx50_rdp.c           |    7 +++++++
 arch/arm/mach-mx5/devices-mx50.h             |    3 +++
 arch/arm/plat-mxc/devices/platform-imx-i2c.c |   10 ++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index 884c003..5038b43 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -184,6 +184,10 @@ static inline void mx50_rdp_fec_reset(void)
 	gpio_set_value(FEC_RESET_B, 1);
 }
 
+static const struct imxi2c_platform_data i2c_data __initconst = {
+	.bitrate = 100000,
+};
+
 /*
  * Board specific initialization.
  */
@@ -196,6 +200,9 @@ static void __init mx50_rdp_board_init(void)
 	imx50_add_imx_uart(1, &uart_pdata);
 	mx50_rdp_fec_reset();
 	imx50_add_fec(&fec_data);
+	imx50_add_imx_i2c(0, &i2c_data);
+	imx50_add_imx_i2c(1, &i2c_data);
+	imx50_add_imx_i2c(2, &i2c_data);
 }
 
 static void __init mx50_rdp_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-mx50.h b/arch/arm/mach-mx5/devices-mx50.h
index e1093db..c9e4282 100644
--- a/arch/arm/mach-mx5/devices-mx50.h
+++ b/arch/arm/mach-mx5/devices-mx50.h
@@ -29,3 +29,6 @@ extern const struct imx_fec_data imx50_fec_data __initconst;
 #define imx50_add_fec(pdata)	\
 	imx_add_fec(&imx50_fec_data, pdata)
 
+extern const struct imx_imx_i2c_data imx50_imx_i2c_data[] __initconst;
+#define imx50_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx50_imx_i2c_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index 7ba94e1..2ab74f0 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -69,6 +69,16 @@ const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX50
+const struct imx_imx_i2c_data imx50_imx_i2c_data[] __initconst = {
+#define imx50_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX50, _id, _hwid, SZ_4K)
+	imx50_imx_i2c_data_entry(0, 1),
+	imx50_imx_i2c_data_entry(1, 2),
+	imx50_imx_i2c_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 #ifdef CONFIG_SOC_IMX51
 const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
 #define imx51_imx_i2c_data_entry(_id, _hwid)				\
-- 
1.6.3.3
