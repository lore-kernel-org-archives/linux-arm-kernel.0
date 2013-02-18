From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:24:58 +0530
Subject: [PATCH 1/2] ARM: Exynos: Create virtual I/O mapping for Chip-ID
 controller using device tree
In-Reply-To: <1361174099-18749-1-git-send-email-thomas.abraham@linaro.org>
References: <1361174099-18749-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361174099-18749-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On device tree enabled exynos platforms, retrieve the physical base address
of the chip-id controller from device tree and create a virtual I/O mapping
for the chip-id controller. This helps to remove the chip-id controller entry
from the statically defined I/O mapping tables.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../arm/samsung/samsung,exynos4210-chipid.txt      |   15 ++++++
 arch/arm/mach-exynos/common.c                      |   53 +++++++++++---------
 arch/arm/mach-exynos/include/mach/map.h            |    1 -
 3 files changed, 45 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung,exynos4210-chipid.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung,exynos4210-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/samsung,exynos4210-chipid.txt
new file mode 100644
index 0000000..becb2ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung,exynos4210-chipid.txt
@@ -0,0 +1,15 @@
+* Samsung Exynos4/5 Chip-ID controller
+
+Samsung's Exynos4/5 architectures include a chipid controller which can be used
+to determine the product id and revision.
+
+Required properties:
+- compatible: should be "samsung,exynos4210-chipid".
+- reg: Base address and size of the chip-id controller registers.
+
+Example:
+
+	chipid at 10000000 {
+		compatible = "samsung,exynos4210-chipid";
+		reg = <0x10000000 0x100>;
+	};
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4ce342e..208dcf0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -121,17 +121,6 @@ static struct map_desc exynos_iodesc[] __initdata = {
 	},
 };
 
-#ifdef CONFIG_ARCH_EXYNOS5
-static struct map_desc exynos5440_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CHIPID,
-		.pfn		= __phys_to_pfn(EXYNOS5440_PA_CHIPID),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-#endif
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -354,6 +343,31 @@ void __init exynos_init_late(void)
 	exynos_pm_late_initcall();
 }
 
+#ifdef CONFIG_OF
+int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
+					int depth, void *data)
+{
+	struct map_desc iodesc;
+	__be32 *reg;
+	unsigned long len;
+
+	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
+		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "reg", &len);
+	if (reg == NULL || len != (sizeof(unsigned long) * 2))
+		return 0;
+
+	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
+	iodesc.length = be32_to_cpu(reg[1]) - 1;
+	iodesc.virtual = (unsigned long)S5P_VA_CHIPID;
+	iodesc.type = MT_DEVICE;
+	iotable_init(&iodesc, 1);
+	return 1;
+}
+#endif
+
 /*
  * exynos_map_io
  *
@@ -362,19 +376,12 @@ void __init exynos_init_late(void)
 
 void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
-	struct map_desc *iodesc = exynos_iodesc;
-	int iodesc_sz = ARRAY_SIZE(exynos_iodesc);
-#if defined(CONFIG_OF) && defined(CONFIG_ARCH_EXYNOS5)
-	unsigned long root = of_get_flat_dt_root();
-
-	/* initialize the io descriptors we need for initialization */
-	if (of_flat_dt_is_compatible(root, "samsung,exynos5440")) {
-		iodesc = exynos5440_iodesc;
-		iodesc_sz = ARRAY_SIZE(exynos5440_iodesc);
-	}
+#ifdef CONFIG_OF
+	if (initial_boot_params)
+		of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
+	else
 #endif
-
-	iotable_init(iodesc, iodesc_sz);
+		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
 
 	if (mach_desc)
 		iotable_init(mach_desc, size);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index b8ea67e..ac73b27 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -56,7 +56,6 @@
 #define EXYNOS4_PA_ONENAND_DMA		0x0C600000
 
 #define EXYNOS_PA_CHIPID		0x10000000
-#define EXYNOS5440_PA_CHIPID		0x00160000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
 #define EXYNOS5_PA_SYSCON		0x10050100
-- 
1.7.5.4
