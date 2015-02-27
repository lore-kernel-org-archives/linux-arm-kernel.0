From: peter.crosthwaite@xilinx.com (Peter Crosthwaite)
Date: Fri, 27 Feb 2015 11:43:27 -0800
Subject: [RFC PATCH] arm64: Implement cpu_relax as yield
In-Reply-To: <20150225132437.GD12377@arm.com>
References: <1424819257-22664-1-git-send-email-peter.crosthwaite@xilinx.com>
 <20150225132437.GD12377@arm.com>
Message-ID: <CAEgOgz6Ld3r2p=j2LnaDOo+s1WxeVkgBTG9nwFW3JSyrn6WYwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 5:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Feb 24, 2015 at 11:07:37PM +0000, Peter Crosthwaite wrote:
>> ARM64 has the yield nop hint which has the intended semantics of
>> cpu_relax. Implement.
>>
>> The immediate application is ARM CPU emulators. An emulator can take
>> advantage of the yield hint to de-prioritise an emulated CPU in favor
>> of other emulation tasks. QEMU A64 SMP emulation has yield awareness,
>> and sees a significant boot time performance increase with this change.
>
> Could you elaborate on the QEMU SMP boot case please? Usually SMP pens
> for booting make use of wfe/sev to minimise the spinning overhead.
>

So I did some follow up experiments. With my patch applied I started
trapping instances of cpu_relax (now yielding) in gdb. I then
commented out the cpu_relax's one by one.

This one seems to be the key:

diff --git a/kernel/smp.c b/kernel/smp.c
index f38a1e6..1c692be 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -108,7 +108,8 @@ void __init call_function_init(void)
 static void csd_lock_wait(struct call_single_data *csd)
 {
        while (csd->flags & CSD_FLAG_LOCK)
-               cpu_relax();
+               ;
+               //cpu_relax();
 }

Hack above causes boot time delay even with my patch applied, so this
is causing my issue it seems.

I found three cpu_relax calls that each seems to do some spinning in
the boot. There probably will be more, but I stopped after finding to
above issue. Full gdb traces below:

Breakpoint 1, multi_cpu_stop (data=0x0) at kernel/stop_machine.c:191
191 cpu_relax();
(gdb) bt
#0  multi_cpu_stop (data=0x0) at kernel/stop_machine.c:191
#1  0xffffffc00011e750 in cpu_stopper_thread (cpu=<optimized out>) at
kernel/stop_machine.c:473
#2  0xffffffc0000ce118 in smpboot_thread_fn (data=0xffffffc00581b980)
at kernel/smpboot.c:161
#3  0xffffffc0000cae1c in kthread (_create=0xffffffc00581bb00) at
kernel/kthread.c:207
#4  0xffffffc000085bf0 in ret_from_fork () at arch/arm64/kernel/entry.S:635
#5  0xffffffc000085bf0 in ret_from_fork () at arch/arm64/kernel/entry.S:635

Breakpoint 1, ktime_get_update_offsets_tick
(offs_real=0xffffffc005987b70, offs_boot=0xffffffc005987b68,
    offs_tai=0xffffffc005987b60) at kernel/time/timekeeping.c:1785
1785 seq = read_seqcount_begin(&tk_core.seq);
(gdb) bt
#0  ktime_get_update_offsets_tick (offs_real=0xffffffc005987b70,
offs_boot=0xffffffc005987b68, offs_tai=0xffffffc005987b60)
    at kernel/time/timekeeping.c:1785
#1  0xffffffc0000fbe0c in hrtimer_get_softirq_time (base=<optimized
out>) at kernel/time/hrtimer.c:122
#2  hrtimer_run_queues () at kernel/time/hrtimer.c:1448
#3  0xffffffc0000faaac in run_local_timers () at kernel/time/timer.c:1411
#4  update_process_times (user_tick=0) at kernel/time/timer.c:1383
#5  0xffffffc000106dfc in tick_periodic (cpu=<optimized out>) at
kernel/time/tick-common.c:91
#6  0xffffffc000107048 in tick_handle_periodic
(dev=0xffffffc006fcff40) at kernel/time/tick-common.c:103
#7  0xffffffc000469e30 in timer_handler (evt=<optimized out>,
access=<optimized out>)
    at drivers/clocksource/arm_arch_timer.c:148
#8  arch_timer_handler_virt (irq=<optimized out>, dev_id=<optimized
out>) at drivers/clocksource/arm_arch_timer.c:159
#9  0xffffffc0000eef7c in handle_percpu_devid_irq (irq=3,
desc=0xffffffc005804800) at kernel/irq/chip.c:714
#10 0xffffffc0000eb0d4 in generic_handle_irq_desc (desc=<optimized
out>, irq=<optimized out>) at include/linux/irqdesc.h:128
#11 generic_handle_irq (irq=3) at kernel/irq/irqdesc.c:351
#12 0xffffffc0000eb3e4 in __handle_domain_irq (domain=<optimized out>,
hwirq=<optimized out>, lookup=true,
    regs=<optimized out>) at kernel/irq/irqdesc.c:388
#13 0xffffffc00008241c in handle_domain_irq (regs=<optimized out>,
hwirq=<optimized out>, domain=<optimized out>)
    at include/linux/irqdesc.h:146
#14 gic_handle_irq (regs=0xffffffc005987cc0) at drivers/irqchip/irq-gic.c:276

which I think is this:

106 static inline unsigned __read_seqcount_begin(const seqcount_t *s)
107 {
108 >~~~~~~~unsigned ret;
109
110 repeat:
111 >~~~~~~~ret = READ_ONCE(s->sequence);
112 >~~~~~~~if (unlikely(ret & 1)) {
113 >~~~~~~~>~~~~~~~cpu_relax();
114 >~~~~~~~>~~~~~~~goto repeat;
115 >~~~~~~~}
116 >~~~~~~~return ret;
117 }

Breakpoint 1, csd_lock_wait (csd=<optimized out>) at kernel/smp.c:111
111 cpu_relax();
(gdb) bt
#0  csd_lock_wait (csd=<optimized out>) at kernel/smp.c:111
#1  smp_call_function_many (mask=<optimized out>,
func=0xffffffc000083800 <clear_os_lock>, info=0x0, wait=true)
    at kernel/smp.c:449
#2  0xffffffc00010ddc0 in smp_call_function (func=<optimized out>,
info=<optimized out>, wait=<optimized out>)
    at kernel/smp.c:473
#3  0xffffffc00010de20 in on_each_cpu (func=0xffffffc000083800
<clear_os_lock>, info=0x0, wait=<optimized out>)
    at kernel/smp.c:579
#4  0xffffffc00008385c in debug_monitors_init () at
arch/arm64/kernel/debug-monitors.c:151
#5  0xffffffc0000828c8 in do_one_initcall (fn=0xffffffc00008383c
<debug_monitors_init>) at init/main.c:785
#6  0xffffffc00073baf0 in do_initcall_level (level=<optimized out>) at
init/main.c:850
#7  do_initcalls () at init/main.c:858
#8  do_basic_setup () at init/main.c:877
#9  kernel_init_freeable () at init/main.c:998
#10 0xffffffc00054be04 in kernel_init (unused=<optimized out>) at
init/main.c:928
#11 0xffffffc000085bf0 in ret_from_fork () at arch/arm64/kernel/entry.S:635
#12 0xffffffc000085bf0 in ret_from_fork () at arch/arm64/kernel/entry.S:635
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Kernel baseline revision is 1d97b73f from linux-next tree.

Regards,
Peter

> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
