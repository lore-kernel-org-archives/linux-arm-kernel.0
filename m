From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jul 2016 15:11:44 +0100
Subject: [PATCH 1/2] arm64: Refactor vDSO time functions
In-Reply-To: <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
References: <1462797421-33103-1-git-send-email-kevin.brodsky@arm.com>
 <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
Message-ID: <20160708141143.GB6493@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Mon, May 09, 2016 at 01:37:00PM +0100, Kevin Brodsky wrote:
> Time functions are directly implemented in assembly in arm64, and it
> is desirable to keep it this way for performance reasons (everything
> fits in registers, so that the stack is not used at all). However, the
> current implementation is quite difficult to read and understand (even
> considering it's assembly).  Additionally, due to the structure of
> __kernel_clock_gettime, which heavily uses conditional branches to
> share code between the different clocks, it is difficult to support a
> new clock without making the branches even harder to follow.
> 
> This commit completely refactors the structure of clock_gettime (and
> gettimeofday along the way) while keeping exactly the same algorithms.
> We no longer try to share code; instead, macros provide common
> operations. This new approach comes with a number of advantages:
> - In clock_gettime, clock implementations are no longer interspersed,
>   making them much more readable. Additionally, macros only use
>   registers passed as arguments or reserved with .req, this way it is
>   easy to make sure that registers are properly allocated. To avoid a
>   large number of branches in a given execution path, a jump table is
>   used; a normal execution uses 3 unconditional branches.
> - __do_get_tspec has been replaced with 2 macros (get_ts_clock_mono,
>   get_clock_shifted_nsec) and explicit loading of data from the vDSO
>   page. Consequently, clock_gettime and gettimeofday are now leaf
>   functions, and saving x30 (lr) is no longer necessary.
> - Variables protected by tb_seq_count are now loaded all at once,
>   allowing to merge the seqcnt_read macro into seqcnt_check.
> - For CLOCK_REALTIME_COARSE, removed an unused load of the wall to
>   monotonic timespec.
> - For CLOCK_MONOTONIC_COARSE, removed a few shift instructions.
> 
> Obviously, the downside of sharing less code is an increase in code
> size. However since the vDSO has its own code page, this does not
> really matter, as long as the size of the DSO remains below 4 kB. For
> now this should be all right:
>                     Before  After
>   vdso.so size (B)  2776    2936
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/kernel/vdso/gettimeofday.S | 282 +++++++++++++++++++---------------
>  1 file changed, 162 insertions(+), 120 deletions(-)

This patch is really hard to read, but after applying it the resulting
code looks really good. Thanks! Just a couple of minor comments inline.

>  ENTRY(__kernel_clock_gettime)
>  	.cfi_startproc
> -	cmp	w0, #CLOCK_REALTIME
> -	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
> -	b.ne	2f
> +	cmp 	w0, #JUMPSLOT_MAX
> +	b.hi 	syscall
> +	adr	vdso_data, _vdso_data
> +	adr 	x_tmp, jumptable
> +	add 	x_tmp, x_tmp, w0, uxtw #2
> +	br 	x_tmp
> +
> +jumptable:
> +	jump_slot jumptable, CLOCK_REALTIME, realtime
> +	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
> +	b 	syscall
> +	b 	syscall
> +	b 	syscall
> +	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
> +	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse

The branchiness of this code (into __kernel_clock_gettime, then not taking
the b.hi, the br following by the b in the jumptable) is likely to hurt
most branch predictors. I found that aligning the jumptable and its
subsequent targets helped a bit here.

> +shift_store:
>  	lsr	x11, x11, x12
> +store:
>  	stp	x10, x11, [x1, #TSPEC_TV_SEC]
>  	mov	x0, xzr
>  	ret

I think it's simpler just to macroise this, which also avoids some of
the branches given that it ends in a ret anyway.

Fixup patch below. If you fold it in, then:

Acked-by: Will Deacon <will.deacon@arm.com>

for the series.

Will

--->8

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index f49b6755058a..85969cd2b2f7 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -115,6 +115,15 @@ x_tmp		.req	x8
 9998:
 	.endm
 
+	.macro clock_gettime_return, shift=0
+	.if \shift == 1
+	lsr	x11, x11, x12
+	.endif
+	stp	x10, x11, [x1, #TSPEC_TV_SEC]
+	mov	x0, xzr
+	ret
+	.endm
+
 	.macro jump_slot jumptable, index, label
 	.if (. - \jumptable) != 4 * (\index)
 		.error "Jump slot index mismatch"
@@ -180,6 +189,7 @@ ENTRY(__kernel_clock_gettime)
 	add	x_tmp, x_tmp, w0, uxtw #2
 	br	x_tmp
 
+	ALIGN
 jumptable:
 	jump_slot jumptable, CLOCK_REALTIME, realtime
 	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
@@ -193,6 +203,7 @@ jumptable:
 	.error	"Wrong jumptable size"
 	.endif
 
+	ALIGN
 realtime:
 	seqcnt_acquire
 	syscall_check fail=syscall
@@ -209,9 +220,9 @@ realtime:
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
+	clock_gettime_return, shift=1
 
-	b shift_store
-
+	ALIGN
 monotonic:
 	seqcnt_acquire
 	syscall_check fail=syscall
@@ -232,9 +243,9 @@ monotonic:
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
 	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
+	clock_gettime_return, shift=1
 
-	b shift_store
-
+	ALIGN
 monotonic_raw:
 	seqcnt_acquire
 	syscall_check fail=syscall
@@ -254,16 +265,16 @@ monotonic_raw:
 		clock_nsec=x15, nsec_to_sec=x9
 
 	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
+	clock_gettime_return, shift=1
 
-	b shift_store
-
+	ALIGN
 realtime_coarse:
 	seqcnt_acquire
 	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
 	seqcnt_check fail=realtime_coarse
+	clock_gettime_return
 
-	b store
-
+	ALIGN
 monotonic_coarse:
 	seqcnt_acquire
 	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
@@ -273,16 +284,9 @@ monotonic_coarse:
 	/* Computations are done in (non-shifted) nsecs. */
 	get_nsec_per_sec res=x9
 	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
+	clock_gettime_return
 
-	b store
-
-shift_store:
-	lsr	x11, x11, x12
-store:
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-
+	ALIGN
 syscall: /* Syscall fallback. */
 	mov	x8, #__NR_clock_gettime
 	svc	#0
