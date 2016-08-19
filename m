From: bdegraaf@codeaurora.org (Brent DeGraaf)
Date: Fri, 19 Aug 2016 16:02:08 -0400
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <20160812114111.GA21484@leverpostej>
References: <20160812114111.GA21484@leverpostej>
Message-ID: <1471636928-11177-1-git-send-email-bdegraaf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce explicit control-flow logic immediately prior to virtual
counter register read in all cases so that the mrs read will
always be accessed after all vdso data elements are read and
sequence count is verified. Ensure data elements under the
protection provided by the sequence counter are read only within
the protection logic loop.  Read the virtual counter as soon as
possible after the data elements are confirmed correctly read,
rather than after several other operations which can affect time.
Reduce full barriers required in register read code in favor of
the lighter-weight one-way barrier supplied by a load-acquire
wherever possible.

Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
---
 arch/arm64/include/asm/vdso_datapage.h |   4 +-
 arch/arm64/kernel/vdso/gettimeofday.S  | 107 +++++++++++++++------------------
 2 files changed, 50 insertions(+), 61 deletions(-)

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
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index e00b467..131ac6b 100644
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
@@ -36,22 +40,24 @@ x_tmp		.req	x8
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
+	dmb	ishld	/* No loads from vdso_data after this point */
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
@@ -64,9 +70,6 @@ x_tmp		.req	x8
 	 * shift.
 	 */
 	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
 	/* Calculate cycle delta and convert to ns. */
 	sub	\res, x_tmp, \cycle_last
 	/* We can only guarantee 56 bits of precision. */
@@ -137,17 +140,12 @@ x_tmp		.req	x8
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
@@ -164,7 +162,6 @@ ENTRY(__kernel_gettimeofday)
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
 	stp	w4, w5, [x1, #TZ_MINWEST]
 3:
 	mov	x0, xzr
@@ -205,13 +202,11 @@ jumptable:
 
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
@@ -224,14 +219,12 @@ realtime:
 
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
@@ -247,13 +240,11 @@ monotonic:
 
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
@@ -269,17 +260,15 @@ monotonic_raw:
 
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
