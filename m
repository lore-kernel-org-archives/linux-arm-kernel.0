From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 Aug 2017 14:21:31 +0100
Subject: [PATCHv2 1/7] arm64: Add ASM_BUG()
In-Reply-To: <20170809100734.oecy3xq7wwg5ixpd@armageddon.cambridge.arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
 <20170808153112.GF19207@leverpostej>
 <20170808155853.ropux7lxk6rgbd2r@armageddon.cambridge.arm.com>
 <20170808161050.GH19207@leverpostej>
 <20170809100734.oecy3xq7wwg5ixpd@armageddon.cambridge.arm.com>
Message-ID: <20170809132131.GB29494@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 11:07:35AM +0100, Catalin Marinas wrote:
> On Tue, Aug 08, 2017 at 05:10:51PM +0100, Mark Rutland wrote:
> > On Tue, Aug 08, 2017 at 04:58:53PM +0100, Catalin Marinas wrote:
> > > I'll pull arm64/exception-stack into for-next/core (I haven't got to the
> > > vmap-stack series yet).
> > 
> > If you could hold off for a day, I'd like to make one final change and prevent
> > use of the final record's LR value, where FP is NULL, since that LR isn't
> > meaningful, and makes the backtrace look weird:
> > 
> > [ 2785.650646] [<ffff000008082cb0>] el0_svc_naked+0x24/0x28
> > [ 2785.656016] [<0000ffffaf717554>] 0xffffaf717554
> > 
> > Otherwise, I can do that as a fixup.
> 
> I'll hold off, I haven't pushed the for-next/core branch out yet.

I've pushed out an updated arm64/exception-stack branch. The HEAD should
be:

  31e43ad3b74a5d7b ("arm64: unwind: remove sp from struct stackframe")

That should have tvhe ASM_BUG() fix, and the below diff folded into the
pt_regs patch, to ensure that backtraces don't use user-controlled PCs
or idmap aliases of startup code.

If you'd like, I can send the updated series as a v3.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4ddb8d7..612a077 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -116,7 +116,11 @@
 	 * time the exception was taken (in case we attempt to walk the call
 	 * stack later), chain it together with the stack frames.
 	 */
+	.if \el == 0
+	stp	xzr, xzr, [sp, #S_STACKFRAME]
+	.else
 	stp	x29, x22, [sp, #S_STACKFRAME]
+	.endif
 	add	x29, sp, #S_STACKFRAME
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 973df7d..f9e4aac 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -362,6 +362,9 @@ __primary_switched:
 	ret					// to __primary_switch()
 0:
 #endif
+	add	sp, sp, #16
+	mov	x29, #0
+	mov	x30, #0
 	b	start_kernel
 ENDPROC(__primary_switched)
 
@@ -617,6 +620,7 @@ __secondary_switched:
 	ldr	x2, [x0, #CPU_BOOT_TASK]
 	msr	sp_el0, x2
 	mov	x29, #0
+	mov	x30, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 54f3463..35588ca 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -74,6 +74,15 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+	/*
+	 * Frames created upon entry from EL0 have NULL FP and PC values, so
+	 * don't bother reporting these. Frames created by __noreturn functions
+	 * might have a valid FP even if PC is bogus, so only terminate where
+	 * both are NULL.
+	 */
+	if (!frame->fp && !frame->pc)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
1.9.1
