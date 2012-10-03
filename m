From: mporter@ti.com (Matt Porter)
Date: Wed,  3 Oct 2012 10:55:31 -0400
Subject: [PATCH v3 4/6] ARM: davinci: add platform hook to fetch the SRAM pool
In-Reply-To: <1349276133-26408-1-git-send-email-mporter@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
Message-ID: <1349276133-26408-5-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds sram_get_gen_pool() which allows platform code to get
the SRAM gen_pool for purposes of providing it in platform
data for driver genalloc use.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-davinci/include/mach/sram.h |    3 +++
 arch/arm/mach-davinci/sram.c              |    5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-davinci/include/mach/sram.h b/arch/arm/mach-davinci/include/mach/sram.h
index 111f7cc..4e5db56 100644
--- a/arch/arm/mach-davinci/include/mach/sram.h
+++ b/arch/arm/mach-davinci/include/mach/sram.h
@@ -24,4 +24,7 @@
 extern void *sram_alloc(size_t len, dma_addr_t *dma);
 extern void sram_free(void *addr, size_t len);
 
+/* Get the struct gen_pool * for use in platform data */
+extern struct gen_pool *sram_get_gen_pool(void);
+
 #endif /* __MACH_SRAM_H */
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index 0e8ca4f..b47b64d 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -18,6 +18,11 @@
 
 static struct gen_pool *sram_pool;
 
+struct gen_pool *sram_get_gen_pool(void)
+{
+	return sram_pool;
+}
+
 void *sram_alloc(size_t len, dma_addr_t *dma)
 {
 	unsigned long vaddr;
-- 
1.7.9.5
