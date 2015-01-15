From: panand@redhat.com (Pratyush Anand)
Date: Thu, 15 Jan 2015 22:17:56 +0530
Subject: Query: ARM64: Behavior of el1_dbg exception while executing
 el0_dbg
In-Reply-To: <54B55B95.1070402@redhat.com>
References: <54AE830E.1090000@redhat.com> <20150108162312.GO11583@arm.com>
 <54AEBE45.9080203@redhat.com> <20150109154635.GG11258@arm.com>
 <54B00C39.1070809@redhat.com> <20150112173005.GK13360@arm.com>
 <54B4BF4C.2030009@redhat.com>
 <20150113155221.GG16524@e104818-lin.cambridge.arm.com>
 <54B55B95.1070402@redhat.com>
Message-ID: <54B7EF3C.8060909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will / Catalin,

On Tuesday 13 January 2015 11:23 PM, Pratyush Anand wrote:
> I will still try to find some way to capture enable_dbg macro path.H

I did instrumented debug tap points at all the location from where 
enable_debug macro is called(see attached debug patch). But, I do not 
see that, execution reaches to any of those tap points between el0_dbg 
and el1_dbg, and tap points debug log also confirms that el1_dbg is 
raised before el0_dbg is returned.

Details of log and code base can be seen here:
https://github.com/pratyushanand/linux/tree/ml_arm64_uprobe_devel_debug_kprobe_insertion_at_uprobe_breakpoint_handler

I am also providing debug log corresponding to attached patches here for 
quick reference. Please see if there is anything which I would still be 
missing in my analysis?


Step at user level:
================================

//inserting kprobe at 1st instruction of  uprobe_breakpoint_handler. So 
1st instruction of uprobe_breakpoint_handler has been replaced by 
BRK64_OPCODE_KPROBES when kprobe enabled.

     echo 'p:myprobe uprobe_breakpoint_handler' > 
/sys/kernel/debug/tracing/kprobe_events

//enabling kprobe

     echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

//run test application

     ./test&

//inserting uprobe at offset 0x5d0 of  uprobe_breakpoint_handler. So 
instruction at this offset has been replaced by BRK64_OPCODE_UPROBES, 
when uprobe enabled.

     echo 'p:test_entry test:0x5d0' > 
/sys/kernel/debug/tracing/uprobe_events

//enabling uprobe

     echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable

observed flow summary
========================
     kprobe has been inserted at 1st instruction of 
uprobe_breakpoint_handler and
     uprobe has been inserted at offset 0x5d0 of test application.
     Observation is that execution flow is as under:
     -- Application executes  BRK64_OPCODE_UPROBES.
     -- el0_sync is raised.
     -- el0_sync
         -> kernel_entry 0
         -> el0_dbg
             -> do_debug_exception
                 ->brk_handler
                     ->call_break_hook
                         ->uprobe_breakpoint_handler
     (1st instruction of uprobe_breakpoint_handler has been modified as
     BRK64_OPCODE_KPROBES)
     -- el1_sync is raised.
     -- el1_sync
         -> kernel_entry 1
         -> el1_dbg
             -> do_debug_exception
                 ->brk_handler
                     ->call_break_hook
                         ->kprobe_breakpoint_handler

     Following printk messages confirms above flow. printk messages has been
     avoided into el0_dbg and el1_dbg execution path. All the tap points for
     these path have been written into per_cpu array and then they have been
     printed when kprobe_breakpoint_handler is executed.
     tap points have been instrumented wherever we are calling macro
     enable_dbg and also in uprobe/kprobe break/single step exception path.


printk debug messages with comments
============================================

     [   60.846047] arch_prepare_kprobe called at 89
     [   60.850344] arch_prepare_kprobe called at 97
     [   60.854595] arch_prepare_kprobe called at 110
     [   60.858959] arch_prepare_kprobe called at 114 with slot
     fffffdfffc000004
     [   60.865633] arch_prepare_ss_slot called at 46
     [   60.874466] arch_arm_kprobe called at 143
     [   60.878487] patch_text called at 136
     [   60.904226] arch_uprobe_analyze_insn called at 54
     [   60.908939] arch_uprobe_analyze_insn called at 68
     [   60.914155] 0.0: event 0 syndrom 0 @cpu 0
     [   60.918151] 0.0: event 0 syndrom 0 @cpu 1
     [   60.922143] 0.0: event 0 syndrom 0 @cpu 2
     [   60.926134] 1421337852.798722179: event 19 syndrom f2000008 @cpu 3

     [1][Pratyush]: ESR = f2000008 and event 19 says its uprobe breakpoint
     exception

     [   60.932286] 1421337852.798722179: event 19 syndrom f2000004 @cpu 3

     [2][Pratyush]: ESR = f2000004 and event 19 says its kprobe breakpoint
     exception

     [   60.938438] 1421337852.798722179: event 23 syndrom f2000004 @cpu 3

     [3][Pratyush]: ESR = f2000004 and event 23 says that we are in function
     kprobe_breakpoint_handler

     Since we did not receive any event corresponding to calling of
     enable_dbg macro
     or execution of either uprobe_breakpoint_handler or
     uprobe_single_step_handler, so it is confirmed that,
     we received el1_dbg while executing el0_dbg

     [   60.944590] 0.0: event 0 syndrom 0 @cpu 3
     [   60.948579] 0.0: event 0 syndrom 0 @cpu 4
     [   60.952569] 0.0: event 0 syndrom 0 @cpu 5
     [   60.956558] 0.0: event 0 syndrom 0 @cpu 6
     [   60.960547] 0.0: event 0 syndrom 0 @cpu 7
     [   60.964539] kprobe_handler called at 453 with addr fffffe000009fd80
     [   60.970778] kprobe_handler called at 456
     [   60.974681] kprobe_handler called at 465

~Pratyush
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Debug-kprobe-insertion-at-uprobe_breakpoint_handler.patch
Type: text/x-patch
Size: 33060 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/ba388265/attachment-0001.bin>
