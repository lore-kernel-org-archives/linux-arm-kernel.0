From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Mar 2017 11:44:25 +0000
Subject: undefined instruction: msr s3_0_c12_c11_5, x27
In-Reply-To: <AF7C0ADF1FEABA4DABABB97411952A2EDD08542B@CN-MBX05.HTC.COM.TW>
References: <AF7C0ADF1FEABA4DABABB97411952A2EDD08542B@CN-MBX05.HTC.COM.TW>
Message-ID: <20170308114424.GD20400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Marc, since this is happening as a result of a GICv3 system register
 access]

Given that you've just come out from idle in your backtrace, I suspect
that your firmware isn't restoring the GIC state properly (e.g. SRE :/).
The pstate looks fine.

I've kept the original mail below, for Marc to read.

Will

On Wed, Mar 08, 2017 at 10:38:58AM +0000, zhiyuan_zhu at htc.com wrote:
> Dear Catalin,
> 
>  
> 
> I am a HTC engineer, responsible for ARM Linux Kernel.
> 
> We have encounter a  kernel panic at Undefined PC  instruction.
> 
> But the PC instruction 0xffffff8008393044 is msr s3_0_c12_c11_5, x27,
> 
> And  it should be a normal arm instruction.
> 
> Would you please help to provide us some debug suggestion?
> 
> And would you please help to give a deep analysis for the instruction: msr
> s3_0_c12_c11_5, x27,  how it?s works?
> 
> Would you please help to check whether the pstate: 600001c5 normal?
> ?
> 
>  
> 
> Our platform, ARM64 with linux kernel 4.4
> 
>  
> 
> ?
> 
> [ 604.459700] swapper/3[0]: undefined instruction: pc=ffffff8008393044
> [ 604.459747] Code: aa1503e0 91048421 aa1b03e3 97ffdab6 (d518cbbb) 
> [ 604.460014] ------------[ cut here ]------------
> [ 604.460071] Kernel BUG at ffffff8008393044 [verbose debug info unavailable]
> [ 604.460111] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [ 604.460162] Modules linked in: alitks_mod(P) aliaudit_mod aliperm_mod(P)
> alisec_mod(P) alipatch_mod(P)
> [ 604.460319] CPU: 3 PID: 0 Comm: swapper/3 Tainted: P W 4.4.21 #1
> [ 604.460358] Hardware name: HTC Corporation. MSM8998 v2.1 OCN XD (DT)
> [ 604.460404] task: ffffffc0f2ceb080 ti: ffffffc0f2d7c000 task.ti:
> ffffffc0f2d7c000
> [ 604.460485] PC is at gic_raise_softirq+0x158/0x188
> [ 604.460529] LR is at gic_raise_softirq+0xe4/0x188
> [ 604.460570] pc : [<ffffff8008393044>] lr : [<ffffff8008392fd0>] pstate:
> 600001c5
> [ 604.462886] [<ffffff8008393044>] gic_raise_softirq+0x158/0x188
> [ 604.462949] [<ffffff800808e808>] arch_irq_work_raise+0x120/0x168
> [ 604.463005] [<ffffff800817dc38>] irq_work_queue+0x64/0xb0
> [ 604.463062] [<ffffff8008107ddc>] wake_up_klogd+0x98/0xc4
> [ 604.463109] [<ffffff8008108264>] console_unlock+0x45c/0x488
> [ 604.463156] [<ffffff8008108758>] vprintk_emit+0x4c8/0x528
> [ 604.463202] [<ffffff8008108958>] vprintk_default+0x48/0x50
> [ 604.463253] [<ffffff800818be88>] printk+0xa8/0xb4
> [ 604.463322] [<ffffff800856b91c>] msm_mpm_exit_sleep+0x1d4/0x258
> [ 604.463383] [<ffffff8008a15860>] cluster_unprepare+0x13c/0x2ec
> [ 604.463429] [<ffffff8008a159ac>] cluster_unprepare+0x288/0x2ec
> [ 604.463476] [<ffffff8008a16ce8>] lpm_cpuidle_enter+0x208/0x520
> [ 604.463534] [<ffffff8008a10c7c>] cpuidle_enter_state+0x190/0x320
> [ 604.463583] [<ffffff8008a10e80>] cpuidle_enter+0x34/0x40
> [ 604.463644] [<ffffff80080eb530>] cpu_startup_entry+0x2e8/0x3a0
> [ 604.463694] [<ffffff800808e224>] secondary_start_kernel+0x1c0/0x1cc
> 
> (gdb) info symbol 0xffffff8008393044
> gic_raise_softirq + 344 in section .text
> 
> (gdb) disassemble gic_raise_softirq
> Dump of assembler code for function gic_raise_softirq:
> ...
> 0xffffff8008393030 <+324>: ldr w2, [x2,#28]
> 0xffffff8008393034 <+328>: mov x0, x21
> 0xffffff8008393038 <+332>: add x1, x1, #0x121
> 0xffffff800839303c <+336>: mov x3, x27
> 0xffffff8008393040 <+340>: bl 0xffffff8008389b18 <__dynamic_pr_debug>
> 0xffffff8008393044 <+344>: msr s3_0_c12_c11_5, x27 ==> undefined instruction:
> pc=ffffff8008393044
> 0xffffff8008393048 <+348>: isb
> 0xffffff800839304c <+352>: dsb sy
> 0xffffff8008393050 <+356>: b 0xffffff8008392f50 <gic_raise_softirq+100>
> 0xffffff8008393054 <+360>: isb
> 0xffffff8008393058 <+364>: ldp x19, x20, [sp,#16]
> 0xffffff800839305c <+368>: ldp x21, x22, [sp,#32]
> 0xffffff8008393060 <+372>: ldp x23, x24, [sp,#48]
> 0xffffff8008393064 <+376>: ldp x25, x26, [sp,#64]
> 0xffffff8008393068 <+380>: ldp x27, x28, [sp,#80]
> 0xffffff800839306c <+384>: ldp x29, x30, [sp],#112
> 0xffffff8008393070 <+388>: ret
> End of assembler dump.
> 
> Source code:
> 
> arch/arm64/include/asm/arch_gicv3.h
> 
> #define ICC_SGI1R_EL1           sys_reg(3, 0, 12, 11, 5)
> 
> 
> drivers/irqchip/irq-gic-v3.c
> static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq) 
> { 
> u64 val; 
> 
> val = (MPIDR_TO_SGI_AFFINITY(cluster_id, 3) | 
> MPIDR_TO_SGI_AFFINITY(cluster_id, 2) | 
> irq << ICC_SGI1R_SGI_ID_SHIFT | 
> MPIDR_TO_SGI_AFFINITY(cluster_id, 1) | 
> tlist << ICC_SGI1R_TARGET_LIST_SHIFT); 
> 
> pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
> gic_write_sgi1r(val); 
> } 
> 
>  
> 
