From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 4 Feb 2015 05:13:30 -0800
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <1423049947.19547.6.camel@AMDC1943>
References: <20150201025922.GA16820@wfg-t540p.sh.intel.com>
 <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
Message-ID: <20150204131330.GB5370@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 12:39:07PM +0100, Krzysztof Kozlowski wrote:
> +Cc some ARM people
> 
> 
> On wto, 2015-02-03 at 08:27 -0800, Paul E. McKenney wrote:
> > On Tue, Feb 03, 2015 at 11:01:42AM +0100, Krzysztof Kozlowski wrote:
> > > On sob, 2015-01-31 at 18:59 -0800, Fengguang Wu wrote:
> > > > Greetings,
> > > > 
> > > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git revert-c418b8035fac0cc7d242e5de126cec1006a34bed-dd2b39be8eee9d175c7842c30e405a5cbe50095a
> > > 
> > > On next-20150203 I hit similar error on ARM/Exynos4412 (Trats2 board)
> > > while suspending to RAM:
> > 
> > Yep, you are not supposed to be using RCU on offline CPUs, and RCU recently
> > got more picky about that.  This could cause failures in any environment
> > where CPUs could get delayed by more than one jiffy, which includes pretty
> > much all virtualized environements.
> > 
> > > [   30.986262] PM: Syncing filesystems ... done.
> > > [   30.994661] PM: Preparing system for mem sleep
> > > [   31.002064] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > > [   31.008629] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > > [   31.016325] PM: Entering mem sleep
> > > [   31.016338] Suspending console(s) (use no_console_suspend to debug)
> > > [   31.051009] random: nonblocking pool is initialized
> > > [   31.085811] wake enabled for irq 102
> > > [   31.086964] wake enabled for irq 123
> > > [   31.086972] wake enabled for irq 124
> > > [   31.090409] PM: suspend of devices complete after 59.684 msecs
> > > [   31.090524] CAM_ISP_CORE_1.2V: No configuration
> > > [   31.090534] VMEM_VDDF_3.0V: No configuration
> > > [   31.090543] VCC_SUB_2.0V: No configuration
> > > [   31.090552] VCC_SUB_1.35V: No configuration
> > > [   31.090562] VMEM_1.2V_AP: No configuration
> > > [   31.090587] MOTOR_VCC_3.0V: No configuration
> > > [   31.090596] LCD_VCC_3.3V: No configuration
> > > [   31.090605] TSP_VDD_1.8V: No configuration
> > > [   31.090614] TSP_AVDD_3.3V: No configuration
> > > [   31.090623] VMEM_VDD_2.8V: No configuration
> > > [   31.090631] VTF_2.8V: No configuration
> > > [   31.090640] VDDQ_PRE_1.8V: No configuration
> > > [   31.090649] VT_CAM_1.8V: No configuration
> > > [   31.090658] CAM_ISP_SEN_IO_1.8V: No configuration
> > > [   31.090667] CAM_SENSOR_CORE_1.2V: No configuration
> > > [   31.090677] VHSIC_1.8V: No configuration
> > > [   31.090685] VHSIC_1.0V: No configuration
> > > [   31.090694] VABB2_1.95V: No configuration
> > > [   31.090703] NFC_AVDD_1.8V: No configuration
> > > [   31.090712] VUOTG_3.0V: No configuration
> > > [   31.090721] VABB1_1.95V: No configuration
> > > [   31.090730] VMIPI_1.8V: No configuration
> > > [   31.090739] CAM_ISP_MIPI_1.2V: No configuration
> > > [   31.090747] VMIPI_1.0V: No configuration
> > > [   31.090756] VPLL_1.0V_AP: No configuration
> > > [   31.090765] VMPLL_1.0V_AP: No configuration
> > > [   31.090773] VCC_1.8V_IO: No configuration
> > > [   31.090782] VCC_2.8V_AP: No configuration
> > > [   31.090791] VCC_1.8V_AP: No configuration
> > > [   31.090800] VM1M2_1.2V_AP: No configuration
> > > [   31.090809] VALIVE_1.0V_AP: No configuration
> > > [   31.100297] PM: late suspend of devices complete after 9.445 msecs
> > > [   31.108891] PM: noirq suspend of devices complete after 8.577 msecs
> > > [   31.109052] Disabling non-boot CPUs ...
> > > [   31.113921]
> > > [   31.113925] ===============================
> > > [   31.113928] [ INFO: suspicious RCU usage. ]
> > > [   31.113935] 3.19.0-rc7-next-20150203 #1914 Not tainted
> > > [   31.113938] -------------------------------
> > > [   31.113943] kernel/sched/fair.c:4740 suspicious rcu_dereference_check() usage!
> > > [   31.113946]
> > > [   31.113946] other info that might help us debug this:
> > > [   31.113946]
> > > [   31.113952]
> > > [   31.113952] RCU used illegally from offline CPU!
> > > [   31.113952] rcu_scheduler_active = 1, debug_locks = 0
> > > [   31.113957] 3 locks held by swapper/1/0:
> > > [   31.113988]  #0:  ((cpu_died).wait.lock){......}, at: [<c005a114>] complete+0x14/0x44
> > > [   31.114012]  #1:  (&p->pi_lock){-.-.-.}, at: [<c004a790>] try_to_wake_up+0x28/0x300
> > > [   31.114035]  #2:  (rcu_read_lock){......}, at: [<c004f1b8>] select_task_rq_fair+0x5c/0xa04
> > > [   31.114038]
> > > [   31.114038] stack backtrace:
> > > [   31.114046] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc7-next-20150203 #1914
> > > [   31.114050] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > > [   31.114076] [<c0014ce4>] (unwind_backtrace) from [<c0011c30>] (show_stack+0x10/0x14)
> > > [   31.114091] [<c0011c30>] (show_stack) from [<c04dc048>] (dump_stack+0x70/0xbc)
> > > [   31.114105] [<c04dc048>] (dump_stack) from [<c004f83c>] (select_task_rq_fair+0x6e0/0xa04)
> > > [   31.114118] [<c004f83c>] (select_task_rq_fair) from [<c004a83c>] (try_to_wake_up+0xd4/0x300)
> > > [   31.114129] [<c004a83c>] (try_to_wake_up) from [<c00598a0>] (__wake_up_common+0x4c/0x80)
> > > [   31.114140] [<c00598a0>] (__wake_up_common) from [<c00598e8>] (__wake_up_locked+0x14/0x1c)
> > > [   31.114150] [<c00598e8>] (__wake_up_locked) from [<c005a134>] (complete+0x34/0x44)
> > > [   31.114167] [<c005a134>] (complete) from [<c04d6ca4>] (cpu_die+0x24/0x84)
> > > [   31.114179] [<c04d6ca4>] (cpu_die) from [<c005a508>] (cpu_startup_entry+0x328/0x358)
> > 
> > And so you no longer get to invoke complete() from the CPU going offline
> > out of the idle loop.
> > 
> > How would you like to handle this?  One approach would be to make __cpu_die()
> > poll with appropriate duty cycle.
> 
> The polling could work but that would be somehow reinventing the
> wait/complete.

