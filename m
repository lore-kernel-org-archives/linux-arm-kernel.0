From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 08 Sep 2010 17:56:11 +0100
Subject: [PATCH] ARM: VExpress: Set bit 22 in the PL310 (cache controller)
	AuxCtlr register
Message-ID: <20100908165611.15410.80888.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clearing bit 22 in the PL310 Auxiliary Control register (shared
attribute override enable) has the side effect of transforming Normal
Shared Non-cacheable reads into Cacheable no-allocate reads.

Coherent DMA buffers in Linux always have a Cacheable alias via the
kernel linear mapping and the processor can speculatively load cache
lines into the PL310 controller. With bit 22 cleared, Non-cacheable
reads would unexpectedly hit such cache lines leading to buffer
corruption.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: <stable@kernel.org>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6353459..d6dd6f6 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -225,7 +225,7 @@ static void ct_ca9x4_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	l2x0_init(MMIO_P2V(CT_CA9X4_L2CC), 0x00000000, 0xfe0fffff);
+	l2x0_init(MMIO_P2V(CT_CA9X4_L2CC), 0x00400000, 0xfe0fffff);
 #endif
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
