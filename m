From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 16:55:40 +0100
Subject: [PATCH v2 6/6] ARM: bitops: prefetch the destination word for write
 prior to strex
In-Reply-To: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
References: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374767740-2068-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cost of changing a cacheline from shared to exclusive state can be
significant, especially when this is triggered by an exclusive store,
since it may result in having to retry the transaction.

This patch prefixes our atomic bitops implementation with prefetchw,
to try and grab the line in exclusive state from the start. The testop
macro is left alone, since the barrier semantics limit the usefulness
of prefetching data.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/lib/bitops.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index d6408d1..e0c68d5 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -10,6 +10,11 @@ UNWIND(	.fnstart	)
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
 	add	r1, r1, r0, lsl #2	@ Get word offset
+#if __LINUX_ARM_ARCH__ >= 7
+	.arch_extension	mp
+	ALT_SMP(W(pldw)	[r1])
+	ALT_UP(W(nop))
+#endif
 	mov	r3, r2, lsl r3
 1:	ldrex	r2, [r1]
 	\instr	r2, r2, r3
-- 
1.8.2.2
