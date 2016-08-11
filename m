From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 11 Aug 2016 11:37:44 -0400
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
Message-ID: <20160811153744.3212-1-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brent DeGraaf <bdegraaf@codeaurora.org>

Prior gettimeofday code register read code is not architecturally
correct as there is no control flow gating logic enforced
immediately prior to the required isb.  Introduce explicit
control-flow logic prior to register read in all cases so that
the mrs read will always be done after all vdso data elements are
read, and read all data elements within the protection logic
provided by the sequence counter.

Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
---
 arch/arm64/include/asm/vdso_datapage.h |   4 +-
 arch/arm64/kernel/vdso.c               |  11 ++--
 arch/arm64/kernel/vdso/gettimeofday.S  | 106 +++++++++++++++------------------
 3 files changed, 56 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index 2b9a637..49a0a51 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -21,6 +21,8 @@
 #ifndef __ASSEMBLY__
 
 struct vdso_data {
+	__u32 tb_seq_count;	/* Timebase sequence counter */
+	__u32 use_syscall;
 	__u64 cs_cycle_last;	/* Timebase at clocksource init */
 	__u64 raw_time_sec;	/* Raw time */
 	__u64 raw_time_nsec;
@@ -30,14 +32,12 @@ struct vdso_data {
 	__u64 xtime_coarse_nsec;
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	__u64 wtm_clock_nsec;
-	__u32 tb_seq_count;	/* Timebase sequence counter */
 	/* cs_* members must be adjacent and in this order (ldp accesses) */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
 	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
-	__u32 use_syscall;
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 076312b..7751667 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -201,10 +201,12 @@ up_fail:
  */
 void update_vsyscall(struct timekeeper *tk)
 {
+	register u32 tmp;
 	u32 use_syscall = strcmp(tk->tkr_mono.clock->name, "arch_sys_counter");
 
-	++vdso_data->tb_seq_count;
-	smp_wmb();
+	tmp = smp_load_acquire(&vdso_data->tb_seq_count);
+	++tmp;
+	smp_store_release(&vdso_data->tb_seq_count, tmp);
 
 	vdso_data->use_syscall			= use_syscall;
 	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
@@ -227,8 +229,9 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 	}
 
-	smp_wmb();
-	++vdso_data->tb_seq_count;
+	tmp = smp_load_acquire(&vdso_data->tb_seq_count);
+	++tmp;
+	smp_store_release(&vdso_data->tb_seq_count, tmp);
 }
 
 void update_vsyscall_tz(void)
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index e00b467..e727808 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -25,6 +25,10 @@
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
 
+#if VDSO_TB_SEQ_COUNT
+#error tb_seq_count MUST be first element of vdso_data
+#endif
+
 vdso_data	.req	x6
 seqcnt		.req	w7
 w_tmp		.req	w8
@@ -36,22 +40,23 @@ x_tmp		.req	x8
  * - All other arguments are read-only, unless otherwise specified.
  */
 
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
+	.macro	seqdata_acquire fallback, tzonly=NO_TZ, skipvcnt=0, getdata
+9999:	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
+8888:	tbnz	seqcnt, #0, 9999b
 	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
+	cbnz	w_tmp, \fallback
+	\getdata
+	mov	w9, seqcnt
+	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
+	cmp	w9, seqcnt
+	bne	8888b	/* Do not needlessly repeat ldar and its implicit barrier */
+	.if (\tzonly) != NO_TZ
+		cbz	x0, \tzonly
+	.endif
+	.if (\skipvcnt) == 0
+		isb
+		mrs	x_tmp, cntvct_el0
+	.endif
 	.endm
 
 	.macro get_nsec_per_sec res
@@ -64,9 +69,6 @@ x_tmp		.req	x8
 	 * shift.
 	 */
 	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
 	/* Calculate cycle delta and convert to ns. */
 	sub	\res, x_tmp, \cycle_last
 	/* We can only guarantee 56 bits of precision. */
@@ -137,17 +139,12 @@ x_tmp		.req	x8
 ENTRY(__kernel_gettimeofday)
 	.cfi_startproc
 	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
+	seqdata_acquire fallback=4f tzonly=2f getdata=__stringify(\
+		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
+		/* w11 = cs_mono_mult, w12 = cs_shift */;\
+		ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT];\
+		ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC];\
+		ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST])
 
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
@@ -164,7 +161,6 @@ ENTRY(__kernel_gettimeofday)
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
 	stp	w4, w5, [x1, #TZ_MINWEST]
 3:
 	mov	x0, xzr
@@ -205,13 +201,11 @@ jumptable:
 
 	ALIGN
 realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
+	seqdata_acquire fallback=syscall getdata=__stringify(\
+		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
+		/* w11 = cs_mono_mult, w12 = cs_shift */;\
+		ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT];\
+		ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC])
 
 	/* All computations are done with left-shifted nsecs. */
 	get_nsec_per_sec res=x9
@@ -224,14 +218,12 @@ realtime:
 
 	ALIGN
 monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
+	seqdata_acquire fallback=syscall getdata=__stringify(\
+		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
+		/* w11 = cs_mono_mult, w12 = cs_shift */;\
+		ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT];\
+		ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC];\
+		ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC])
 
 	/* All computations are done with left-shifted nsecs. */
 	lsl	x4, x4, x12
@@ -247,13 +239,11 @@ monotonic:
 
 	ALIGN
 monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
+	seqdata_acquire fallback=syscall getdata=__stringify(\
+		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
+		/* w11 = cs_raw_mult, w12 = cs_shift */;\
+		ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT];\
+		ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC])
 
 	/* All computations are done with left-shifted nsecs. */
 	lsl	x14, x14, x12
@@ -269,17 +259,15 @@ monotonic_raw:
 
 	ALIGN
 realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
+	seqdata_acquire fallback=syscall skipvcnt=1 getdata=__stringify(\
+		ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC])
 	clock_gettime_return
 
 	ALIGN
 monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
+	seqdata_acquire fallback=syscall skipvcnt=1 getdata=__stringify(\
+		ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC];\
+		ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC])
 
 	/* Computations are done in (non-shifted) nsecs. */
 	get_nsec_per_sec res=x9
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
