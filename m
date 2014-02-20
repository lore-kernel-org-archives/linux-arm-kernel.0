From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 20 Feb 2014 12:28:25 +0530
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <20140219161236.GG28173@mudshark.cambridge.arm.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
 <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
 <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
 <20140219113157.GG30457@arm.com> <20140219160359.GB22252@arm.com>
 <20140219161236.GG28173@mudshark.cambridge.arm.com>
Message-ID: <CALicx6t7RSS_Zo9RGr76LMnNth1gQ7pukUtAmDY4gWRN5KGVKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Feb 19, 2014 at 9:42 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Feb 19, 2014 at 04:03:59PM +0000, Catalin Marinas wrote:
>> On Wed, Feb 19, 2014 at 11:31:57AM +0000, Catalin Marinas wrote:
>> > BUG: scheduling while atomic: kworker/u8:0/6/0x00000002
>> > Modules linked in:
>> > CPU: 1 PID: 6 Comm: kworker/u8:0 Not tainted 3.14.0-rc3+ #306
>> > Workqueue: khelper __call_usermodehelper
>> > Call trace:
>> > [<ffffffc000087dbc>] dump_backtrace+0x0/0x12c
>> > [<ffffffc000087efc>] show_stack+0x14/0x1c
>> > [<ffffffc00043c224>] dump_stack+0x78/0xc4
>> > [<ffffffc000439b48>] __schedule_bug+0x40/0x54
>> > [<ffffffc00043d67c>] __schedule+0x514/0x604
>> > [<ffffffc00043d794>] schedule+0x28/0x78
>> > [<ffffffc00043cc90>] schedule_timeout+0x170/0x1bc
>> > [<ffffffc00043e16c>] wait_for_common+0xc0/0x14c
>> > [<ffffffc00043e280>] wait_for_completion_killable+0x14/0x28
>> > [<ffffffc0000942f8>] do_fork+0x158/0x2a8
>> > [<ffffffc000094478>] kernel_thread+0x30/0x38
>> > [<ffffffc0000a842c>] __call_usermodehelper+0x34/0xa8
>> > [<ffffffc0000ab300>] process_one_work+0x118/0x354
>> > [<ffffffc0000abfcc>] worker_thread+0x13c/0x3c0
>> > [<ffffffc0000b1e84>] kthread+0xd4/0xe8
>> >
>> >
>> > It gets much worse if I run with two CPUs and CONFIG_KGDB_KDB enabled
>> > (but fine with a single CPU).
>> >
>> > So no need to post another series for now but please check the multi-CPU
>> > case as well and send a separate fix. I'll dig a bit on my side as well.
>>
>> So far I'm done with the investigation. It looks to me like one of the
>> kgdb tests, kgdb core or the arm64 back-end (or maybe more than one) is
>> not SMP safe. The errors either appear or disappear based on the printks
>> I put through the kgdb test or other config options which I enable.
>>
>> Could you please look into making the kgdb back-end SMP-safe?
>
> There are certainly potential SMP problems in the back-end, which I asked
> about in the initial series:
>
>   http://lkml.kernel.org/r/CALicx6v1eGHRwWPrjzihzBZxCu8t1vpMoq-YfutSm4mRmP6gEQ at mail.gmail.com
>
> The reply from Vijay suggested that everything is confined to a single CPU.
>

  This issue is seen only when kgdb test is triggered on secondary cpu's.
when executed on cpu0 issue is not seen. Though cpu0 triggers kgdb tests
the do_fork test might trigger debug exception on other cpu's as well,
which fails.

For the patch 1 you suggested me to call local_dbg_enable() from
clear_os_mask() function
as below

static void clear_os_lock(void *unused)
{
        asm volatile("msr oslar_el1, %0" : : "r" (0));
        isb();
        local_dbg_enable();
}

This is an SMP call. So when more than one core is enabled, this
local_dbg_enable() is called
from SMP call context, which is el1_irq context for secondary cpu's.
So PSTATE.D flag is unmasked
only in irq context but not in normal context.

For CPU0 this clear_os_lock() is not called from smp call. it is
directly called in debug_monitors_init()
call. So PSTATE.D is unmasked for CPU0 and hence kgdb tests passed
when triggered only on
cpu0.

static int debug_monitors_init(void)
{
        /* Clear the OS lock. */
        smp_call_function(clear_os_lock, NULL, 1);
        clear_os_lock(NULL);

        /* Register hotplug handler. */
        register_cpu_notifier(&os_lock_nb);
        return 0;
}

When I made below patch it works. I have tested with 4 cores on foundation model

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -160,6 +160,8 @@ asmlinkage void secondary_start_kernel(void)
        set_cpu_online(cpu, true);
        complete(&cpu_running);

+       local_dbg_enable();
        local_irq_enable();
        local_async_enable();

kgdb: Registered I/O driver kgdbts.
kgdbts:RUN plant and detach test
kgdbts:RUN sw breakpoint test
kgdbts:RUN bad memory access test
kgdbts:RUN singlestep test 1000 iterations
kgdbts:RUN singlestep [0/1000]
kgdbts:RUN singlestep [100/1000]
kgdbts:RUN singlestep [200/1000]
kgdbts:RUN singlestep [300/1000]
kgdbts:RUN singlestep [400/1000]
kgdbts:RUN singlestep [500/1000]
kgdbts:RUN singlestep [600/1000]
kgdbts:RUN singlestep [700/1000]
kgdbts:RUN singlestep [800/1000]
kgdbts:RUN singlestep [900/1000]
kgdbts:RUN do_fork for 100 breakpoints
smc91x: not found (-19).
mousedev: PS/2 mouse device common for all mice
TCP: cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
EXT4-fs (vda2): recovery complete
EXT4-fs (vda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 254:2.
Freeing unused kernel memory: 256K (ffffffc0005d1000 - ffffffc000611000)
udevd[476]: starting version 182
EXT4-fs (vda2): re-mounted. Opts: data=ordered
random: dd urandom read with 11 bits of entropy available
rpcbind: cannot create socket for udp6
rpcbind: cannot create socket for tcp6
rpcbind: cannot get uid of '': Success

Last login: Mon Jan 27 08:00:01 UTC 2014 on tty1
root at genericarmv8:~# kgdb: Unregistered I/O driver kgdbts, debugger disabled.

root at genericarmv8:~# uname -a
Linux genericarmv8 3.14.0-rc3+ #18 SMP PREEMPT Thu Feb 20 11:53:17 IST
2014 aarch64 GNU/Linux
root at genericarmv8:~# cat /proc/cpuinfo
Processor       : AArch64 Processor rev 0 (aarch64)
processor       : 0
processor       : 1
processor       : 2
processor       : 3
Features        : fp asimd evtstrm
CPU implementer : 0x41
CPU architecture: AArch64
CPU variant     : 0x0
CPU part        : 0xd00
CPU revision    : 0

Hardware        : Foundation-v8A
root at genericarmv8:~#

- Vijay

> Will
