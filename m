From: marc.ceeeee@gmail.com (Marc Carino)
Date: Wed, 16 Jul 2014 16:54:01 -0700
Subject: [PATCH v2] ARM: zImage: add DSB and ISB barriers after relocating code
Message-ID: <1405554841-28503-1-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zImage loader will relocate the image if it determines that
decompression will overwrite its current location. Since the act
of relocation is basically a form of code self-modification, we
need to ensure that the CPU fetches the updated instruction stream.

Since cache maintenance is skipped during the relocation phase (the
MMUs and caches are off), we need to execute both a data sync
and instruction sync barrier prior to jumping to the relocated code.
Skipping the barriers can result in execution of stale prefetched
code, leading to hangs or an UNDEFINED INSTRUCTION exception.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 arch/arm/boot/compressed/head.S | 71 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 3a8b32d..3888a0d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -395,8 +395,13 @@ dtb_check_done:
 		add	sp, sp, r6
 #endif
 
+		/*
+		 * Perform full cache maintenance if caches were enabled
+		 * earlier. Otherwise, only invalidate the instruction cache.
+		 */
 		tst	r4, #1
 		bleq	cache_clean_flush
+		blne	i_cache_inval
 
 		adr	r0, BSYM(restart)
 		add	r0, r0, r6
@@ -769,7 +774,7 @@ __common_mmu_cache_on:
 		sub	pc, lr, r0, lsr #32	@ properly flush pipeline
 #endif
 
-#define PROC_ENTRY_SIZE (4*5)
+#define PROC_ENTRY_SIZE (4*6)
 
 /*
  * Here follow the relocatable cache support functions for the
@@ -808,6 +813,7 @@ call_cache_fn:	adr	r12, proc_types
  *   - 'cache on' method instruction
  *   - 'cache off' method instruction
  *   - 'cache flush' method instruction
+ *   - 'instruction cache invalidate' method instruction
  *
  * We match an entry using: ((real_id ^ match) & mask) == 0
  *
@@ -826,6 +832,8 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x41007000		@ ARM7/710
 		.word	0xfff8fe00
@@ -835,6 +843,8 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x41807200		@ ARM720T (writethrough)
 		.word	0xffffff00
@@ -842,24 +852,32 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		mov	pc, lr
  THUMB(		nop				)
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x41007400		@ ARM74x
 		.word	0xff00ff00
 		W(b)	__armv3_mpu_cache_on
 		W(b)	__armv3_mpu_cache_off
 		W(b)	__armv3_mpu_cache_flush
-		
+		mov	pc, lr
+ THUMB(		nop				)
+
 		.word	0x41009400		@ ARM94x
 		.word	0xff00ff00
 		W(b)	__armv4_mpu_cache_on
 		W(b)	__armv4_mpu_cache_off
 		W(b)	__armv4_mpu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x41069260		@ ARM926EJ-S (v5TEJ)
 		.word	0xff0ffff0
 		W(b)	__arm926ejs_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv5tej_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x00007000		@ ARM7 IDs
 		.word	0x0000f000
@@ -869,6 +887,8 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+		mov	pc, lr
+ THUMB(		nop				)
 
 		@ Everything from here on will be the new ID system.
 
@@ -877,30 +897,40 @@ proc_types:
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x6901b110		@ sa1110
 		.word	0xfffffff0
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x56056900
 		.word	0xffffff00		@ PXA9xx
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x56158000		@ PXA168
 		.word	0xfffff000
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv5tej_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x56050000		@ Feroceon
 		.word	0xff0f0000
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv5tej_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 #ifdef CONFIG_CPU_FEROCEON_OLD_ID
 		/* this conflicts with the standard ARMv5TE entry */
@@ -909,6 +939,8 @@ proc_types:
 		b	__armv4_mmu_cache_on
 		b	__armv4_mmu_cache_off
 		b	__armv5tej_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 #endif
 
 		.word	0x66015261		@ FA526
@@ -916,6 +948,8 @@ proc_types:
 		W(b)	__fa526_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__fa526_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		@ These match on the architecture ID
 
@@ -924,30 +958,39 @@ proc_types:
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x00050000		@ ARMv5TE
 		.word	0x000f0000
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x00060000		@ ARMv5TEJ
 		.word	0x000f0000
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv5tej_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x0007b000		@ ARMv6
 		.word	0x000ff000
 		W(b)	__armv6_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv6_mmu_cache_flush
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.word	0x000f0000		@ new CPU Id
 		.word	0x000f0000
 		W(b)	__armv7_mmu_cache_on
 		W(b)	__armv7_mmu_cache_off
 		W(b)	__armv7_mmu_cache_flush
+		W(b)	__armv7_i_cache_inval
 
 		.word	0			@ unrecognised type
 		.word	0
@@ -957,6 +1000,8 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+		mov	pc, lr
+ THUMB(		nop				)
 
 		.size	proc_types, . - proc_types
 
@@ -1060,7 +1105,7 @@ __armv4_mpu_cache_flush:
 		mcrne	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 		mcr	p15, 0, ip, c7, c10, 4	@ drain WB
 		mov	pc, lr
-		
+
 __fa526_cache_flush:
 		mov	r1, #0
 		mcr	p15, 0, r1, c7, c14, 0	@ clean and invalidate D cache
@@ -1182,6 +1227,26 @@ __armv3_mpu_cache_flush:
 		mov	pc, lr
 
 /*
+ * Invalidate the instruction cache. To be used when the instruction stream
+ * is modified while the MMU and data caches are OFF.
+ * This routine can be invoked with the instruction cache ON or OFF.
+ *
+ * On exit,
+ *  r0 corrupted
+ */
+		.align	5
+i_cache_inval:	mov	r3, #20			@ cache_off function
+		b	call_cache_fn
+
+__armv7_i_cache_inval:
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c5, 0	@ inst. cache inval. all to PoU
+		mcr	p15, 0, r0, c7, c5, 5	@ branch pred. invalidate all
+		mcr	p15, 0, r0, c7, c10, 4	@ DSB
+		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		mov	pc, lr
+
+/*
  * Various debugging routines for printing hex characters and
  * memory, which again must be relocatable.
  */
-- 
1.8.1.3
