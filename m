From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Feb 2016 12:23:18 +0000
Subject: [PATCHv2 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <56AFCD09.8000807@redhat.com>
References: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
 <1454111218-3461-3-git-send-email-labbott@fedoraproject.org>
 <20160201122911.GF674@leverpostej> <56AFCD09.8000807@redhat.com>
Message-ID: <20160202122317.GA32305@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 01:24:25PM -0800, Laura Abbott wrote:
> On 02/01/2016 04:29 AM, Mark Rutland wrote:
> >Hi,
> >
> >On Fri, Jan 29, 2016 at 03:46:57PM -0800, Laura Abbott wrote:
> >>
> >>ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
> >>pages for debugging purposes. This requires memory be mapped
> >>with PAGE_SIZE mappings since breaking down larger mappings
> >>at runtime will lead to TLB conflicts. Check if debug_pagealloc
> >>is enabled at runtime and if so, map everyting with PAGE_SIZE
> >>pages. Implement the functions to actually map/unmap the
> >>pages at runtime.
> >>
> >>
> >>Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> >
> >I tried to apply atop of the arm64 for-next/pgtable branch, but git
> >wasn't very happy about that -- which branch/patches is this based on?
> >
> >I'm not sure if I'm missing something, have something I shouldn't, or if
> >my MTA is corrupting patches again...
> >
> 
> Hmmm, I based it off of your arm64-pagetable-rework-20160125 tag and
> Ard's patch for vmalloc and set_memory_* . The patches seem to apply
> on the for-next/pgtable branch as well so I'm guessing you are missing
> Ard's patch.

Yup, that was it. I evidently was paying far too little attention as I'd
also missed the mm/ patch for the !CONFIG_DEBUG_PAGEALLOC case.

Is there anything else in mm/ that I've potentially missed? I'm seeing a
hang on Juno just after reaching userspace (splat below) with
debug_pagealloc=on.

It looks like something's gone wrong around find_vmap_area -- at least
one CPU is forever awaiting vmap_area_lock, and presumably some other
CPU has held it and gone into the weeds, leading to the RCU stalls and
NMI lockup warnings.

[   31.037054] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   31.042684]  0-...: (1 ticks this GP) idle=999/140000000000001/0 softirq=738/738 fqs=418 
[   31.050795]  (detected by 1, t=5255 jiffies, g=340, c=339, q=50)
[   31.056935] rcu_preempt kthread starved for 4838 jiffies! g340 c339 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0
[   36.509055] NMI watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [kworker/2:2H:995]
[   36.521059] NMI watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [systemd-udevd:1048]
[   36.533056] NMI watchdog: BUG: soft lockup - CPU#4 stuck for 23s! [systemd-udevd:1037]
[   36.545055] NMI watchdog: BUG: soft lockup - CPU#5 stuck for 23s! [systemd-udevd:1036]
[   56.497055] NMI watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [upstart-file-br:1012]
[   94.057052] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   94.062671]  0-...: (1 ticks this GP) idle=999/140000000000001/0 softirq=738/738 fqs=418 
[   94.070780]  (detected by 1, t=21010 jiffies, g=340, c=339, q=50)
[   94.076981] rcu_preempt kthread starved for 20593 jiffies! g340 c339 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[  157.077052] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  157.082673]  0-...: (1 ticks this GP) idle=999/140000000000001/0 softirq=738/738 fqs=418 
[  157.090782]  (detected by 2, t=36765 jiffies, g=340, c=339, q=50)
[  157.096986] rcu_preempt kthread starved for 36348 jiffies! g340 c339 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[  220.097052] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  220.102670]  0-...: (1 ticks this GP) idle=999/140000000000001/0 softirq=738/738 fqs=418 
[  220.110779]  (detected by 2, t=52520 jiffies, g=340, c=339, q=50)
[  220.116971] rcu_preempt kthread starved for 52103 jiffies! g340 c339 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[  283.117052] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  283.122670]  0-...: (1 ticks this GP) idle=999/140000000000001/0 softirq=738/738 fqs=418 
[  283.130779]  (detected by 1, t=68275 jiffies, g=340, c=339, q=50)
[  283.136973] rcu_preempt kthread starved for 67858 jiffies! g340 c339 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0

Typically show-backtrace-all-active-cpus(l) gives me something like:

[  183.282835] CPU: 0 PID: 998 Comm: systemd-udevd Tainted: G             L  4.5.0-rc1+ #7
[  183.290783] Hardware name: ARM Juno development board (r0) (DT)
[  183.296659] task: ffffffc97437a400 ti: ffffffc973ec8000 task.ti: ffffffc973ec8000
[  183.304095] PC is at _raw_spin_lock+0x34/0x48
[  183.308421] LR is at find_vmap_area+0x24/0xa0
[  183.312746] pc : [<ffffffc00065faf4>] lr : [<ffffffc000185bc4>] pstate: 60000145
[  183.320092] sp : ffffffc973ecb6c0
[  183.323382] x29: ffffffc973ecb6c0 x28: ffffffbde7d50300 
[  183.328662] x27: ffffffffffffffff x26: ffffffbde7d50300 
[  183.333941] x25: 000000097e513000 x24: 0000000000000001 
[  183.339219] x23: 0000000000000000 x22: 0000000000000001 
[  183.344498] x21: ffffffc000a6dd90 x20: ffffffc000a6d000 
[  183.349778] x19: ffffffc97540c000 x18: 0000007fc4e8b960 
[  183.355057] x17: 0000007fac3088d4 x16: ffffffc0001be448 
[  183.360336] x15: 003b9aca00000000 x14: 0032aa26d4000000 
[  183.365614] x13: ffffffffa94f64df x12: 0000000000000018 
[  183.370894] x11: ffffffc97eecd730 x10: 0000000000000030 
[  183.376173] x9 : ffffffbde7d50340 x8 : ffffffc0008556a0 
[  183.381451] x7 : ffffffc0008556b8 x6 : ffffffc0008556d0 
[  183.386729] x5 : ffffffc0009d2000 x4 : 0000000000000001 
[  183.392008] x3 : 000000000000d033 x2 : 000000000000000b 
[  183.397286] x1 : 00000000d038d033 x0 : ffffffc000a6dd90 
[  183.402563] 

I'll have a go with lock debugging. Otherwise do you have any ideas?

Thanks,
Mark.
