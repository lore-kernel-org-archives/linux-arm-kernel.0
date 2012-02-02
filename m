From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  2 Feb 2012 11:24:46 -0800
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
Message-ID: <1328210686-15909-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

armv7's flush_cache_all() flushes caches via set/way. To
determine the cache attributes (line size, number of sets,
etc.) the assembly first writes the CSSELR register to select a
cache level and then reads the CCSIDR register. The CSSELR register
is banked per-cpu and is used to determine which cache level CCSIDR
reads. If the task is migrated between when the CSSELR is written and
the CCSIDR is read the CCSIDR value may be for an unexpected cache
level (for example L1 instead of L2) and incorrect cache flushing
could occur.

Disable preemption across the write and read so that the correct
cache attributes are read and used for the cache flushing
routine. This fixes a problem we see in scm_call() when
flush_cache_all() is called from preemptible context and
sometimes the L2 cache is not properly flushed out.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---

Should we move get_thread_info into assembler.h? It seems odd
to include entry-header.S but I saw that vfp was doing the same.

 arch/arm/mm/cache-v7.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 07c4bc8..a033858 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -16,6 +16,7 @@
 #include <asm/unwind.h>
 
 #include "proc-macros.S"
+#include "../kernel/entry-header.S"
 
 /*
  *	v7_flush_icache_all()
@@ -54,9 +55,19 @@ loop1:
 	and	r1, r1, #7			@ mask of the bits for current cache only
 	cmp	r1, #2				@ see what cache we have at this level
 	blt	skip				@ skip if no cache, or just i-cache
+#ifdef CONFIG_PREEMPT
+	get_thread_info r9
+	ldr	r11, [r9, #TI_PREEMPT]		@ get preempt count
+	add	r11, r11, #1			@ increment it
+	str	r11, [r9, #TI_PREEMPT]
+#endif
 	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
 	isb					@ isb to sych the new cssr&csidr
 	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
+#ifdef CONFIG_PREEMPT
+	sub	r11, r11, #1			@ decrement preempt count
+	str	r11, [r9, #TI_PREEMPT]
+#endif
 	and	r2, r1, #7			@ extract the length of the cache lines
 	add	r2, r2, #4			@ add 4 (line length offset)
 	ldr	r4, =0x3ff
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
