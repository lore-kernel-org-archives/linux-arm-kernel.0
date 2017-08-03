From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 3 Aug 2017 05:54:05 -0700
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <fb30a4c9-c606-5aa6-9663-5f4e6b36642c@redhat.com>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
 <20170802080827.GA15219@arm.com>
 <fb30a4c9-c606-5aa6-9663-5f4e6b36642c@redhat.com>
Message-ID: <20170803125405.GQ3730@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 09:25:40AM +0530, Pratyush Anand wrote:
> Hi Will,
> 
> On Wednesday 02 August 2017 01:38 PM, Will Deacon wrote:
> >Hi Pratyush,
> >
> >On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:
> >>I am observing following rcu_sched stall while executing `perf record -a  --
> >>sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
> >>waiting in csd_lock_wait() from where it never came out,and so the stall.
> >>Any help/pointer for further debugging would be very helpful. Problem also
> >>reproduced with 4.13.0-rc3.
> >When you say "also", which other kernel(s) show the problem? Is this a
> >recent regression? Which platform are you running on?
> 
> Other than 4.13.0-rc3 I had tested with 4.11 based kernel which has
> 4.11 vanila+some 4.12 patches back ported, and log which I had
> attached was from same kernel, thats why I mentioned that it
> reproduced with vanilla upstream as well.
> 
> >
> >It would be interesting to know what the other CPUs are doing, in particular
> >the target of the cross-call. Either it crashed spectacularly and didn't
> >unlock the csd lock, or the IPI somehow wasn't delivered.
> >
> >Do you see any other splats if you enable lock debugging?
> 
> It was same.
> 
> Following is the log from 4.13.0-rc3 + patch pointed by Peter:
> 
> [  173.649589] perf: interrupt took too long (4952 > 4902), lowering
> kernel.perf_event_max_sample_rate to 40300
> [  201.340926] INFO: rcu_sched self-detected stall on CPU
> [  201.345115] 	9-...: (6499 ticks this GP)
> idle=e1a/140000000000001/0 softirq=334/334 fqs=3250
> [  201.353617] 	 (t=6500 jiffies g=313 c=312 q=428)
> [  201.358220] Task dump for CPU 9:
> [  201.361431] perf            R  running task        0  1888   1864 0x00000202
> [  201.368462] Call trace:
> [  201.370897] [<ffff000008089498>] dump_backtrace+0x0/0x28c
> [  201.376276] [<ffff000008089748>] show_stack+0x24/0x2c
> [  201.381312] [<ffff00000810c5d0>] sched_show_task+0x19c/0x26c
> [  201.386952] [<ffff00000810df28>] dump_cpu_task+0x48/0x54
> [  201.392250] [<ffff00000816c564>] rcu_dump_cpu_stacks+0xac/0xf4
> [  201.398063] [<ffff00000816b714>] rcu_check_callbacks+0x908/0xc90
> [  201.404053] [<ffff000008172fe0>] update_process_times+0x34/0x5c
> [  201.409957] [<ffff00000818697c>] tick_sched_handle.isra.16+0x4c/0x70
> [  201.416292] [<ffff0000081869e8>] tick_sched_timer+0x48/0x88
> [  201.421847] [<ffff000008173c60>] __hrtimer_run_queues+0x17c/0x604
> [  201.427924] [<ffff000008174b90>] hrtimer_interrupt+0xa4/0x1e8
> [  201.433656] [<ffff0000086d9d34>] arch_timer_handler_phys+0x3c/0x48
> [  201.439818] [<ffff00000815b718>] handle_percpu_devid_irq+0xdc/0x42c
> [  201.446069] [<ffff00000815569c>] generic_handle_irq+0x34/0x4c
> [  201.451796] [<ffff000008155dec>] __handle_domain_irq+0x6c/0xc4
> [  201.457611] [<ffff0000080816c4>] gic_handle_irq+0xa0/0x1b0
> [  201.463080] Exception stack(0xffff8016df013a40 to 0xffff8016df013b70)
> [  201.469504] 3a40: 0000000000000000 0000000000000003
> 0000000000000000 ffff8016df013bd0
> [  201.477316] 3a60: ffff8016df013bd0 0000000000080000
> ffff8016df013bb8 ffff0000082113c8
> [  201.485129] 3a80: 0000000000000000 0000ffffe507a9f0
> 00000000ffffffff 0000000000000000
> [  201.492941] 3aa0: 0000000000000005 ffffffffffffffff
> 002f547d23157399 00003a2a9f82ac9c
> [  201.500754] 3ac0: 0000000000000000 0000000000000000
> 0000ffffe507a7e0 ffff000008f5b000
> [  201.508566] 3ae0: ffff8016df013c08 ffff000008213fcc
> 0000000000000013 ffff8017616a7800
> [  201.516379] 3b00: ffff000008f5b000 ffff0000082179d4
> 0000000000000000 ffff0000088c1000
> [  201.524191] 3b20: ffff8017616a7800 ffff8016df013b70
> ffff00000818bf04 ffff8016df013b70
> [  201.532004] 3b40: ffff00000818bf28 0000000020400145
> ffff000008213fcc 0000000000000013
> [  201.539816] 3b60: 0001000000000000 ffff8016df013bb8
> [  201.544677] [<ffff000008082eb8>] el1_irq+0xb8/0x140
> [  201.549539] [<ffff00000818bf28>] smp_call_function_single+0x160/0x184
> [  201.555965] [<ffff000008211128>] cpu_function_call+0x40/0x64
> [  201.561605] [<ffff0000082113a0>] event_function_call+0x120/0x128
> [  201.567594] [<ffff0000082113ec>] _perf_event_disable+0x44/0x64
> [  201.573410] [<ffff000008210afc>] perf_event_for_each_child+0x3c/0x84

How many events are involved here?  If there is a huge number, then
the RCU CPU stall warning is expected behavior.

If this is the case, sticking a cond_resched_rcu_qs() in the loop
should fix this.

							Thanx, Paul

> [  201.579747] [<ffff00000821bcfc>] perf_ioctl+0x21c/0x9a4
> [  201.584957] [<ffff0000082eec6c>] do_vfs_ioctl+0xcc/0x874
> [  201.590250] [<ffff0000082ef4a4>] sys_ioctl+0x90/0xa4
> [  201.595198] [<ffff0000080834a0>] __sys_trace_return+0x0/0x4
> [  239.003035] INFO: rcu_sched detected expedited stalls on
> CPUs/tasks: { 9-... } 6592 jiffies s: 1149 root: 0x1/.
> [  239.012199] blocking rcu_node structures: l=1:0-14:0x200/.
> [  239.017695] Task dump for CPU 9:
> [  239.020880] perf            R  running task        0  1888   1864 0x00000202
> [  239.027929] Call trace:
> [  239.030346] [<ffff000008085c9c>] __switch_to+0x64/0x70
> [  239.035484] [<ffff000008235a00>] free_pcppages_bulk+0x43c/0x640
> [  262.304244] perf: interrupt took too long (6221 > 6190), lowering
> kernel.perf_event_max_sample_rate to 32100
> [  367.009704] INFO: task kworker/15:2:1187 blocked for more than 120 seconds.
> [  367.015713]       Tainted: G        W       4.13.0-rc3+ #2
> [  367.021200] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  367.028994] kworker/15:2    D    0  1187      2 0x00000000
> [  367.034481] Workqueue: usb_hub_wq hub_event
> [  367.038629] Call trace:
> [  367.041077] [<ffff000008085c9c>] __switch_to+0x64/0x70
> [  367.046184] [<ffff0000088a3680>] __schedule+0x410/0xcbc
> [  367.051403] [<ffff0000088a3f6c>] schedule+0x40/0xa4
> [  367.056253] [<ffff00000816a578>]
> _synchronize_rcu_expedited.constprop.64+0x370/0x3e8
> [  367.063990] [<ffff00000816a66c>] synchronize_sched_expedited+0x7c/0xf0
> [  367.070501] [<ffff00000816aa0c>] synchronize_rcu_expedited+0x14/0x1c
> [  367.076825] [<ffff00000825ec24>] bdi_unregister+0x78/0x200
> [  367.082307] [<ffff00000841fbac>] del_gendisk+0x130/0x240
> [  367.087592] [<ffff000003de0688>] sr_remove+0x30/0x90 [sr_mod]
> [  367.093333] [<ffff00000859901c>] device_release_driver_internal+0x15c/0x1dc
> [  367.100275] [<ffff0000085990c4>] device_release_driver+0x28/0x34
> [  367.106251] [<ffff00000859794c>] bus_remove_device+0xe4/0x14c
> [  367.111993] [<ffff000008593890>] device_del+0x1dc/0x308
> [  367.117191] [<ffff0000085e121c>] __scsi_remove_device+0xfc/0x128
> [  367.123192] [<ffff0000085de894>] scsi_forget_host+0x74/0x78
> [  367.128778] [<ffff0000085d0cf8>] scsi_remove_host+0x7c/0x120
> [  367.134396] [<ffff000000ad3720>] usb_stor_disconnect+0x58/0xc8 [usb_storage]
> [  367.141421] [<ffff000008636fd8>] usb_unbind_interface+0x7c/0x268
> [  367.147397] [<ffff00000859901c>] device_release_driver_internal+0x15c/0x1dc
> [  367.154355] [<ffff0000085990c4>] device_release_driver+0x28/0x34
> [  367.160344] [<ffff00000859794c>] bus_remove_device+0xe4/0x14c
> [  367.166060] [<ffff000008593890>] device_del+0x1dc/0x308
> [  367.171282] [<ffff0000086344fc>] usb_disable_device+0xc4/0x2ac
> [  367.177084] [<ffff000008629de4>] usb_disconnect+0x98/0x248
> [  367.182566] [<ffff000008629ff8>] hub_quiesce+0x64/0xac
> [  367.187674] [<ffff00000862bfc0>] hub_event+0x110/0xa8c
> [  367.192810] [<ffff0000080f2a64>] process_one_work+0x228/0x6a8
> [  367.198568] [<ffff0000080f2f44>] worker_thread+0x60/0x3bc
> [  367.203922] [<ffff0000080faa40>] kthread+0x114/0x140
> [  367.208898] [<ffff0000080833d0>] ret_from_fork+0x10/0x40
> [  367.214171] INFO: task kworker/15:3:1890 blocked for more than 120 seconds.
> [  367.221108]       Tainted: G        W       4.13.0-rc3+ #2
> [  367.226563] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  367.234388] kworker/15:3    D    0  1890      2 0x00000200
> [  367.239918] Workqueue: events wait_rcu_exp_gp
> [  367.244184] Call trace:
> [  367.246615] [<ffff000008085c9c>] __switch_to+0x64/0x70
> [  367.251751] [<ffff0000088a3680>] __schedule+0x410/0xcbc
> [  367.256945] [<ffff0000088a3f6c>] schedule+0x40/0xa4
> [  367.261820] [<ffff0000088a936c>] schedule_timeout+0x1e8/0x454
> [  367.267536] [<ffff000008165da0>] rcu_exp_wait_wake+0xb8/0x5b0
> [  367.273278] [<ffff00000816a1f8>] wait_rcu_exp_gp+0x3c/0x4c
> [  367.278776] [<ffff0000080f2a64>] process_one_work+0x228/0x6a8
> [  367.284475] [<ffff0000080f2f44>] worker_thread+0x60/0x3bc
> [  367.289931] [<ffff0000080faa40>] kthread+0x114/0x140
> [  367.294793] [<ffff0000080833d0>] ret_from_fork+0x10/0x40
> [  367.300100] INFO: lockdep is turned off.
> 
> -- 
> Regards
> Pratyush
> 
