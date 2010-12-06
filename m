From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 6 Dec 2010 16:38:32 -0200
Subject: [PATCH 1/3] ARM: mx5: add support for the two watchdog modules
Message-ID: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51 has two watchdog modules.

Add support for both of them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/devices-imx51.h               |    6 ++--
 arch/arm/mach-mx5/mm.c                          |    2 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c   |   27 ++++++++++++++--------
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 arch/arm/plat-mxc/include/mach/mx51.h           |    2 +-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 939d2e8..6302e46 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -44,6 +44,6 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
 
-extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data __initconst;
-#define imx51_imx2_wdt_data(pdata)	\
-	imx_add_imx2_wdt_data(&imx51_imx2_wdt_data, pdata)
+extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data[] __initconst;
+#define imx51_add_imx2_wdt(id, pdata)	\
+	imx_add_imx2_wdt(&imx51_imx2_wdt_data[id])
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index e57f968..457f9f9 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -49,7 +49,7 @@ void __init mx51_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG_BASE_ADDR));
+	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
 	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
 }
 
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index 8dc19f6..e0aec61 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -10,40 +10,47 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_imx2_wdt_data_entry_single(soc, _size)			\
+#define imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
-		.iobase = soc ## _WDOG_BASE_ADDR,			\
+		.id = _id,						\
+		.iobase = soc ## _WDOG ## _hwid ## _BASE_ADDR,		\
 		.iosize = _size,					\
 	}
+#define imx_imx2_wdt_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_imx2_wdt_data_entry_single(soc, _id, _hwid, _size)
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX21, SZ_4K);
+	imx_imx2_wdt_data_entry_single(MX21, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
 #ifdef CONFIG_SOC_IMX25
 const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX25, SZ_16K);
+	imx_imx2_wdt_data_entry_single(MX25, 0, , SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX27, SZ_4K);
+	imx_imx2_wdt_data_entry_single(MX27, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_imx2_wdt_data imx31_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX31, SZ_16K);
+	imx_imx2_wdt_data_entry_single(MX31, 0, , SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX35, SZ_16K);
+	imx_imx2_wdt_data_entry_single(MX35, 0, , SZ_16K);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_SOC_IMX51
-const struct imx_imx2_wdt_data imx51_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX51, SZ_16K);
+const struct imx_imx2_wdt_data imx51_imx2_wdt_data[] __initconst = {
+#define imx51_imx2_wdt_data_entry(_id, _hwid)				\
+	imx_imx2_wdt_data_entry(MX51, _id, _hwid, SZ_16K)
+	imx51_imx2_wdt_data_entry(0, 1),
+	imx51_imx2_wdt_data_entry(1, 2),
+};
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_imx2_wdt(
@@ -56,6 +63,6 @@ struct platform_device *__init imx_add_imx2_wdt(
 			.flags = IORESOURCE_MEM,
 		},
 	};
-	return imx_add_platform_device("imx2-wdt", 0,
+	return imx_add_platform_device("imx2-wdt", data->id,
 			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 3640eaf..8658c9c 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -67,6 +67,7 @@ struct platform_device *__init imx_add_imx21_hcd(
 		const struct mx21_usbh_platform_data *pdata);
 
 struct imx_imx2_wdt_data {
+	int id;
 	resource_size_t iobase;
 	resource_size_t iosize;
 };
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 8fddfef..882f1f4 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -61,7 +61,7 @@
 #define MX51_GPIO3_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x8c000)
 #define MX51_GPIO4_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x90000)
 #define MX51_KPP_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x94000)
-#define MX51_WDOG_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x98000)
+#define MX51_WDOG1_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x98000)
 #define MX51_WDOG2_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x9c000)
 #define MX51_GPT1_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0xa0000)
 #define MX51_SRTC_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0xa4000)
-- 
1.6.0.4