Yeah, well, the CPU has reached a point in the offline process where it
cannot use the scheduler, so...

> > Or is there some ARM-specific approach
> > that could work here?
> 
> I am not aware of such. Anyone?
> 
> > Another thing I could do would be to have an arch-specific Kconfig
> > variable that made ARM responsible for informing RCU that the CPU
> > was departing, which would allow a call to as follows to be placed
> > immediately after the complete():
> > 
> > rcu_cpu_notify(NULL, CPU_DYING_IDLE, (void *)(long)smp_processor_id());
> > 
> > Note:  This absolutely requires that the rcu_cpu_notify() -always-
> > be allowed to execute!!!  This will not work if there is -any- possibility
> > of __cpu_die() powering off the outgoing CPU before the call to
> > rcu_cpu_notify() returns.
> 
> The problem is that __cpu_die() (waiting for completion signal) may cut
> the power of dying CPU.

I was afraid of that...

> It could however wait for all RCU callbacks before powering down.
> rcu_barrier() would do the trick?
> 
> 	rcu_barrier();
>         if (!platform_cpu_kill(cpu))
>                 pr_err("CPU%u: unable to kill\n", cpu);

Unfortunately, no.  The rcu_barrier() function can block, which is
not permitted when preemption is disabled, as it is at this point
in the idle loop.

So polling loop, then?

							Thanx, Paul
