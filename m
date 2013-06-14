From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:59 +0200
Subject: [PATCH 23/28] ARM: SAMSUNG: Make legacy MFC support code depend on
 SAMSUNG_ATAGS
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-24-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to bypass compilation of static platform device and resource
definitions that require interrupts and base addresses to be defined
statically.

Cc: Kamil Debski <k.debski@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/s5p-dev-mfc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/s5p-dev-mfc.c b/arch/arm/plat-samsung/s5p-dev-mfc.c
index a93fb6f..ad51f85 100644
--- a/arch/arm/plat-samsung/s5p-dev-mfc.c
+++ b/arch/arm/plat-samsung/s5p-dev-mfc.c
@@ -17,10 +17,12 @@
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 
+#include <plat/mfc.h>
+
+#ifdef CONFIG_SAMSUNG_ATAGS
 #include <mach/map.h>
 #include <mach/irqs.h>
 #include <plat/devs.h>
-#include <plat/mfc.h>
 
 static struct resource s5p_mfc_resource[] = {
 	[0] = DEFINE_RES_MEM(S5P_PA_MFC, SZ_64K),
@@ -61,6 +63,10 @@ struct platform_device s5p_device_mfc_r = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
+#else
+static struct platform_device s5p_device_mfc_l;
+static struct platform_device s5p_device_mfc_r;
+#endif
 
 struct s5p_mfc_reserved_mem {
 	phys_addr_t	base;
@@ -70,6 +76,7 @@ struct s5p_mfc_reserved_mem {
 
 static struct s5p_mfc_reserved_mem s5p_mfc_mem[2] __initdata;
 
+
 void __init s5p_mfc_reserve_mem(phys_addr_t rbase, unsigned int rsize,
 				phys_addr_t lbase, unsigned int lsize)
 {
@@ -93,6 +100,7 @@ void __init s5p_mfc_reserve_mem(phys_addr_t rbase, unsigned int rsize,
 	}
 }
 
+#ifdef CONFIG_SAMSUNG_ATAGS
 static int __init s5p_mfc_memory_init(void)
 {
 	int i;
@@ -111,6 +119,7 @@ static int __init s5p_mfc_memory_init(void)
 	return 0;
 }
 device_initcall(s5p_mfc_memory_init);
+#endif
 
 #ifdef CONFIG_OF
 int __init s5p_fdt_find_mfc_mem(unsigned long node, const char *uname,
-- 
1.8.2.1
