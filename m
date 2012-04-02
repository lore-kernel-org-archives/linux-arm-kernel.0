From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  2 Apr 2012 12:13:57 -0700
Subject: [PATCH] ARM: EXYNOS: fix CONFIG_DEBUG_LL
Message-ID: <1333394037-19349-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

addruart cannot read from the physical address of the chipid
register, that will fail as soon as the mmu is turned on.
Fixing it to read from the physical or virtual address depending
on the mmu state also does not work, because there is a period
between head.S and exynos_map_io where the mmu is on, the uart
is mapped and used, but the chipid mapping is not yet present.

Fix addruart to use the ARM Main ID cp15 register to determine
if the core is Cortex A15 (EXYNOS5) or not (EXYNOS4).

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/include/mach/debug-macro.S |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/debug-macro.S b/arch/arm/mach-exynos/include/mach/debug-macro.S
index 6c857ff..e0c86ea 100644
--- a/arch/arm/mach-exynos/include/mach/debug-macro.S
+++ b/arch/arm/mach-exynos/include/mach/debug-macro.S
@@ -21,10 +21,9 @@
 	 */
 
 	.macro addruart, rp, rv, tmp
-		mov	\rp, #0x10000000
-		ldr	\rp, [\rp, #0x0]
-		and	\rp, \rp, #0xf00000
-		teq	\rp, #0x500000		@@ EXYNOS5
+		mrc	p15, 0, \tmp, c0, c0, 0
+		and	\tmp, \tmp, #0xf0
+		teq	\tmp, #0xf0		@@ A15
 		ldreq	\rp, =EXYNOS5_PA_UART
 		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
 		ldr	\rv, =S3C_VA_UART
-- 
1.7.2.3
