From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Jun 2017 12:26:02 +0100
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical Profiling
 Extension
In-Reply-To: <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
 <20170615105735.b89183a9190a261d3b8d132a@arm.com>
 <20170621153108.GC6041@arm.com>
 <20170622105640.c444b8b0f16266ba2c3ce304@arm.com>
 <20170622183620.GJ15336@arm.com>
 <20170627160758.cdaebc3e7f0cd88455e07763@arm.com>
Message-ID: <20170628112601.GD5981@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 04:07:58PM -0500, Kim Phillips wrote:
> I'm close to finishing the bts version of userspace, and have been
> testing a bit more thoroughly, so now I consistently see the excessive
> PADding when recording a CPU that's idle. I.e., when I taskset the perf
> record to the same CPU I specify to record's -C (taskset -c n perf
> record -C n), I get max. twenty-odd number of PAD bytes at the end of
> the AUX buffers in the perf.data file.  If, OTOH, I taskset -c n perf
> record -C m, where m != n, I get a couple of valid event records in the
> buffer, and the rest of the buffer is filled with PADding.
> 
> It wouldn't be a problem except that it's wastes too much space
> sometimes.  Here is a good output buffer sample from a --mmap-pages=,12
> run, with only 4 PADs tacked onto the end:
> 
> 0xd190 [0x30]: PERF_RECORD_AUXTRACE size: 0x48  offset: 0  ref: 0xe914f7e3ce  idx: 0  tid: -1  cpu: 2
> .
> . ... ARM SPE data: size 72 bytes
> .  00000000:  4a 01                                           B COND

[...]

> .  0000003b:  71 a5 39 e1 14 e9 00 00 00                      TS 1001077684645
> .  00000044:  00                                              PAD
> .  00000045:  00                                              PAD
> .  00000046:  00                                              PAD
> .  00000047:  00                                              PAD
> 
> whereas this one - from later on in the same run - is over 99% PADs: 
> 
> 0xd250 [0x30]: PERF_RECORD_AUXTRACE size: 0x5fc0  offset: 0xfffff4ae0044  ref: 0xe91cead1dd  idx: 0  tid: -1  cpu: 2
> .
> . ... ARM SPE data: size 24512 bytes
> .  00000000:  4a 00                                           B

[...]

> .  000000b0:  71 8f 4e e1 14 e9 00 00 00                      TS 1001077689999
> .  000000b9:  00                                              PAD
> ...ALL PADs...ALL PADs...ALL PADs...ALL PADs...ALL PADs...ALL PADs...
> .  00005fbf:  00                                              PAD

Interesting.

If you cat /proc/interrupts, do you see many more SPE interrupts on CPU
n than on m?

Otherwise, I wonder if this is some odd interaction with idle. Can you
try to forcefully load that other CPU?

e.g. run something like:

	taskset -c <n> sh -c 'while true; do done'

... in parallel with the tracer.

For reference, what was your event sample period (i.e. the value of
perf_event_attr::sample_period)?

Did you modify that at all with PERF_EVENT_IOC_PERIOD?

> So maybe there's an offset counter that isn't being reset properly;
> hopefully the parallel discussion with Mark will help find the problem.
> 
> FWIW, there is also this one I saw with mmap-pages set to 5
> (pages), which gets rounded up to 8 pages:

Sorry, *what* does the rounding upwards? Userspace, perf core, or the
driver? Where?

