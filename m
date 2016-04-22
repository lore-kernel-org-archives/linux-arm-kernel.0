From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 22 Apr 2016 12:43:35 +0100
Subject: [PATCH 2/3] ARM: nommu: change memory reserve for the vectors
In-Reply-To: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461325416-29570-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Commit 19accfd3 (ARM: move vector stubs) moved the vector stubs in an
additional page above the base vector one. This change wasn't taken into
account by the nommu memreserve.
This patch ensures that the kernel won't overwrite any vector stub on
nommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[changed the MPU side too]
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S |    2 +-
 arch/arm/mm/nommu.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 9b8c5a1..fb1a69e 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -236,7 +236,7 @@ ENTRY(__setup_mpu)
 	mov	r0, #CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
 	ldr	r5,=(MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL)
 	/* Writing N to bits 5:1 (RSR_SZ) --> region size 2^N+1 */
-	mov	r6, #(((PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
+	mov	r6, #(((2 * PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
 
 	setup_region r0, r5, r6, MPU_DATA_SIDE	@ VECTORS_BASE, PL0 NA, enabled
 	beq	3f				@ Memory-map not unified
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 4d113fc..d5805e4 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -286,7 +286,7 @@ void __init arm_mm_memblock_reserve(void)
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
-	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
+	memblock_reserve(CONFIG_VECTORS_BASE, 2 * PAGE_SIZE);
 #else /* ifndef CONFIG_CPU_V7M */
 	/*
 	 * There is no dedicated vector page on V7-M. So nothing needs to be
-- 
1.7.9.5
