From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:51 -0700
Subject: [PATCH v2 01/14] ARM: tegra: annotate IO_*_VIRT pointers
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide __iomem annotation for IO_*_VIRT pointers, which will propagate
up through IO_TO_VIRT(). Also fixes a 0 to NULL conversion of the base
case to silence sparse.

Unfortunately map_desc takes an unsigned long for the pointer instead of
a void __iomem *. For now, cast explicitly for those cases.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/include/mach/io.h |   18 ++++++++++++------
 arch/arm/mach-tegra/io.c              |    8 ++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index 4cea2230..971be4b 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -33,20 +33,26 @@
  *
  */
 
+#ifdef __ASSEMBLY__
+#define __IOVADDR(x)	(x)
+#else
+#define __IOVADDR(x)	((void __force __iomem *)(x))
+#endif
+
 #define IO_IRAM_PHYS	0x40000000
-#define IO_IRAM_VIRT	0xFE400000
+#define IO_IRAM_VIRT	__IOVADDR(0xFE400000)
 #define IO_IRAM_SIZE	SZ_256K
 
 #define IO_CPU_PHYS     0x50040000
-#define IO_CPU_VIRT     0xFE000000
+#define IO_CPU_VIRT     __IOVADDR(0xFE000000)
 #define IO_CPU_SIZE	SZ_16K
 
 #define IO_PPSB_PHYS	0x60000000
-#define IO_PPSB_VIRT	0xFE200000
+#define IO_PPSB_VIRT	__IOVADDR(0xFE200000)
 #define IO_PPSB_SIZE	SZ_1M
 
 #define IO_APB_PHYS	0x70000000
-#define IO_APB_VIRT	0xFE300000
+#define IO_APB_VIRT	__IOVADDR(0xFE300000)
 #define IO_APB_SIZE	SZ_1M
 
 #define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
@@ -61,7 +67,7 @@
 		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
 	IO_TO_VIRT_BETWEEN((n), IO_IRAM_PHYS, IO_IRAM_SIZE) ?		\
 		IO_TO_VIRT_XLATE((n), IO_IRAM_PHYS, IO_IRAM_VIRT) :	\
-	0)
+	NULL)
 
 #ifndef __ASSEMBLER__
 
@@ -71,7 +77,7 @@
 void __iomem *tegra_ioremap(unsigned long phys, size_t size, unsigned int type);
 void tegra_iounmap(volatile void __iomem *addr);
 
-#define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
+#define IO_ADDRESS(n) (IO_TO_VIRT(n))
 
 #ifdef CONFIG_TEGRA_PCI
 extern void __iomem *tegra_pcie_io_base;
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index ea50fe2..5489f8b 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -31,25 +31,25 @@
 
 static struct map_desc tegra_io_desc[] __initdata = {
 	{
-		.virtual = IO_PPSB_VIRT,
+		.virtual = (unsigned long)IO_PPSB_VIRT,
 		.pfn = __phys_to_pfn(IO_PPSB_PHYS),
 		.length = IO_PPSB_SIZE,
 		.type = MT_DEVICE,
 	},
 	{
-		.virtual = IO_APB_VIRT,
+		.virtual = (unsigned long)IO_APB_VIRT,
 		.pfn = __phys_to_pfn(IO_APB_PHYS),
 		.length = IO_APB_SIZE,
 		.type = MT_DEVICE,
 	},
 	{
-		.virtual = IO_CPU_VIRT,
+		.virtual = (unsigned long)IO_CPU_VIRT,
 		.pfn = __phys_to_pfn(IO_CPU_PHYS),
 		.length = IO_CPU_SIZE,
 		.type = MT_DEVICE,
 	},
 	{
-		.virtual = IO_IRAM_VIRT,
+		.virtual = (unsigned long)IO_IRAM_VIRT,
 		.pfn = __phys_to_pfn(IO_IRAM_PHYS),
 		.length = IO_IRAM_SIZE,
 		.type = MT_DEVICE,
-- 
1.7.4.1