> the driver started memsetting places it shouldn't?:
>
> $ sudo ./perf record -c 512 -C 0 -e arm_spe/branch_filter=0,ts_enable=1,pa_enable=1,event_filter=0,load_filter=0,jitter=1,store_filter=0,min_latency=0/ --mmap-pages=,5 dd if=/dev/urandom of=/dev/null count=10000
> rounding mmap pages size to 32K (8 pages)
> 10000+0 records in
> 10000+0 records out
> 5120000 bytes (5.1 MB) copied, 1.3391 s, 3.8 MB/s
> [ 1885.042803] Unable to handle kernel paging request at virtual address ffff00000adac000
> [ 1885.042873] pgd = ffff00000ad48000
> [ 1885.042899] [ffff00000adac000] *pgd=00000000fdffe003, *pud=00000000fdffd003, *pmd=00000000fdff8003, *pte=0000000000000000
> [ 1885.043083] Internal error: Oops: 96000047 [#1] PREEMPT SMP
> [ 1885.043131] Modules linked in:
> [ 1885.043200] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.12.0-rc5-00039-gf1d4a187881e #34
> [ 1885.043299] Hardware name: FVP_Base_AEMv8A-AEMv8A (DT)
> [ 1885.043364] task: ffff000008c21a80 task.stack: ffff000008c10000
> [ 1885.043436] PC is at __memset+0x1ac/0x1d0
> [ 1885.043499] LR is at __arm_spe_pmu_next_off+0x6c/0xd8
> [ 1885.043600] pc : [<ffff00000837dbac>] lr : [<ffff0000086771e4>] pstate: 204001c9
> [ 1885.043600] sp : ffff80007df22d10
> [ 1885.043733] x29: ffff80007df22d10 x28: ffff000008c21a80 
> [ 1885.043819] x27: ffff000008c37768 x26: ffff80007df30280 
> [ 1885.043910] x25: ffff80007a109800 x24: 0000001d507d1906 
> [ 1885.044012] x23: ffff80007a601018 x22: ffff80007a3ebb00 
> [ 1885.044102] x21: ffff80007df36ab0 x20: ffff80007a3ebb00 
> [ 1885.044196] x19: ffff80007df36ab0 x18: 0000000000000000 
> [ 1885.044253] x17: 0000000000000000 x16: 0000000000000000 
> [ 1885.044339] x15: 0000000000000000 x14: ffff000008c21a80 
> [ 1885.044456] x13: 000080007532d000 x12: 000000003445d91d 
> [ 1885.044557] x11: 0000000000000000 x10: 0000000000001000 
> [ 1885.044600] x9 : 0000000000000000 x8 : ffff00000adac000 
> [ 1885.044729] x7 : 0000000000000000 x6 : 00000000000003ff 
> [ 1885.044800] x5 : 0000000000000400 x4 : 0000000000000000 
> [ 1885.044911] x3 : 0000000000000008 x2 : 0000000000003bff 
> [ 1885.045000] x1 : 0000000000000000 x0 : ffff00000ada8000 
> [ 1885.045100] Process swapper/0 (pid: 0, stack limit = 0xffff000008c10000)
> [ 1885.045179] Stack: (0xffff80007df22d10 to 0xffff000008c14000)
> [ 1885.045239] Call trace:

> [ 1885.046408] [<ffff00000837dbac>] __memset+0x1ac/0x1d0
> [ 1885.046499] [<ffff00000867729c>] arm_spe_perf_aux_output_begin+0x4c/0x1b8
> [ 1885.046599] [<ffff000008678424>] arm_spe_pmu_start+0x34/0xf0
> [ 1885.046695] [<ffff000008678548>] arm_spe_pmu_add+0x68/0x98
> [ 1885.046733] [<ffff00000814da54>] event_sched_in.isra.61+0xcc/0x218
> [ 1885.046879] [<ffff00000814dc08>] group_sched_in+0x68/0x1a0
> [ 1885.046981] [<ffff00000814dfd0>] ctx_sched_in+0x290/0x468
> [ 1885.047080] [<ffff00000814e23c>] perf_event_sched_in+0x94/0xa8
> [ 1885.047179] [<ffff00000814e2b4>] ctx_resched+0x64/0xb0
> [ 1885.047268] [<ffff00000814e500>] __perf_event_enable+0x200/0x238
> [ 1885.047366] [<ffff000008147118>] event_function+0x90/0xf0
> [ 1885.047452] [<ffff0000081499e8>] remote_function+0x60/0x70
> [ 1885.047514] [<ffff0000081194fc>] flush_smp_call_function_queue+0x9c/0x168
> [ 1885.047637] [<ffff00000811a2a0>] generic_smp_call_function_single_interrupt+0x10/0x18
> [ 1885.047733] [<ffff00000808e928>] handle_IPI+0xc0/0x1d8
> [ 1885.047799] [<ffff000008081700>] gic_handle_irq+0x80/0x178

> [ 1885.048900] [<ffff0000080827f4>] el1_irq+0xb4/0x128
> [ 1885.049009] [<ffff00000861018c>] cpuidle_enter_state+0x154/0x200
> [ 1885.049126] [<ffff000008610270>] cpuidle_enter+0x18/0x20
> [ 1885.049207] [<ffff0000080ddd08>] call_cpuidle+0x18/0x30
> [ 1885.049332] [<ffff0000080ddf44>] do_idle+0x19c/0x1d8
> [ 1885.049400] [<ffff0000080de114>] cpu_startup_entry+0x24/0x28
> [ 1885.049453] [<ffff0000087a6b30>] rest_init+0x80/0x90
> [ 1885.049500] [<ffff000008b10b3c>] start_kernel+0x374/0x388
> [ 1885.049617] [<ffff000008b101e0>] __primary_switched+0x64/0x6c
> [ 1885.049699] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428) 
> [ 1885.049800] ---[ end trace 31b9a9f27da95f58 ]---
> [ 1885.049900] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1885.050000] SMP: stopping secondary CPUs
> [ 1885.050204] Kernel Offset: disabled
> [ 1885.050240] Memory Limit: none
> [ 1885.050327] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

