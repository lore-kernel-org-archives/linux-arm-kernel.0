From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 17 Mar 2014 18:39:53 +0530
Subject: [PATCH v2 1/3] ARM: EXYNOS: Map PMU address through DT
In-Reply-To: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1395061795-17777-2-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the PMU details for each SoC, pass this information
through device tree (DT).

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 .../devicetree/bindings/arm/samsung/pmu.txt        |    5 +-
 arch/arm/boot/dts/exynos4.dtsi                     |    5 ++
 arch/arm/boot/dts/exynos5260.dtsi                  |    5 ++
 arch/arm/mach-exynos/common.c                      |   51 +++++++++++++-------
 arch/arm/mach-exynos/include/mach/map.h            |    3 --
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index f1f1552..667a7f0 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -2,14 +2,15 @@ SAMSUNG Exynos SoC series PMU Registers
 
 Properties:
  - compatible : should contain two values. First value must be one from following list:
+		   - "samsung,exynos4210-pmu" - for Exynos4210 and Exynos4x12 SoC,
 		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
-		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos5420-pmu" - for Exynos5420 and Exynos5260 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
 
 Example :
 pmu_system_controller: system-controller at 10040000 {
-	compatible = "samsung,exynos5250-pmu", "syscon";
+	compatible = "samsung,exynos5250-pmu";
 	reg = <0x10040000 0x5000>;
 };
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 08452e1..94cbafa 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -55,6 +55,11 @@
 		#phy-cells = <1>;
 	};
 
+	pmu_system_controller: system-controller at 10020000 {
+		compatible = "samsung,exynos4210-pmu";
+		reg = <0x10020000 0x4000>;
+	};
+
 	pd_mfc: mfc-power-domain at 10023C40 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C40 0x20>;
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index a93fea8..2a4dace 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -264,6 +264,11 @@
 			};
 		};
 
+		pmu_system_controller: system-controller at 10D50000 {
+			compatible = "samsung,exynos5420-pmu";
+			reg = <0x10D50000 0x5000>;
+		};
+
 		pinctrl_0: pinctrl at 11600000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x11600000 0x1000>;
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 1df81ff..c75733b 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -79,11 +79,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_PMU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_PMU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_COMBINER),
 		.length		= SZ_4K,
@@ -157,11 +152,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_CMU),
 		.length		= 144 * SZ_1K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_PMU,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_PMU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
 	},
 };
 
@@ -243,12 +233,12 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 	return 1;
 }
 
-struct __sysram_desc {
+struct __exynos_reg_desc {
 	char name[32];
 	unsigned long addr;
 };
 
-static struct __sysram_desc sysram_desc[] __initdata = {
+static struct __exynos_reg_desc exynos_sysram_desc[] __initdata = {
 	{
 		.name = "samsung,exynos4210-sysram",
 		.addr = (unsigned long)S5P_VA_SYSRAM,
@@ -258,7 +248,20 @@ static struct __sysram_desc sysram_desc[] __initdata = {
 	},
 };
 
-static int __init exynos_fdt_map_sysram(unsigned long node, const char *uname,
+static struct __exynos_reg_desc exynos_pmu_desc[] __initdata = {
+	{
+		.name = "samsung,exynos4210-pmu",
+		.addr = (unsigned long)S5P_VA_PMU,
+	}, {
+		.name = "samsung,exynos5250-pmu",
+		.addr = (unsigned long)S5P_VA_PMU,
+	}, {
+		.name = "samsung,exynos5420-pmu",
+		.addr = (unsigned long)S5P_VA_PMU,
+	},
+};
+
+static int __init exynos_fdt_map_reg(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
@@ -266,12 +269,26 @@ static int __init exynos_fdt_map_sysram(unsigned long node, const char *uname,
 	unsigned long len;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sysram_desc); i++) {
-		if (of_flat_dt_is_compatible(node, sysram_desc[i].name)) {
+	for (i = 0; i < ARRAY_SIZE(exynos_sysram_desc); i++) {
+		if (of_flat_dt_is_compatible(node,
+					exynos_sysram_desc[i].name)) {
+			reg = of_get_flat_dt_prop(node, "reg", &len);
+			if (!reg || len != (sizeof(unsigned long) * 2))
+				return -ENODEV;
+			iodesc.virtual = exynos_sysram_desc[i].addr;
+			iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
+			iodesc.length = be32_to_cpu(reg[1]);
+			iodesc.type = MT_DEVICE;
+			iotable_init(&iodesc, 1);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(exynos_pmu_desc); i++) {
+		if (of_flat_dt_is_compatible(node, exynos_pmu_desc[i].name)) {
 			reg = of_get_flat_dt_prop(node, "reg", &len);
 			if (!reg || len != (sizeof(unsigned long) * 2))
 				return -ENODEV;
-			iodesc.virtual = sysram_desc[i].addr;
+			iodesc.virtual = exynos_pmu_desc[i].addr;
 			iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
 			iodesc.length = be32_to_cpu(reg[1]);
 			iodesc.type = MT_DEVICE;
@@ -298,7 +315,7 @@ void __init exynos_init_io(void)
 
 	exynos_map_io();
 
-	of_scan_flat_dt(exynos_fdt_map_sysram, NULL);
+	of_scan_flat_dt(exynos_fdt_map_reg, NULL);
 }
 
 static void __init exynos_map_io(void)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 548269a..34eee6e 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -28,9 +28,6 @@
 #define EXYNOS4_PA_SYSCON		0x10010000
 #define EXYNOS5_PA_SYSCON		0x10050100
 
-#define EXYNOS4_PA_PMU			0x10020000
-#define EXYNOS5_PA_PMU			0x10040000
-
 #define EXYNOS4_PA_CMU			0x10030000
 #define EXYNOS5_PA_CMU			0x10010000
 
-- 
1.7.9.5
