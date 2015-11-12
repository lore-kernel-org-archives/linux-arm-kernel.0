From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 01:50:20 -0800
Subject: pj4 -marm breaks thumb ftrace
Message-ID: <20151112095020.GB15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I boot up a thumb2 multi-v7 kernel with ftrace enabled I get
this ftrace bug splat.

WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:1979
ftrace_bug+0x115/0x1bc()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-10337-g3ea2911b81d3-dirty #129
Hardware name: Qualcomm (Flattened Device Tree)
[<c030cf09>] (unwind_backtrace) from [<c030903d>] (show_stack+0x11/0x14)
[<c030903d>] (show_stack) from [<c0501337>] (dump_stack+0x57/0x6c)
[<c0501337>] (dump_stack) from [<c033249b>] (warn_slowpath_common+0x57/0x88)
[<c033249b>] (warn_slowpath_common) from [<c03324e3>] (warn_slowpath_null+0x17/0x1c)
[<c03324e3>] (warn_slowpath_null) from [<c038c359>] (ftrace_bug+0x115/0x1bc)
[<c038c359>] (ftrace_bug) from [<c038c5d7>] (ftrace_process_locs+0x1d7/0x3e4)
[<c038c5d7>] (ftrace_process_locs) from [<c0e18391>] (ftrace_init+0x49/0xb0)
[<c0e18391>] (ftrace_init) from [<c0e0095b>] (start_kernel+0x26f/0x2d8)
[<c0e0095b>] (start_kernel) from [<0020807f>] (0x20807f)
---[ end trace cb88537fdc8fa200 ]---
ftrace failed to modify [<c030e1e4>] iwmmxt_do+0x8/0x3c
 actual: dc:f8:ff:fa
ftrace record flags: 0
 (0)   expected tramp: c030c565

I suspect this is caused by commit 13d1b9575ac2 (ARM: 8221/1:
PJ4: allow building in Thumb-2 mode, 2014-11-25) which adds an
-marm flag to the compilation of arch/arm/kernel/pj4-cp0.c. When
ftrace tries to replace the instruction in ftrace_make_nop() ->
ftrace_modify_code(), it gets confused because it checks to make
sure the instruction it's replacing is actually a branch to
mcount with a thumb encoding. But given that the branch is done
in arm instead of thumb it doesn't see the instruction it's
looking for and bails out with this bug.

Should we mark this whole file as notrace? That at least seems to
fix the problem for me. I imagine we could make things more
complicated and try to figure out if the branch is either arm or
thumb and replace it with the appropriate nop or interworking
branch to ftrace code, but do we really care?

Here's the simple patch.

-----8<----
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59bf3831..f65daa440610 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
 				   perf_event_v7.o
+CFLAGS_REMOVE_pj4-cp0.o		= -pg
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
