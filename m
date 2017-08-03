From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 3 Aug 2017 08:19:25 +0100
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <fb30a4c9-c606-5aa6-9663-5f4e6b36642c@redhat.com>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
 <20170802080827.GA15219@arm.com>
 <fb30a4c9-c606-5aa6-9663-5f4e6b36642c@redhat.com>
Message-ID: <20170803081925.0a154606@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Aug 2017 09:25:40 +0530
Pratyush Anand <panand@redhat.com> wrote:

> Hi Will,
> 
> On Wednesday 02 August 2017 01:38 PM, Will Deacon wrote:
> > Hi Pratyush,
> > 
> > On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:  
> >> I am observing following rcu_sched stall while executing `perf record -a  --
> >> sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
> >> waiting in csd_lock_wait() from where it never came out,and so the stall.
> >> Any help/pointer for further debugging would be very helpful. Problem also
> >> reproduced with 4.13.0-rc3.  
> > When you say "also", which other kernel(s) show the problem? Is this a
> > recent regression? Which platform are you running on?  
> 
> Other than 4.13.0-rc3 I had tested with 4.11 based kernel which has 4.11 
> vanila+some 4.12 patches back ported, and log which I had attached was from 
> same kernel, thats why I mentioned that it reproduced with vanilla upstream as 
> well.
> 
> > 
> > It would be interesting to know what the other CPUs are doing, in particular
> > the target of the cross-call. Either it crashed spectacularly and didn't
> > unlock the csd lock, or the IPI somehow wasn't delivered.
> > 
> > Do you see any other splats if you enable lock debugging?  
> 
> It was same.
> 
> Following is the log from 4.13.0-rc3 + patch pointed by Peter:
> 
> [  173.649589] perf: interrupt took too long (4952 > 4902), lowering 
> kernel.perf_event_max_sample_rate to 40300
> [  201.340926] INFO: rcu_sched self-detected stall on CPU
> [  201.345115] 	9-...: (6499 ticks this GP) idle=e1a/140000000000001/0 
> softirq=334/334 fqs=3250
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
> [  201.469504] 3a40: 0000000000000000 0000000000000003 0000000000000000 
> ffff8016df013bd0
> [  201.477316] 3a60: ffff8016df013bd0 0000000000080000 ffff8016df013bb8 
> ffff0000082113c8
> [  201.485129] 3a80: 0000000000000000 0000ffffe507a9f0 00000000ffffffff 
> 0000000000000000
> [  201.492941] 3aa0: 0000000000000005 ffffffffffffffff 002f547d23157399 
> 00003a2a9f82ac9c
> [  201.500754] 3ac0: 0000000000000000 0000000000000000 0000ffffe507a7e0 
> ffff000008f5b000
> [  201.508566] 3ae0: ffff8016df013c08 ffff000008213fcc 0000000000000013 
> ffff8017616a7800
> [  201.516379] 3b00: ffff000008f5b000 ffff0000082179d4 0000000000000000 
> ffff0000088c1000
> [  201.524191] 3b20: ffff8017616a7800 ffff8016df013b70 ffff00000818bf04 
> ffff8016df013b70
> [  201.532004] 3b40: ffff00000818bf28 0000000020400145 ffff000008213fcc 
> 0000000000000013
> [  201.539816] 3b60: 0001000000000000 ffff8016df013bb8
> [  201.544677] [<ffff000008082eb8>] el1_irq+0xb8/0x140
> [  201.549539] [<ffff00000818bf28>] smp_call_function_single+0x160/0x184

[...]

We really need to get to the bottom of what is happening at that point.
Either the targeted CPU has not received the IPI, or it has locked-up
before replying to the source CPU. You probably want to instrument the
SMP code and find out what that CPU is doing, as there is little in
that trace that tells us what is happening.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
