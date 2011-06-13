From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:25 +0800
Subject: [PATCH 6/6] ARM: mxc: clean up imx-dma device registration
In-Reply-To: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307950645-26529-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch follows the implementation of gpio-mxc device registration
to break the concentrated imx-dma device registration into soc
specific setup function.  Then we can avoid the churn of "#ifdef"
and the cpu_is_mx checking on such a long list, which makes no sense,
considering more soc supports need to be added and we need to support
single image for multiple socs in the long run.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx21.c                    |    3 +
 arch/arm/mach-imx/mm-imx25.c                    |   26 +++
 arch/arm/mach-imx/mm-imx27.c                    |    3 +
 arch/arm/mach-imx/mm-imx31.c                    |   24 +++
 arch/arm/mach-imx/mm-imx35.c                    |   44 +++++
 arch/arm/mach-mx5/mm.c                          |   23 +++
 arch/arm/plat-mxc/devices.c                     |   16 ++-
 arch/arm/plat-mxc/devices/platform-imx-dma.c    |  202 ++---------------------
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +
 9 files changed, 157 insertions(+), 190 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index f0fb8bc..8d27f47 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 #include <mach/irqs.h>
@@ -82,4 +83,6 @@ void __init imx21_soc_init(void)
 	mxc_register_gpio(3, MX21_GPIO4_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
 	mxc_register_gpio(4, MX21_GPIO5_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
 	mxc_register_gpio(5, MX21_GPIO6_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
+
+	imx_add_imx_dma();
 }
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 1b6d583..0c54520 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/mx25.h>
 #include <mach/iomux-v3.h>
@@ -61,10 +62,35 @@ void __init mx25_init_irq(void)
 	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
 }
 
+static struct sdma_script_start_addrs imx25_sdma_script __initdata = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1255,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1120,
+	.per_2_shp_addr = 1329,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1560,
+	.mcu_2_ata_addr = 1479,
+	.app_2_per_addr = 1189,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1407,
+	.shp_2_mcu_addr = 979,
+};
+
+static struct sdma_platform_data imx25_sdma_pdata __initdata = {
+	.sdma_version = 2,
+	.cpu_name = "imx25",
+	.to_version = 1,
+	.script_addrs = &imx25_sdma_script,
+};
+
 void __init imx25_soc_init(void)
 {
 	mxc_register_gpio(0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
 	mxc_register_gpio(1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
 	mxc_register_gpio(2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
 	mxc_register_gpio(3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
+
+	imx_add_imx_sdma(MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
 }
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index d3700ce..47a6ada 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 #include <mach/irqs.h>
@@ -82,4 +83,6 @@ void __init imx27_soc_init(void)
 	mxc_register_gpio(3, MX27_GPIO4_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
 	mxc_register_gpio(4, MX27_GPIO5_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
 	mxc_register_gpio(5, MX27_GPIO6_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
+
+	imx_add_imx_dma();
 }
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index cb16ac6..bc00a2f 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-v3.h>
 #include <mach/irqs.h>
@@ -57,9 +58,32 @@ void __init mx31_init_irq(void)
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 }
 
+static struct sdma_script_start_addrs imx31_to1_sdma_script __initdata = {
+	.per_2_per_addr = 1677,
+};
+
+static struct sdma_script_start_addrs imx31_to2_sdma_script __initdata = {
+	.ap_2_ap_addr = 423,
+	.ap_2_bp_addr = 829,
+	.bp_2_ap_addr = 1029,
+};
+
+static struct sdma_platform_data imx31_sdma_pdata __initdata = {
+	.sdma_version = 1,
+	.cpu_name = "imx31",
+};
+
 void __init imx31_soc_init(void)
 {
+	int to_version = mx31_revision() >> 4;
+
 	mxc_register_gpio(0, MX31_GPIO1_BASE_ADDR, SZ_16K, MX31_INT_GPIO1, 0);
 	mxc_register_gpio(1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
 	mxc_register_gpio(2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
+
+	imx31_sdma_pdata.to_version = to_version;
+	imx31_sdma_pdata.script_addrs =
+		(to_version == 1) ?  &imx31_to1_sdma_script :
+				     &imx31_to2_sdma_script;
+	imx_add_imx_sdma(MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
 }
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index 648bfca..b3a474b 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -25,6 +25,7 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-v3.h>
 #include <mach/irqs.h>
@@ -54,9 +55,52 @@ void __init mx35_init_irq(void)
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
 }
 
+static struct sdma_script_start_addrs imx35_to1_sdma_script __initdata = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.uartsh_2_mcu_addr = 1183,
+	.per_2_shp_addr = 1033,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1333,
+	.mcu_2_ata_addr = 1252,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1111,
+	.shp_2_mcu_addr = 892,
+};
+
+static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1597,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1270,
+	.per_2_shp_addr = 1120,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1429,
+	.mcu_2_ata_addr = 1339,
+	.app_2_per_addr = 1531,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1198,
+	.shp_2_mcu_addr = 979,
+};
+
+static struct sdma_platform_data imx35_sdma_pdata __initdata = {
+	.sdma_version = 2,
+	.cpu_name = "imx35",
+};
+
 void __init imx35_soc_init(void)
 {
+	int to_version = mx35_revision() >> 4;
+
 	mxc_register_gpio(0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
 	mxc_register_gpio(1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
 	mxc_register_gpio(2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+
+	imx35_sdma_pdata.to_version = to_version;
+	imx35_sdma_pdata.script_addrs =
+		(to_version == 1) ?  &imx35_to1_sdma_script :
+				     &imx35_to2_sdma_script;
+	imx_add_imx_sdma(MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
 }
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 800bb8b2..5af490a 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -18,6 +18,7 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
+#include <mach/devices-common.h>
 #include <mach/iomux-v3.h>
 
 /*
@@ -100,12 +101,34 @@ void __init mx53_init_irq(void)
 	tzic_init_irq(tzic_virt);
 }
 
+static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1473,
+	.mcu_2_ata_addr = 1392,
+	.app_2_per_addr = 1033,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1251,
+	.shp_2_mcu_addr = 892,
+};
+
+static struct sdma_platform_data imx51_sdma_pdata __initdata = {
+	.sdma_version = 2,
+	.cpu_name = "imx51",
+	.to_version = 1,
+	.script_addrs = &imx51_sdma_script,
+};
+
 void __init imx51_soc_init(void)
 {
 	mxc_register_gpio(0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
 	mxc_register_gpio(1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
 	mxc_register_gpio(2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
 	mxc_register_gpio(3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
+
+	imx_add_imx_sdma(MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
 }
 
 void __init imx53_soc_init(void)
diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index fb166b2..0d6ed31 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -95,8 +95,22 @@ struct device mxc_aips_bus = {
 	.parent		= &platform_bus,
 };
 
+struct device mxc_ahb_bus = {
+	.init_name	= "mxc_ahb",
+	.parent		= &platform_bus,
+};
+
 static int __init mxc_device_init(void)
 {
-	return device_register(&mxc_aips_bus);
+	int ret;
+
+	ret = device_register(&mxc_aips_bus);
+	if (IS_ERR_VALUE(ret))
+		goto done;
+
+	ret = device_register(&mxc_ahb_bus);
+
+done:
+	return ret;
 }
 core_initcall(mxc_device_init);
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 2091540..2b0fdb2 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -6,205 +6,29 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <linux/compiler.h>
-#include <linux/err.h>
-#include <linux/init.h>
-
-#include <mach/hardware.h>
 #include <mach/devices-common.h>
-#include <mach/sdma.h>
-
-struct imx_imx_sdma_data {
-	resource_size_t iobase;
-	resource_size_t irq;
-	struct sdma_platform_data pdata;
-};
-
-#define imx_imx_sdma_data_entry_single(soc, _sdma_version, _cpu_name, _to_version)\
-	{								\
-		.iobase = soc ## _SDMA ## _BASE_ADDR,			\
-		.irq = soc ## _INT_SDMA,				\
-		.pdata = {						\
-			.sdma_version = _sdma_version,			\
-			.cpu_name = _cpu_name,				\
-			.to_version = _to_version,			\
-		},							\
-	}
-
-#ifdef CONFIG_SOC_IMX25
-struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX25, 2, "imx25", 1);
-#endif /* ifdef CONFIG_SOC_IMX25 */
 
-#ifdef CONFIG_SOC_IMX31
-struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
-	imx_imx_sdma_data_entry_single(MX31, 1, "imx31", 1);
-#endif /* ifdef CONFIG_SOC_IMX31 */
-
-#ifdef CONFIG_SOC_IMX35
-struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
-	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 1);
-#endif /* ifdef CONFIG_SOC_IMX35 */
-
-#ifdef CONFIG_SOC_IMX51
-struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 1);
-#endif /* ifdef CONFIG_SOC_IMX51 */
+struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
+{
+	return platform_device_register_resndata(&mxc_ahb_bus,
+			"imx-dma", -1, NULL, 0, NULL, 0);
+}
 
-static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
-		const struct imx_imx_sdma_data *data)
+struct platform_device __init __maybe_unused *imx_add_imx_sdma(
+	resource_size_t iobase, int irq, struct sdma_platform_data *pdata)
 {
 	struct resource res[] = {
 		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_16K - 1,
+			.start = iobase,
+			.end = iobase + SZ_16K - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
-			.start = data->irq,
-			.end = data->irq,
+			.start = irq,
+			.end = irq,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
 
-	return imx_add_platform_device("imx-sdma", -1,
-			res, ARRAY_SIZE(res),
-			&data->pdata, sizeof(data->pdata));
-}
-
-static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
-{
-	return imx_add_platform_device("imx-dma", -1, NULL, 0, NULL, 0);
-}
-
-#ifdef CONFIG_ARCH_MX25
-static struct sdma_script_start_addrs addr_imx25 = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1255,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1120,
-	.per_2_shp_addr = 1329,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1560,
-	.mcu_2_ata_addr = 1479,
-	.app_2_per_addr = 1189,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1407,
-	.shp_2_mcu_addr = 979,
-};
-#endif
-
-#ifdef CONFIG_SOC_IMX31
-static struct sdma_script_start_addrs addr_imx31_to1 = {
-	.per_2_per_addr = 1677,
-};
-
-static struct sdma_script_start_addrs addr_imx31_to2 = {
-	.ap_2_ap_addr = 423,
-	.ap_2_bp_addr = 829,
-	.bp_2_ap_addr = 1029,
-};
-#endif
-
-#ifdef CONFIG_SOC_IMX35
-static struct sdma_script_start_addrs addr_imx35_to1 = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.uartsh_2_mcu_addr = 1183,
-	.per_2_shp_addr = 1033,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1333,
-	.mcu_2_ata_addr = 1252,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1111,
-	.shp_2_mcu_addr = 892,
-};
-
-static struct sdma_script_start_addrs addr_imx35_to2 = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1597,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1270,
-	.per_2_shp_addr = 1120,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1429,
-	.mcu_2_ata_addr = 1339,
-	.app_2_per_addr = 1531,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1198,
-	.shp_2_mcu_addr = 979,
-};
-#endif
-
-#ifdef CONFIG_SOC_IMX51
-static struct sdma_script_start_addrs addr_imx51 = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1473,
-	.mcu_2_ata_addr = 1392,
-	.app_2_per_addr = 1033,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1251,
-	.shp_2_mcu_addr = 892,
-};
-#endif
-
-static int __init imxXX_add_imx_dma(void)
-{
-	struct platform_device *ret;
-
-#if defined(CONFIG_SOC_IMX21) || defined(CONFIG_SOC_IMX27)
-	if (cpu_is_mx21() || cpu_is_mx27())
-		ret = imx_add_imx_dma();
-	else
-#endif
-
-#if defined(CONFIG_SOC_IMX25)
-	if (cpu_is_mx25()) {
-		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25;
-		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
-	} else
-#endif
-
-#if defined(CONFIG_SOC_IMX31)
-	if (cpu_is_mx31()) {
-		int to_version = mx31_revision() >> 4;
-		imx31_imx_sdma_data.pdata.to_version = to_version;
-		if (to_version == 1)
-			imx31_imx_sdma_data.pdata.script_addrs = &addr_imx31_to1;
-		else
-			imx31_imx_sdma_data.pdata.script_addrs = &addr_imx31_to2;
-		ret = imx_add_imx_sdma(&imx31_imx_sdma_data);
-	} else
-#endif
-
-#if defined(CONFIG_SOC_IMX35)
-	if (cpu_is_mx35()) {
-		int to_version = mx35_revision() >> 4;
-		imx35_imx_sdma_data.pdata.to_version = to_version;
-		if (to_version == 1)
-			imx35_imx_sdma_data.pdata.script_addrs = &addr_imx35_to1;
-		else
-			imx35_imx_sdma_data.pdata.script_addrs = &addr_imx35_to2;
-		ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
-	} else
-#endif
-
-#if defined(CONFIG_SOC_IMX51)
-	if (cpu_is_mx51()) {
-		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51;
-		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
-	} else
-#endif
-		ret = ERR_PTR(-ENODEV);
-
-	if (IS_ERR(ret))
-		return PTR_ERR(ret);
-
-	return 0;
+	return platform_device_register_resndata(&mxc_ahb_bus, "imx-sdma",
+			-1, res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
-arch_initcall(imxXX_add_imx_dma);
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 03f6266..bf93820 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -9,8 +9,10 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <mach/sdma.h>
 
 extern struct device mxc_aips_bus;
+extern struct device mxc_ahb_bus;
 
 struct platform_device *imx_add_platform_device_dmamask(
 		const char *name, int id,
@@ -293,3 +295,7 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+struct platform_device *imx_add_imx_dma(void);
+struct platform_device *imx_add_imx_sdma(
+	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
-- 
1.7.4.1
