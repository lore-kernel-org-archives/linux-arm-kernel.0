From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  6 May 2014 13:40:23 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM bindings
Message-ID: <1399363824-23543-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the SYSRAM details for each SoC,
pass this information through device tree (DT) and make
the code SoC agnostic. Generic SRAM bindings are used
for achieving this.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
Changes since v1:
* Addressed Tomasz Figa's comments
- Fixed sram node for universal_c210
- Check the node status before mapping the address

This patch is based on linux next (next-20140501) on top of
my Kconfig consolidation patch
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/28642

Tested on 4210/4412 Origen, 5250/5420 Arndale and SMDK5420 boards.
---
 arch/arm/Kconfig                                |    1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   24 +++++++++
 arch/arm/boot/dts/exynos4210.dtsi               |   18 +++++++
 arch/arm/boot/dts/exynos4x12.dtsi               |   18 +++++++
 arch/arm/boot/dts/exynos5250.dtsi               |   18 +++++++
 arch/arm/boot/dts/exynos5420.dtsi               |   18 +++++++
 arch/arm/mach-exynos/common.h                   |    1 +
 arch/arm/mach-exynos/exynos.c                   |   64 -----------------------
 arch/arm/mach-exynos/firmware.c                 |    8 ++-
 arch/arm/mach-exynos/include/mach/map.h         |    7 ---
 arch/arm/mach-exynos/platsmp.c                  |   35 +++++++++++--
 11 files changed, 137 insertions(+), 75 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a6aaaad19b1a..f66ea9453df9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -855,6 +855,7 @@ config ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SAMSUNG_DMADEV
 	select SPARSE_IRQ
+	select SRAM
 	select USE_OF
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 63e34b24b04f..9813b068cfd8 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -28,6 +28,30 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
 	};
 
+	sram at 02020000 {
+		status = "disabled";
+		smp-sram at 0 {
+			status = "disabled";
+		};
+
+		smp-sram at 1f000 {
+			status = "disabled";
+		};
+	};
+
+	sram at 02025000 {
+		compatible = "mmio-sram";
+		reg = <0x02025000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02025000 0x1000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+	};
+
 	mct at 10050000 {
 		compatible = "none";
 	};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf6140dd2f..d3d727b0c263 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,24 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	sram at 02020000 {
+		compatible = "mmio-sram";
+		reg = <0x02020000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02020000 0x20000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+
+		smp-sram at 1f000 {
+			compatible = "samsung,exynos4210-sram-ns";
+			reg = <0x1f000 0x1000>;
+		};
+	};
+
 	pd_lcd1: lcd1-power-domain at 10023CA0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CA0 0x20>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c4a9306f8529..75fb3e7e3999 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -37,6 +37,24 @@
 		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
 	};
 
+	sram at 02020000 {
+		compatible = "mmio-sram";
+		reg = <0x02020000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02020000 0x40000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+
+		smp-sram at 2f000 {
+			compatible = "samsung,exynos4210-sram-ns";
+			reg = <0x2f000 0x1000>;
+		};
+	};
+
 	pd_isp: isp-power-domain at 10023CA0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CA0 0x20>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 37423314a028..8d724d56a5c6 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -72,6 +72,24 @@
 		};
 	};
 
+	sram at 02020000 {
+		compatible = "mmio-sram";
+		reg = <0x02020000 0x30000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02020000 0x30000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+
+		smp-sram at 2f000 {
+			compatible = "samsung,exynos4210-sram-ns";
+			reg = <0x2f000 0x1000>;
+		};
+	};
+
 	pd_gsc: gsc-power-domain at 10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c3a9a66c5767..ff496adfabde 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -110,6 +110,24 @@
 		};
 	};
 
+	sram at 02020000 {
+		compatible = "mmio-sram";
+		reg = <0x02020000 0x54000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02020000 0x54000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+
+		smp-sram at 53000 {
+			compatible = "samsung,exynos4210-sram-ns";
+			reg = <0x53000 0x1000>;
+		};
+	};
+
 	clock: clock-controller at 10010000 {
 		compatible = "samsung,exynos5420-clock";
 		reg = <0x10010000 0x30000>;
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9ef3f83efaff..47cbab0f008e 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -18,6 +18,7 @@
 void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 
 struct map_desc;
+extern void __iomem *sram_ns_base_addr;
 void exynos_init_io(void);
 void exynos_restart(enum reboot_mode mode, const char *cmd);
 void exynos_cpuidle_init(void);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 77293d39dfc9..556d148e6413 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -114,51 +114,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 	},
 };
 
