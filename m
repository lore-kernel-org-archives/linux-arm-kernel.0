From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Nov 2013 15:29:53 +0000
Subject: [PATCH] arm: mm: refactor v7 cache cleaning ops to use way/index
 sequence
Message-ID: <1384874993-4577-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set-associative caches on all v7 implementations map the index bits
to physical addresses LSBs and tag bits to MSBs. On most systems with
sane DRAM controller configurations, this means that the current v7
cache flush routine using set/way operations triggers a DRAM memory
controller precharge/activate for every cache line writeback since the
cache routine cleans lines by first fixing the index and then looping
through ways.

Given the random content of cache tags, swapping the order between
indexes and ways loops do not prevent DRAM pages precharge and
activate cycles but at least, on average, improves the chances that
either multiple lines hit the same page or multiple lines belong to
different DRAM banks, improving throughput significantly.

This patch swaps the inner loops in the v7 cache flushing routine to
carry out the clean operations first on all sets belonging to a given
way (looping through sets) and then decrementing the way.

Benchmarks showed that by swapping the ordering in which sets and ways
are decremented in the v7 cache flushing routine, that uses set/way
operations, time required to flush caches is reduced significantly,
owing to improved writebacks throughput to the DRAM controller.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index b5c467a..778bcf8 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -146,18 +146,18 @@ flush_levels:
 	ldr	r7, =0x7fff
 	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
 loop1:
-	mov	r9, r4				@ create working copy of max way size
+	mov	r9, r7				@ create working copy of max index
 loop2:
- ARM(	orr	r11, r10, r9, lsl r5	)	@ factor way and cache number into r11
- THUMB(	lsl	r6, r9, r5		)
+ ARM(	orr	r11, r10, r4, lsl r5	)	@ factor way and cache number into r11
+ THUMB(	lsl	r6, r4, r5		)
  THUMB(	orr	r11, r10, r6		)	@ factor way and cache number into r11
- ARM(	orr	r11, r11, r7, lsl r2	)	@ factor index number into r11
- THUMB(	lsl	r6, r7, r2		)
+ ARM(	orr	r11, r11, r9, lsl r2	)	@ factor index number into r11
+ THUMB(	lsl	r6, r9, r2		)
  THUMB(	orr	r11, r11, r6		)	@ factor index number into r11
 	mcr	p15, 0, r11, c7, c14, 2		@ clean & invalidate by set/way
-	subs	r9, r9, #1			@ decrement the way
+	subs	r9, r9, #1			@ decrement the index
 	bge	loop2
-	subs	r7, r7, #1			@ decrement the index
+	subs	r4, r4, #1			@ decrement the way
 	bge	loop1
 skip:
 	add	r10, r10, #2			@ increment cache number
-- 
1.8.2.2
