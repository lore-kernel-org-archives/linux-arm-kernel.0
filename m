From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Nov 2015 11:30:24 +0100
Subject: pj4 -marm breaks thumb ftrace
In-Reply-To: <20151112095020.GB15032@codeaurora.org>
References: <20151112095020.GB15032@codeaurora.org>
Message-ID: <56446A40.7000304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 10:50, Stephen Boyd <sboyd@codeaurora.org> wrote:
> When I boot up a thumb2 multi-v7 kernel with ftrace enabled I get
> this ftrace bug splat.
>
> WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:1979
> ftrace_bug+0x115/0x1bc()
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-10337-g3ea2911b81d3-dirty #129
> Hardware name: Qualcomm (Flattened Device Tree)
> [<c030cf09>] (unwind_backtrace) from [<c030903d>] (show_stack+0x11/0x14)
> [<c030903d>] (show_stack) from [<c0501337>] (dump_stack+0x57/0x6c)
> [<c0501337>] (dump_stack) from [<c033249b>] (warn_slowpath_common+0x57/0x88)
> [<c033249b>] (warn_slowpath_common) from [<c03324e3>] (warn_slowpath_null+0x17/0x1c)
> [<c03324e3>] (warn_slowpath_null) from [<c038c359>] (ftrace_bug+0x115/0x1bc)
> [<c038c359>] (ftrace_bug) from [<c038c5d7>] (ftrace_process_locs+0x1d7/0x3e4)
> [<c038c5d7>] (ftrace_process_locs) from [<c0e18391>] (ftrace_init+0x49/0xb0)
> [<c0e18391>] (ftrace_init) from [<c0e0095b>] (start_kernel+0x26f/0x2d8)
> [<c0e0095b>] (start_kernel) from [<0020807f>] (0x20807f)
> ---[ end trace cb88537fdc8fa200 ]---
> ftrace failed to modify [<c030e1e4>] iwmmxt_do+0x8/0x3c
>  actual: dc:f8:ff:fa
> ftrace record flags: 0
>  (0)   expected tramp: c030c565
>
> I suspect this is caused by commit 13d1b9575ac2 (ARM: 8221/1:
> PJ4: allow building in Thumb-2 mode, 2014-11-25) which adds an
> -marm flag to the compilation of arch/arm/kernel/pj4-cp0.c. When
> ftrace tries to replace the instruction in ftrace_make_nop() ->
> ftrace_modify_code(), it gets confused because it checks to make
> sure the instruction it's replacing is actually a branch to
> mcount with a thumb encoding. But given that the branch is done
> in arm instead of thumb it doesn't see the instruction it's
> looking for and bails out with this bug.
>
> Should we mark this whole file as notrace? That at least seems to
> fix the problem for me. I imagine we could make things more
> complicated and try to figure out if the branch is either arm or
> thumb and replace it with the appropriate nop or interworking
> branch to ftrace code, but do we really care?
>

I wonder if we should simply fix the code instead.

Compiling pj4-cp0.c in thumb mode fails on the sub instruction in the 
following sequence:

static void __init pj4_cp_access_write(u32 value)
{
u32 temp;

     __asm__ __volatile__ (
         "mcr p15, 0, %1, c1, c0, 2\n\t"
         "mrc p15, 0, %0, c1, c0, 2\n\t"
         "mov %0, %0\n\t"
         "sub pc, pc, #4\n\t"
         : "=r" (temp) : "r" (value));
}

I wonder if the sub instruction is simply there to flush the pipeline, 
but let's not get into that. I propose we just apply the patch below to 
move this code (and its _read() counterpart) to iwmmxt.S, which is 
already built as ARM, and not subject to instrumentation.

-----8<-----
 From de52762b71c85c6c2142a67ba8833a13d4ca8acb Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 12 Nov 2015 11:17:46 +0100
Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
  iwmmxt.S

The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2 
mode, due to the way they perform arithmetic on the program counter, so 
it is built in ARM mode instead. However, building C files in ARM mode 
under CONFIG_THUMB2_KERNEL is problematic, since the instrumentation 
performed by subsystems like ftrace does not expect having to deal with 
interworking branches.

So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
offending sequences to iwmmxt.S, which is not instrumented anyway, and 
is already built in ARM mode unconditionally.

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59bf3831..3c789496297f 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
  obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
  obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
  				   perf_event_v7.o
-CFLAGS_pj4-cp0.o		:= -marm
  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
  obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
  obj-$(CONFIG_VDSO)		+= vdso.o
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 49fadbda8c63..2cd418f1b9c3 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -370,3 +370,19 @@ ENDPROC(iwmmxt_task_release)
  concan_owner:
  	.word	0

+#if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
+
+ENTRY(pj4_cp_access_read)
+	mrc	p15, 0, r0, c1, c0, 2
+	ret	lr
+ENDPROC(pj4_cp_access_read)
+
+ENTRY(pj4_cp_access_write)
+	mcr	p15, 0, r0, c1, c0, 2
+	mrc	p15, 0, r0, c1, c0, 2
+	mov	r0, r0
+	sub	pc, pc, #4
+	ret	lr
+ENDPROC(pj4_cp_access_write)
+
+#endif
diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index 8153e36b2491..4f226e175734 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -49,28 +49,8 @@
  	.notifier_call	= iwmmxt_do,
  };

-
-static u32 __init pj4_cp_access_read(void)
-{
-	u32 value;
-
-	__asm__ __volatile__ (
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		: "=r" (value));
-	return value;
-}
-
-static void __init pj4_cp_access_write(u32 value)
-{
-	u32 temp;
-
-	__asm__ __volatile__ (
-		"mcr	p15, 0, %1, c1, c0, 2\n\t"
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		"mov	%0, %0\n\t"
-		"sub	pc, pc, #4\n\t"
-		: "=r" (temp) : "r" (value));
-}
+asmlinkage u32 pj4_cp_access_read(void);
+asmlinkage void pj4_cp_access_write(u32 value);

  static int __init pj4_get_iwmmxt_version(void)
  {