-static struct map_desc exynos4_iodesc0[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4_iodesc1[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4210_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
-		.pfn		= __phys_to_pfn(EXYNOS4210_PA_SYSRAM_NS),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos4x12_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
-		.pfn		= __phys_to_pfn(EXYNOS4x12_PA_SYSRAM_NS),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static struct map_desc exynos5250_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
-		.pfn		= __phys_to_pfn(EXYNOS5250_PA_SYSRAM_NS),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -181,11 +136,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSRAM),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_CMU),
 		.length		= 144 * SZ_1K,
@@ -280,20 +230,6 @@ static void __init exynos_map_io(void)
 
 	if (soc_is_exynos5())
 		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
-
-	if (soc_is_exynos4210()) {
-		if (samsung_rev() == EXYNOS4210_REV_0)
-			iotable_init(exynos4_iodesc0,
-						ARRAY_SIZE(exynos4_iodesc0));
-		else
-			iotable_init(exynos4_iodesc1,
-						ARRAY_SIZE(exynos4_iodesc1));
-		iotable_init(exynos4210_iodesc, ARRAY_SIZE(exynos4210_iodesc));
-	}
-	if (soc_is_exynos4212() || soc_is_exynos4412())
-		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
-	if (soc_is_exynos5250())
-		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
 }
 
 void __init exynos_init_io(void)
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 932129ef26c6..7d583cb73850 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -18,6 +18,7 @@
 
 #include <mach/map.h>
 
+#include "common.h"
 #include "smc.h"
 
 static int exynos_do_idle(void)
@@ -34,7 +35,12 @@ static int exynos_cpu_boot(int cpu)
 
 static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
-	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
+	void __iomem *boot_reg;
+
+	if (!sram_ns_base_addr)
+		return 0;
+
+	boot_reg = sram_ns_base_addr + 0x1c + 4*cpu;
 
 	__raw_writel(boot_addr, boot_reg);
 	return 0;
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 7b046b59d9ec..548269a60634 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -23,13 +23,6 @@
 
 #include <plat/map-s5p.h>
 
-#define EXYNOS4_PA_SYSRAM0		0x02025000
-#define EXYNOS4_PA_SYSRAM1		0x02020000
-#define EXYNOS5_PA_SYSRAM		0x02020000
-#define EXYNOS4210_PA_SYSRAM_NS		0x0203F000
-#define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
-#define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
-
 #define EXYNOS_PA_CHIPID		0x10000000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 03e5e9f94705..ccbcdd7b8a86 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -33,11 +34,35 @@
 
 extern void exynos4_secondary_startup(void);
 
+static void __iomem *sram_base_addr;
+void __iomem *sram_ns_base_addr;
+
+static void __init exynos_smp_prepare_sram(void)
+{
+	struct device_node *node;
+
+	for_each_compatible_node(node, NULL, "samsung,exynos4210-sram") {
+		if (of_device_is_available(node)) {
+			sram_base_addr = of_iomap(node, 0);
+			if (!sram_base_addr)
+				pr_err("Secondary CPU boot address not found\n");
+		}
+	}
+
+	for_each_compatible_node(node, NULL, "samsung,exynos4210-sram-ns") {
+		if (of_device_is_available(node)) {
+			sram_ns_base_addr = of_iomap(node, 0);
+			if (!sram_ns_base_addr)
+				pr_err("Secondary CPU boot address not found\n");
+		}
+	}
+}
+
 static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
 		return S5P_INFORM5;
-	return S5P_VA_SYSRAM;
+	return sram_base_addr;
 }
 
 static inline void __iomem *cpu_boot_reg(int cpu)
@@ -147,7 +172,8 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 * and fall back to boot register if it fails.
 		 */
 		if (call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr))
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			if (cpu_boot_reg_base())
+				__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
 
 		call_firmware_op(cpu_boot, phys_cpu);
 
@@ -205,6 +231,8 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(scu_base_addr());
 
+	exynos_smp_prepare_sram();
+
 	/*
 	 * Write the address of secondary startup into the
 	 * system-wide flags register. The boot monitor waits
@@ -222,7 +250,8 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 		boot_addr = virt_to_phys(exynos4_secondary_startup);
 
 		if (call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr))
-			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+			if (cpu_boot_reg_base())
+				__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
 	}
 }
 
-- 
1.7.9.5
