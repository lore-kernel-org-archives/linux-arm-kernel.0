From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 13:58:57 +0000
Subject: [PATCH] ARM: Set bit 22 in the PL310 (cache controller) AuxCtlr
	register
Message-ID: <1290002337-652-1-git-send-email-catalin.marinas@arm.com>
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

This patch ensures that bit 22 is set in the l2x0_init() function if
PL310 and not rely on the platform code to specify it. It also modifies
the 'aux' variable only if the actual register is written so that the
final printk displays the real hardware value.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..38dfb86 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -274,9 +274,6 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
-	aux &= aux_mask;
-	aux |= aux_val;
-
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
@@ -285,6 +282,13 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 		else
 			ways = 8;
 		type = "L310";
+
+		/*
+		 * Set bit 22 in the auxiliary control register. If this bit
+		 * is cleared, PL310 treats Normal Shared Non-cacheable
+		 * accesses as Cacheable no-allocate.
+		 */
+		aux_val |= 1 << 22;
 		break;
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
@@ -312,6 +316,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	 * accessing the below registers will fault.
 	 */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		aux &= aux_mask;
+		aux |= aux_val;
 
 		/* l2x0 controller is disabled */
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
