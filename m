From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:19 -0400
Subject: [PATCH 08/19] ARM: mach-tegra: remove arch specific special handling
	for ioremap
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-9-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

A generic version should replace this later.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-tegra/include/mach/io.h |    6 ------
 arch/arm/mach-tegra/io.c              |   21 ---------------------
 2 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index 4cea2230c8..67fcb38c09 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -65,12 +65,6 @@
 
 #ifndef __ASSEMBLER__
 
-#define __arch_ioremap		tegra_ioremap
-#define __arch_iounmap		tegra_iounmap
-
-void __iomem *tegra_ioremap(unsigned long phys, size_t size, unsigned int type);
-void tegra_iounmap(volatile void __iomem *addr);
-
 #define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
 
 #ifdef CONFIG_TEGRA_PCI
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index ea50fe28cf..d9d517dc4c 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -60,24 +60,3 @@ void __init tegra_map_common_io(void)
 {
 	iotable_init(tegra_io_desc, ARRAY_SIZE(tegra_io_desc));
 }
-
-/*
- * Intercept ioremap() requests for addresses in our fixed mapping regions.
- */
-void __iomem *tegra_ioremap(unsigned long p, size_t size, unsigned int type)
-{
-	void __iomem *v = IO_ADDRESS(p);
-	if (v == NULL)
-		v = __arm_ioremap(p, size, type);
-	return v;
-}
-EXPORT_SYMBOL(tegra_ioremap);
-
-void tegra_iounmap(volatile void __iomem *addr)
-{
-	unsigned long virt = (unsigned long)addr;
-
-	if (virt >= VMALLOC_START && virt < VMALLOC_END)
-		__iounmap(addr);
-}
-EXPORT_SYMBOL(tegra_iounmap);
-- 
1.7.7-rc0
