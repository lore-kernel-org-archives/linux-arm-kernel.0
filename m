From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Aug 2013 17:50:07 -0500
Subject: [PATCH 3/5] ARM: highbank: enable DMA zone for LPAE
In-Reply-To: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375743009-28972-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Some devices are restricted to 32-bit DMA. Thus the platform dma_zone_size
needs to be set. Otherwise dma-mapping code is complaining, e.g.

calxedaxgmac fff50000.ethernet: coherent DMA mask 0xffffffff is smaller
than system GFP_DMA mask 0xffffffffffffffff

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig    | 1 +
 arch/arm/mach-highbank/highbank.c | 3 +++
 2 files changed, 4 insertions(+)

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
index 8881579..1894dcf 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -176,6 +176,9 @@ static const char *highbank_match[] __initconst = {
 };
 
 DT_MACHINE_START(HIGHBANK, "Highbank")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= (4ULL * SZ_1G),
+#endif
 	.smp		= smp_ops(highbank_smp_ops),
 	.init_irq	= highbank_init_irq,
 	.init_time	= highbank_timer_init,
-- 
1.8.1.2
