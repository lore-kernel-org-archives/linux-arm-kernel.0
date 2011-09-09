From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 9 Sep 2011 17:17:47 +0800
Subject: [PATCH v4 1/3] ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
In-Reply-To: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
References: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1315559869-24838-2-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need one seperate file to deal with i.mx50
related stuff, which is very similar with i.mx51/53.
We can put it together into one file.So, just merge
function from mm-mx50.c to mm.c and remove mm-mx50.c

No function change by this commit.

Signed-off-by: Jason Liu <jason.hui@linaro.org>

---
v1:arrage code(mm.c) layout by the sequence:mx50,mx51,mx51
---
 arch/arm/mach-mx5/Makefile  |    1 -
 arch/arm/mach-mx5/mm-mx50.c |   72 -------------------------------------------
 arch/arm/mach-mx5/mm.c      |   48 +++++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 383e7cd..60f756d 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -4,7 +4,6 @@
 
 # Object file lists.
 obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o ehci.o system.o
-obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
 
 obj-$(CONFIG_PM) += pm-imx5.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
deleted file mode 100644
index 77e374c..0000000
--- a/arch/arm/mach-mx5/mm-mx50.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Create static mapping between physical to virtual memory.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/hardware.h>
-#include <mach/common.h>
-#include <mach/iomux-v3.h>
-#include <mach/irqs.h>
-
-/*
- * Define the MX50 memory map.
- */
-static struct map_desc mx50_io_desc[] __initdata = {
-	imx_map_entry(MX50, TZIC, MT_DEVICE),
-	imx_map_entry(MX50, SPBA0, MT_DEVICE),
-	imx_map_entry(MX50, AIPS1, MT_DEVICE),
-	imx_map_entry(MX50, AIPS2, MT_DEVICE),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx50_map_io(void)
-{
-	iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
-}
-
-void __init imx50_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX50);
-	mxc_iomux_v3_init(MX50_IO_ADDRESS(MX50_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX50_IO_ADDRESS(MX50_WDOG_BASE_ADDR));
-}
-
-void __init mx50_init_irq(void)
-{
-	tzic_init_irq(MX50_IO_ADDRESS(MX50_TZIC_BASE_ADDR));
-}
-
-void __init imx50_soc_init(void)
-{
-	/* i.mx50 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
-	mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
-	mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
-}
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index baea6e5..999f0d3 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -22,6 +22,16 @@
 #include <mach/iomux-v3.h>
 
 /*
+ * Define the MX50 memory map.
+ */
+static struct map_desc mx50_io_desc[] __initdata = {
+	imx_map_entry(MX50, TZIC, MT_DEVICE),
+	imx_map_entry(MX50, SPBA0, MT_DEVICE),
+	imx_map_entry(MX50, AIPS1, MT_DEVICE),
+	imx_map_entry(MX50, AIPS2, MT_DEVICE),
+};
+
+/*
  * Define the MX51 memory map.
  */
 static struct map_desc mx51_io_desc[] __initdata = {
@@ -46,11 +56,28 @@ static struct map_desc mx53_io_desc[] __initdata = {
  * system startup to create static physical to virtual memory mappings
  * for the IO modules.
  */
+void __init mx50_map_io(void)
+{
+	iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
+}
+
 void __init mx51_map_io(void)
 {
 	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
 }
 
+void __init mx53_map_io(void)
+{
+	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
+}
+
+void __init imx50_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX50);
+	mxc_iomux_v3_init(MX50_IO_ADDRESS(MX50_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX50_IO_ADDRESS(MX50_WDOG_BASE_ADDR));
+}
+
 void __init imx51_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX51);
@@ -58,11 +85,6 @@ void __init imx51_init_early(void)
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
 }
 
-void __init mx53_map_io(void)
-{
-	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
-}
-
 void __init imx53_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX53);
@@ -70,6 +92,11 @@ void __init imx53_init_early(void)
 	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
 }
 
+void __init mx50_init_irq(void)
+{
+	tzic_init_irq(MX50_IO_ADDRESS(MX50_TZIC_BASE_ADDR));
+}
+
 void __init mx51_init_irq(void)
 {
 	unsigned long tzic_addr;
@@ -138,6 +165,17 @@ static struct sdma_platform_data imx53_sdma_pdata __initdata = {
 	.script_addrs = &imx53_sdma_script,
 };
 
+void __init imx50_soc_init(void)
+{
+	/* i.mx50 has the i.mx31 type gpio */
+	mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
+	mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
+	mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
+	mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
+	mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
+	mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
+}
+
 void __init imx51_soc_init(void)
 {
 	/* i.mx51 has the i.mx31 type gpio */
-- 
1.7.4.1
