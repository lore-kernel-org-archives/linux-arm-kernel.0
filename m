From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 13:41:28 +0530
Subject: [PATCH 2/3] ARM: Exynos4: Add ioremap interceptor for statically
	remapped regions
In-Reply-To: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318234289-22041-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ioremap() request for statically remapped regions are intercepted and the
statically assigned virtual address is returned. For requests for which
there are no statically remapped regions, the requests are let through.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/cpu.c             |   16 ++++++++++++++++
 arch/arm/mach-exynos4/include/mach/io.h |    4 ++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 5b1765b..358624d 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -137,6 +137,22 @@ static struct map_desc exynos4_iodesc1[] __initdata = {
 	},
 };
 
+/*
+ * For all ioremap requests of statically mapped regions, intercept ioremap and
+ * return virtual address from the iodesc table.
+ */
+void __iomem *exynos4_ioremap(unsigned long phy, size_t size, unsigned int type)
+{
+	struct map_desc *desc = exynos4_iodesc;
+	unsigned int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(exynos4_iodesc); idx++, desc++)
+		if (desc->pfn == __phys_to_pfn(phy) && desc->type == type)
+			return (void __iomem *)desc->virtual;
+
+	return __arm_ioremap(phy, size, type);
+}
+
 static void exynos4_idle(void)
 {
 	if (!need_resched())
diff --git a/arch/arm/mach-exynos4/include/mach/io.h b/arch/arm/mach-exynos4/include/mach/io.h
index d5478d2..33c2890 100644
--- a/arch/arm/mach-exynos4/include/mach/io.h
+++ b/arch/arm/mach-exynos4/include/mach/io.h
@@ -22,5 +22,10 @@
 #define __mem_pci(a)	(a)
 
 #define IO_SPACE_LIMIT (0xFFFFFFFF)
+#define __arch_ioremap	exynos4_ioremap
+#define __arch_iounmap	__iounmap
+
+void __iomem *exynos4_ioremap(unsigned long phy, size_t size,
+					unsigned int type);
 
 #endif /* __ASM_ARM_ARCH_IO_H */
-- 
1.6.6.rc2
