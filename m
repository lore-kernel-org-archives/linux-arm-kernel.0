From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Feb 2011 16:57:45 -0200
Subject: [PATCH 1/2] ARM: mx5: Add watchdog support for MX53
Message-ID: <1297969066-14810-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c           |    2 ++
 arch/arm/mach-mx5/devices-imx53.h             |    4 ++++
 arch/arm/mach-mx5/mm.c                        |    2 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c |    9 +++++++++
 arch/arm/plat-mxc/include/mach/mx53.h         |    2 +-
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index c66be0e..8164b1d 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1336,6 +1336,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 8639735..9251008 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -29,3 +29,7 @@ imx53_sdhci_esdhc_imx_data[] __initconst;
 extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
 #define imx53_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
+
+extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
+#define imx53_add_imx2_wdt(id, pdata)	\
+	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 8730cd1..ff55730 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -66,7 +66,7 @@ void __init imx53_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX53);
 	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG_BASE_ADDR));
+	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
 }
 
 int imx51_register_gpios(void);
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index e0aec61..5e07ef2 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -53,6 +53,15 @@ const struct imx_imx2_wdt_data imx51_imx2_wdt_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst = {
+#define imx53_imx2_wdt_data_entry(_id, _hwid)				\
+	imx_imx2_wdt_data_entry(MX53, _id, _hwid, SZ_16K)
+	imx53_imx2_wdt_data_entry(0, 1),
+	imx53_imx2_wdt_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data)
 {
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index d7a8e52..ace1786 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -79,7 +79,7 @@
 #define MX53_GPIO3_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x0008C000)
 #define MX53_GPIO4_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x00090000)
 #define MX53_KPP_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x00094000)
-#define MX53_WDOG_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x00098000)
+#define MX53_WDOG1_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x00098000)
 #define MX53_WDOG2_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x0009C000)
 #define MX53_GPT1_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000A0000)
 #define MX53_SRTC_BASE_ADDR	(MX53_AIPS1_BASE_ADDR + 0x000A4000)
-- 
1.6.0.4
