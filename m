From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 11:11:22 +0000
Subject: [PATCH] ARM: Use the correct NOP size in memmove for Thumb-2 kernel
	builds
Message-ID: <20100326111122.1066.8244.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling the kernel to Thumb-2, using a 16-bit NOP in the
memmove() implementation causes the preceding ADD PC instruction to
branch incorrectly in the middle of a 32-bit LDR or STR instruction. The
memmove() code is no similar to the memcpy() template.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/lib/memmove.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 5025c86..938fc14 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -74,7 +74,7 @@ ENTRY(memmove)
 		rsb	ip, ip, #32
 		addne	pc, pc, ip		@ C is always clear here
 		b	7f
-6:		nop
+6:		W(nop)
 		W(ldr)	r3, [r1, #-4]!
 		W(ldr)	r4, [r1, #-4]!
 		W(ldr)	r5, [r1, #-4]!
@@ -85,7 +85,7 @@ ENTRY(memmove)
 
 		add	pc, pc, ip
 		nop
-		nop
+		W(nop)
 		W(str)	r3, [r0, #-4]!
 		W(str)	r4, [r0, #-4]!
 		W(str)	r5, [r0, #-4]!
