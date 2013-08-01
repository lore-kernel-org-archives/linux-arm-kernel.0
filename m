From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 1 Aug 2013 22:40:47 +0200
Subject: [PATCH] ARM: dma-mapping: highbank: Restrict DMA to 32-bit addresses
Message-ID: <20130801204047.GY20842@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Some devices on Calxeda ECX-2000 are restricted to 32-bit DMA. Thus
the platform needs to set dma_zone_size, otherwise dma-mapping code is
complaining, e.g.

  calxedaxgmac fff50000.ethernet: coherent DMA mask 0xffffffff is smaller than system
    GFP_DMA mask 0xffffffffffffffff

Same is true for sata_highbank. For the latter dma_coherent_mask could
be increased but due to the lack of DMA32 zone we need to adapt
arm_dma_limit in general.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig    |    1 +
 arch/arm/mach-highbank/highbank.c |    3 +++
 arch/arm/mm/dma-mapping.c         |    4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index cd9fcb1..efe4961 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -18,3 +18,4 @@ config ARCH_HIGHBANK
 	select PL320_MBOX
 	select SPARSE_IRQ
 	select USE_OF
+	select ZONE_DMA if ARM_LPAE
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8881579..31b26de 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -176,6 +176,9 @@ static const char *highbank_match[] __initconst = {
 };
 
 DT_MACHINE_START(HIGHBANK, "Highbank")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= DMA_BIT_MASK(32),
+#endif
 	.smp		= smp_ops(highbank_smp_ops),
 	.init_irq	= highbank_init_irq,
 	.init_time	= highbank_timer_init,
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7f9b179..f404dfc 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -651,7 +651,11 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (!mask)
 		return NULL;
 
+#ifdef CONFIG_ARM_LPAE
+	if (mask <= 0xffffffffULL)
+#else
 	if (mask < 0xffffffffULL)
+#endif
 		gfp |= GFP_DMA;
 
 	/*
-- 
1.7.9.5
