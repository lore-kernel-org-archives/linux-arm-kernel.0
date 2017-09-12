From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 12 Sep 2017 14:55:35 +0200
Subject: [PATCH 0/2] ARM: owl: Add CubieBoard6
In-Reply-To: <20170911005805.10116-1-afaerber@suse.de>
References: <20170911005805.10116-1-afaerber@suse.de>
Message-ID: <f31a5de2-d560-6430-0949-6de9843e47d3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.09.2017 um 02:58 schrieb Andreas F?rber:
> With this Device Tree it starts to boot, but it gets stuck during earlycon:
> 
> [    0.899855] cpuidle: using governor ladder
> [    0.904118] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
> [    0.911498] Modules linked in:
> [    0.914552] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.13.0-next-20170908-00003-gbc21950343e1 #38
> [    0.923486] Hardware name: Generic DT based system
> [    0.928263] task: ee833840 task.stack: ee834000
> [    0.932804] PC is at arch_hw_breakpoint_init+0xa0/0x2ac
> [    0.938015] LR is at arch_hw_breakpoint_init+0x88/0x2ac
> [    0.943223] pc : [<c09044a0>]    lr : [<c0904488>]    psr: 60000013
> [    0.949469] sp : ee835ef8  ip : c09005a0  fp : 00000000
> [    0.954676] r10: c092e83c  r9 : 0000009a  r8 : c0939624
> [    0.959882] r7 : c092e828  r6 : c0a3463c  r5 : c0a3463c  r4 : 00000001
> [    0.966388] r3 : 0000000f  r2 : 510002d0  r1 : 00000000  r0 : 00000003
> [    0.972898] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    0.980013] Control: 10c5387d  Table: 0000404a  DAC: 00000051
> [    0.985740] Process swapper/0 (pid: 1, stack limit = 0xee834218)
> [    0.991727] Stack: (0xee835ef8 to 0xee836000)
> [    0.996069] 5ee0:                                                       c0a24844 c0a2b47c
> [    1.004228] 5f00: 00000000 c05adf6c 00000003 c0904400 00000000 c01019f0 0000009a 0000009a
> [    1.012388] 5f20: eeff7200 eeff72c9 c08a5aec 0000009a 0000009a c0137b54 c08a4ee4 00000000
> [    1.020546] 5f40: 00000003 00000003 eeff72c9 eeff72d1 c0a0b7f4 00000003 c0a34300 c0a34300
> [    1.028704] 5f60: 00000003 c0a34300 c0a34300 c0939624 0000009a c0900dd0 00000003 00000003
> [    1.036862] 5f80: 00000000 c09005a0 00000000 c06d6cac 00000000 00000000 00000000 00000000
> [    1.045020] 5fa0: 00000000 c06d6cb4 00000000 c01079e0 00000000 00000000 00000000 00000000
> [    1.053177] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.061335] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
> [    1.069521] [<c09044a0>] (arch_hw_breakpoint_init) from [<c01019f0>] (do_one_initcall+0x40/0x16c)
> [    1.078385] [<c01019f0>] (do_one_initcall) from [<c0900dd0>] (kernel_init_freeable+0x144/0x1e0)
> [    1.087081] [<c0900dd0>] (kernel_init_freeable) from [<c06d6cb4>] (kernel_init+0x8/0x110)
> [    1.095252] [<c06d6cb4>] (kernel_init) from [<c01079e0>] (ret_from_fork+0x14/0x34)
> [    1.102807] Code: 0a000002 e3500005 13a04000 ea000001 (ee114e91) 
> [    1.108892] ---[ end trace 7c7f41a8afd53875 ]---
> [    1.113517] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> The same kernel zImage binary boots fine on Guitar, where I instead get:
> 
> [    0.865476] cpuidle: using governor ladder
> [    0.866283] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
> [    0.866385] hw-breakpoint: maximum watchpoint size is 4 bytes.
> 
> I have tested this both with and without owl_secondary_boot(), i.e. my SMP patch series.

If I return from arch/arm/kernel/hw_breakpoint.c like Scorpion does,
then we avoid the undefined instruction, but it just hangs:

[    0.899948] cpuidle: using governor ladder
[    0.904215] hw-breakpoint: CubieBoard6 detected. Hardware breakpoints
and watchpoints disabled
[  132.032547] random: crng init done

Any ideas?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
