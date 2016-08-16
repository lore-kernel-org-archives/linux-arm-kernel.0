From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Aug 2016 17:03:46 +0100
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
In-Reply-To: <CAOMZO5B+d3JQKh7AjhnF7N+72kwb1Pn9FB9M_04-DP9Z49GEDg@mail.gmail.com>
References: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
 <CAOMZO5B+d3JQKh7AjhnF7N+72kwb1Pn9FB9M_04-DP9Z49GEDg@mail.gmail.com>
Message-ID: <57B33962.7020104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/16 16:52, Fabio Estevam wrote:
> Hi Marc,
> 
> On Tue, Aug 16, 2016 at 12:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Not all of the ARM HW is IPI capable (i.e. most of the non-SMP
>> systems). Unfortunately, some systems do advertise being SMP
>> capable, even if they have a single core and do not define
>> a cross call method. In this case, irq_work_queue dies
>> as arch_irq_work_has_interrupt() fails to detect this
>> particular case.
>>
>> Let's redefine arch_irq_work_has_interrupt() to actually check
>> if we're IPI capable instead of simply being SMP. This sidesteps
>> the issue entierely.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> With this patch applied I still get a hang after running the 'reboot'
> command on a mx6ul:
> 
> Requesting system reboot
> [    9.659735] ci_hdrc ci_hdrc.1: remove, state 4
> [    9.665652] usb usb1: USB disconnect, device number 1
> [    9.697777] ci_hdrc ci_hdrc.1: USB bus 1 deregistered
> [   35.741678] INFO: rcu_sched detected stalls on CPUs/tasks:
> [   35.747244]  (detected by 0, t=2602 jiffies, g=-92, c=-93, q=13)
> [   35.753324] All QSes seen, last rcu_sched kthread activity 2602 (-26427--2900
> [   35.764480] init            R running      0   151      1 0x00000002
> [   35.770919] Backtrace:
> [   35.773455] [<c010b71c>] (dump_backtrace) from [<c010b8b8>] (show_stack+0x18)
> [   35.781051]  r6:c0e6e017 r5:00000001 r4:ce3c8c00 r3:00000000
> [   35.786863] [<c010b8a0>] (show_stack) from [<c0150178>] (sched_show_task+0x1)
> [   35.794742] [<c0150054>] (sched_show_task) from [<c018807c>] (rcu_check_call)
> [   35.803378]  r6:c0d78340 r5:c0e154c0 r4:cedd1340
> [   35.808120] [<c0187830>] (rcu_check_callbacks) from [<c018b0f0>] (update_pro)
> [   35.817013]  r10:c0e229e8 r9:c019cbd4 r8:cedce908 r7:ce3afd98 r6:cedce908 r50
> [   35.824998]  r4:ce3c8c00
> [   35.827596] [<c018b0b8>] (update_process_times) from [<c019cb18>] (tick_sche)
> [   35.836314]  r5:00000008 r4:51acc1a4
> [   35.839977] [<c019cac8>] (tick_sched_handle) from [<c019cc34>] (tick_sched_t)
> [   35.848369] [<c019cbd4>] (tick_sched_timer) from [<c018bb7c>] (__hrtimer_run)
> [   35.857089]  r7:cedce640 r6:cedce5c0 r5:cedce64c r4:00000000
> [   35.862897] [<c018ba94>] (__hrtimer_run_queues) from [<c018c3a8>] (hrtimer_i)
> [   35.871702]  r10:cedce698 r9:cedce678 r8:cedce6b8 r7:cedce5c0 r6:cedce600 r53
> [   35.879685]  r4:ffffffff
> [   35.882283] [<c018c2e0>] (hrtimer_interrupt) from [<c06a6c5c>] (mxc_timer_in)
> [   35.890916]  r10:c0e6e052 r9:d0805000 r8:ce81d000 r7:00000010 r6:ce3afcd4 r50
> [   35.898899]  r4:ce802440
> [   35.901495] [<c06a6c20>] (mxc_timer_interrupt) from [<c0179514>] (__handle_i)
> [   35.910909]  r4:ce802500 r3:c06a6c20
> [   35.914572] [<c01794b8>] (__handle_irq_event_percpu) from [<c0179628>] (hand)
> [   35.924246]  r10:ce806000 r9:d0805000 r8:00000001 r7:00000000 r6:c0e103b8 r50
> [   35.932228]  r4:ce81d000
> [   35.934822] [<c0179604>] (handle_irq_event_percpu) from [<c01796a4>] (handle)
> [   35.943715]  r5:ce81d060 r4:ce81d000
> [   35.947382] [<c0179664>] (handle_irq_event) from [<c017cda0>] (handle_fasteo)
> [   35.955929]  r6:c0e103b8 r5:ce81d060 r4:ce81d000 r3:00000000
> [   35.961737] [<c017cccc>] (handle_fasteoi_irq) from [<c0178cbc>] (generic_han)
> [   35.970368]  r7:00000000 r6:c0d75fa8 r5:c0e02b1c r4:00000010
> [   35.976175] [<c0178c9c>] (generic_handle_irq) from [<c0178e00>] (__handle_do)
> [   35.984914] [<c0178d94>] (__handle_domain_irq) from [<c01015e0>] (gic_handle)
> [   35.993285]  r10:000003eb r8:c0e22c00 r7:c0e02c80 r6:ce3afd98 r5:d080400c r40
> [   36.001286] [<c0101594>] (gic_handle_irq) from [<c010c4f0>] (__irq_svc+0x70/)
> [   36.008796] Exception stack(0xce3afd98 to 0xce3afde0)
> [   36.013877] fd80:                                                       ce311
> [   36.022093] fda0: 00000000 00000003 ce313adc ce312200 c0e02a50 ce313a80 c0100
> [   36.030306] fdc0: 00000000 ce3afdfc ce3afe00 ce3afde8 c066a1a8 c01b47f0 2000f
> [   36.038503]  r10:00000000 r9:ce3ae000 r8:c0108084 r7:ce3afdcc r6:ffffffff r53
> [   36.046488]  r4:c01b47f0 r3:ce3c8c00
> [   36.050165] [<c01b47bc>] (irq_work_sync) from [<c066a1a8>] (cpufreq_dbs_gove)
> [   36.058974]  r4:00000004 r3:00000001
> [   36.062649] [<c066a158>] (cpufreq_dbs_governor_stop) from [<c0666d74>] (cpuf)
> [   36.072149]  r7:c1658f10 r6:c0e4dd20 r5:ce3122e0 r4:ce312200
> [   36.077953] [<c0666d3c>] (cpufreq_stop_governor) from [<c0666de8>] (cpufreq_)
> [   36.086698] [<c0666d7c>] (cpufreq_suspend) from [<c04ea7d4>] (syscore_shutdo)
> [   36.094897]  r7:00000000 r6:c0e70020 r5:c0e322f0 r4:c0e4dd44
> [   36.100703] [<c04ea788>] (syscore_shutdown) from [<c0147f74>] (kernel_restar)
> [   36.108814]  r6:c0e139bc r5:4321fedc r4:00000000 r3:ce834980
> [   36.114613] [<c0147f58>] (kernel_restart) from [<c0148190>] (SyS_reboot+0x18)
> [   36.122377]  r4:01234567 r3:01234567
> [   36.126042] [<c0148004>] (SyS_reboot) from [<c0107ee0>] (ret_fast_syscall+0x)
> [   36.133719]  r7:00000058 r6:000bf7d8 r5:00000000 r4:00000000
> [   36.139518] rcu_sched kthread starved for 2602 jiffies! g4294967204 c42949670
> [   36.149972] rcu_sched       R running      0     7      2 0x00000000
> [   36.156409] Backtrace:
> [   36.158923] [<c0923294>] (__schedule) from [<c0923ae4>] (schedule+0x3c/0xa0)
> [   36.165997]  r10:00000000 r9:c0e02b1c r8:ffffffff r7:c0e02100 r6:ffff8e9c r58
> [   36.173985]  r4:cedcd4c0
> [   36.176581] [<c0923aa8>] (schedule) from [<c0928070>] (schedule_timeout+0x21)
> [   36.184366] [<c0927e5c>] (schedule_timeout) from [<c0186e4c>] (rcu_gp_kthrea)
> [   36.192651]  r10:00000001 r9:00000003 r8:00000000 r7:000002b8 r6:00000001 r50
> [   36.200631]  r4:c0e154c0
> [   36.203227] [<c0186a9c>] (rcu_gp_kthread) from [<c0145330>] (kthread+0xd8/0x)
> [   36.210558]  r7:c0186a9c
> [   36.213154] [<c0145258>] (kthread) from [<c0107f70>] (ret_from_fork+0x14/0x2)
> [   36.220396]  r7:00000000 r6:00000000 r5:c0145258 r4:ce835000
> 
> With your previous proposal from:
> http://www.spinics.net/lists/arm-kernel/msg522576.html
> 
> , the 'reboot' command works fine.

This is no an either/or situation. This patch is required for systems
that identify themselves as SMP, and yet do not register an IPI method.

Your own particular case is that you do register an IPI method, but have
a GIC that is not capable of self IPI-ing using a target list. If you
didn't register that method, this patch would do the trick, as the IRQ
work will be picked up on the following timer tick.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