That's worrying. I'll see if I can reproduce this.

> It's not easily reproduced.
> 
> > > Meanwhile, when using fvp-base.dtb, my model setup stops booting the
> > > kernel after "smp: Bringing up secondary CPUs ...".  If I however take
> > > the second SPE node from fvp-base.dts and add it to my working device
> > > tree, I get this during the driver probe:
> > > 
> > > [    1.042063] arm_spe_pmu spe-pmu at 0: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > [    1.043582] arm_spe_pmu spe-pmu at 1: probed for CPUs 0-7 [max_record_sz 64, align 1, features 0xf]
> > > [    1.043631] genirq: Flags mismatch irq 6. 00004404 (arm_spe_pmu) vs. 00004404 (arm_spe_pmu)
> > 
> > Looks like you've screwed up your IRQ partitions, so you are effectively
> > registering the same device twice, which then blows up due to lack of shared
> > irqs.
> > 
> > Either remove one of the devices, or use IRQ partitions to restrict them
> > to unique sets of CPUs.
> 
> Right, but since I want to get parity with what you're running -
> fvp_base.dtb - I tried to debug the hang after "smp: Bringing up
> secondary CPUs ..." problem, and could only debug it to the PSCI driver
> hitting one of these cases:
> 
> case PSCI_RET_INVALID_PARAMS:
> case PSCI_RET_INVALID_ADDRESS:

Sounds like your DT is describing CPUs that don't exist (or perhaps the
same CPU several times). Certainly, PSCI and the kernel disagree on
which CPUS exist.

What exact DT are you using?

Are you using the bootwrapper, or ATF? I'm guessing you're using the
bootwrapper.

Which version of the bootwrapepr are you using? If it doesn't have
commit:

  ccdc936924b3682d ("Dynamically determine the set of CPUs")

... have you configured it appropriately with --with-cpu-ids?

How is your model configured? Which CPU IDs does it think exist?

> Note: it's yet another place I have to manually instrument the error
> path in a kernel driver in lieu of it being more naturally verbose by
> itself; I *implore* you to reconsider adding proper user messaging to
> arm_spe_pmu_event_init().

Given this is a FW configuration issue (i.e. a system-level error), I'm
more than happy to make the PSCI driver messages more helpful where
possible.

That's completely orthogonal to the SPE debug messages for requests made
by the user.

> I can't tell which part of the fvp-base device tree is not liked by the
> firmware; I tried different combinations of the PSCI node, different CPU
> enumerations (cpu at 100 vs cpu at 1), removing idle-states properties...any
> hints appreciated.

The bootwrapper doesn't support idle. So no idle-states should be in the
DT.

If you can share your DT, bootwrapper configuration, and model
configuration, I can try to debug this with you.

Thanks,
Mark.
