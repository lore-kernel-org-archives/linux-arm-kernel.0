From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jul 2015 17:51:16 +0100
Subject: [PATCH] ARM: socfpga: put back v7_invalidate_l1 in
 socfpga_secondary_startup
In-Reply-To: <1436370711-18524-1-git-send-email-dinguyen@opensource.altera.com>
References: <1436370711-18524-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150708165115.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 10:51:51AM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> The commit "02b4e2756e01 ARM: v7 setup function should invalidate L1 cache"
> caused the SoCFPGA to not boot reliably. About 20% of the time or roughly
> (1 in 5), booting the platform would cause this kernel panic:
> 
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted
> 4.1.0-rc8-next-20150617-00002-gdd1f624 #1
> Hardware name: Altera SOCFPGA
> task: eecaeac0 ti: eecce000 task.ti: eecce000
> PC is at vfp_notifier+0x58/0x12c
> LR is at notifier_call_chain+0x44/0x84
> pc : [<c000a6bc>]    lr : [<c003d134>]    psr: 80000193
> sp : eeccff48  ip : c06563c8  fp : eeccffd4
> r10: eecaef80  r9 : ef1f1300  r8 : 00000002
> r7 : eecd0000  r6 : c0656bc0  r5 : 00000000  r4 : eecd0000
> r3 : c000a664  r2 : eecd0000  r1 : 00000002  r0 : c06563c8
> Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 0000404a  DAC: 00000015
> Process swapper/1 (pid: 0, stack limit = 0xeecce218)
> Stack: (0xeeccff48 to 0xeecd0000)
> ff40:                   c000a664 ffffffff 00000000 c003d134 eecd0018 eecaeac0
> ff60: c06648e0 0b52d2f9 c048cfa8 c003d18c 00000000 f0002100 00000001 c003d1ac
> ff80: 00000000 eecaeac0 c064f300 c001369c c064b304 c0013140 00000000 ef1ed328
> ffa0: eeccffe8 c001e760 c0486ec4 2eba2000 c06957c0 c06524dc 00000015 c06957c0
> ffc0: c048c778 c064b304 c06957c0 00000000 eeccffdc c0486ec4 eeccffe4 c0487138
> ffe0: 00000001 c00544e8 c0009494 c0697bc0 00000000 000094ac 7ef5bffd 3f39b3f8
> [<c000a6bc>] (vfp_notifier) from [<c003d134>] (notifier_call_chain+0x44/0x84)
> [<c003d134>] (notifier_call_chain) from [<c003d18c>]
> (__atomic_notifier_call_chain+0x18/0x20)
> [<c003d18c>] (__atomic_notifier_call_chain) from [<c003d1ac>]
> (atomic_notifier_call_chain+0x18/0x20)
> [<c003d1ac>] (atomic_notifier_call_chain) from [<c001369c>]
> (__switch_to+0x34/0x58)
> Code: e3a03002 e5843208 e3a00000 e8bd8038 (eef85a10)
> ---[ end trace 9eaea9661b3b550a ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> SMP: failed to stop secondary CPUs
> ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> 
> So this patch puts back the call to v7_invalidate_l1 in the secondary_startup
> path, and the platform is now able to boot up reliably.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Can you print the value of CPACR in the oops and reproduce please?
I suspect, somehow, the CPACR is not allowing CPU1 access to the VFP,
but this is not controlled by data as such (it can only go wrong if
the hotplug notifier call chain misses calling into the VFP code.)

We ought to understand what the cause of this is before reverting
this part of the patch.  Not having a SoCFPGA board means that I can't
do any investigation of this myself.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
