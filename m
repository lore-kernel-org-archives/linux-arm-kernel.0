From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 6 Jan 2010 15:12:27 +0100
Subject: [RFC][PATCH] uncompress: use correct cache configuration for
	ARM11[57]6 and 11MP
Message-ID: <20100106151227.24f5ca03@life-in-the-fast-lane>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arch/arm/boot/compressed/head.S, the entry for ARMv6 configuration
matches ARM1136 (0x7b). This does not work very nicely with other
ARM11 cores (1156, 1176 and 11MP) which have 0xf in the Architectural
format description, and end up matching the ARMv7 entry.

This patch adds the required entry for these SoCs.

Tested on s3c6410 and s5p6440 (both ARM1176).

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/boot/compressed/head.S |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d356af7..2f04f49 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -737,7 +737,13 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
 
-		.word	0x0007b000		@ ARMv6
+		.word	0x0007b000		@ ARMv6 (1136)
+		.word	0x000ff000
+		W(b)	__armv4_mmu_cache_on
+		W(b)	__armv4_mmu_cache_off
+		W(b)	__armv6_mmu_cache_flush
+
+		.word	0x000fb000		@ ARMv6 (11[57]6, 11MP)
 		.word	0x000ff000
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
-- 
1.5.6.3



-- 
Fast. Cheap. Reliable. Pick two.
