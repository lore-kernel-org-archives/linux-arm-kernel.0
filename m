From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Sat, 14 Aug 2010 18:30:40 +0900
Subject: [PATCH] fix ARCH_IXP4XX compile error
Message-ID: <20100814182909O.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 4fa5518c65df7a2c4b6c58061ac53d0b01228042 breaks
CONFIG_ARCH_IXP4XX:

linux-2.6/arch/arm/mach-ixp4xx/common-pci.c:340: error: redefinition of 'dma_needs_bounce'
linux-2.6/arch/arm/include/asm/dma-mapping.h:294: note: previous definition of 'dma_needs_bounce' was here
make[2]: *** [arch/arm/mach-ixp4xx/common-pci.o] Error 1

This is a safe option. Can we remove dma_needs_bounce in common-pci.c
too?

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/arm/include/asm/dma-mapping.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c226fe1..2c763bc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -288,7 +288,7 @@ extern void dmabounce_unregister_dev(struct device *);
  * DMA access and 1 if the buffer needs to be bounced.
  *
  */
-#ifdef CONFIG_SA1111
+#if defined(CONFIG_SA1111) || defined(CONFIG_ARCH_IXP4XX)
 extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
 #else
 static inline int dma_needs_bounce(struct device *dev, dma_addr_t addr,
-- 
1.6.5
