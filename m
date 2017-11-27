From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Nov 2017 15:27:03 +0100
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <CGME20171125113437epcas2p4f1fcbe7dc2375f08410576ba826bc188@epcas2p4.samsung.com>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
Message-ID: <83b9ac11-a01a-c407-ed46-a62ac5037431@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

On 2017-11-25 12:33, Russell King wrote:
> Detect if we are returning to usermode via the normal kernel exit paths
> but the saved PSR value indicates that we are in kernel mode.  This
> could occur due to corrupted stack state, which has been observed with
> "ftracetest".
>
> This ensures that we catch the problem case before we get to user code.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch brakes kernel booting on Exynos 4412-based Odroid U3 board:

[??? 4.211412] ------------[ cut here ]------------
[??? 4.211553] kernel BUG at Returning to usermode but unexpected PSR 
bits set?:5!
[??? 4.217696] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[??? 4.223513] Modules linked in:
[??? 4.226557] CPU: 3 PID: 1 Comm: init Not tainted 
4.14.0-rc1-00013-g8bafae202c82 #3453
[??? 4.234362] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[??? 4.240440] task: ee870000 task.stack: ee86e000
[??? 4.244977] PC is at no_work_pending+0x38/0x3c
[??? 4.249380] LR is at 0xb6f73b00
[??? 4.252502] pc : [<c010880c>]??? lr : [<b6f73b00>] psr: 200001d3
[??? 4.258752] sp : ee86ffb0? ip : 00000530? fp : 00000000
[??? 4.263960] r10: 00000000? r9 : ee86e000? r8 : 00000000
[??? 4.269168] r7 : 10c5387d? r6 : ffffffff? r5 : 00000050? r4 : b6f73b00
[??? 4.275678] r3 : ee870000? r2 : ee86ffec? r1 : 00000050? r0 : c01087d8
[??? 4.282190] Flags: nzCv? IRQs off? FIQs off? Mode SVC_32? ISA ARM? 
Segment user
[??? 4.289478] Control: 10c5387d? Table: 6df9004a? DAC: 00000055
[??? 4.295208] Process init (pid: 1, stack limit = 0xee86e210)
[??? 4.300763] Stack: (0xee86ffb0 to 0xee870000)
[??? 4.305104] ffa0:???????????????????????????????????? 00000000 
00000000 00000000 00000000
[??? 4.313262] ffc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[??? 4.321422] ffe0: 00000000 bed6ef00 00000000 b6f73b00 00000050 
ffffffff 00000000 00000000
[??? 4.329585] Code: e9527fff e1a00000 e28dd048 e1b0f00e (e7f001f2)
[??? 4.335663] ---[ end trace 8579492d646004d9 ]---
[??? 4.340263] BUG: sleeping function called from invalid context at 
./include/linux/percpu-rwsem.h:33
[??? 4.349284] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
[??? 4.355622] INFO: lockdep is turned off.
[??? 4.359525] irq event stamp: 258120
[??? 4.363011] hardirqs last? enabled at (258119): [<c01ba41c>] 
filemap_map_pages+0x380/0x540
[??? 4.371252] hardirqs last disabled at (258120): [<c010d640>] 
__und_svc+0x60/0x74
[??? 4.378627] softirqs last? enabled at (257808): [<c0101784>] 
__do_softirq+0x224/0x318
[??? 4.386443] softirqs last disabled at (257783): [<c01221a8>] 
irq_exit+0xe4/0x128
[??? 4.393816] CPU: 3 PID: 1 Comm: init Tainted: G????? D 
4.14.0-rc1-00013-g8bafae202c82 #3453
[??? 4.402838] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[??? 4.408926] [<c0110054>] (unwind_backtrace) from [<c010c86c>] 
(show_stack+0x10/0x14)
[??? 4.416660] [<c010c86c>] (show_stack) from [<c08266e4>] 
(dump_stack+0x90/0xc8)
[??? 4.423858] [<c08266e4>] (dump_stack) from [<c0142b94>] 
(___might_sleep+0x22c/0x2c8)
[??? 4.431581] [<c0142b94>] (___might_sleep) from [<c012cb6c>] 
(exit_signals+0x20/0x2f0)
[??? 4.439387] [<c012cb6c>] (exit_signals) from [<c01208b8>] 
(do_exit+0xb4/0xa94)
[??? 4.446589] [<c01208b8>] (do_exit) from [<c010ca7c>] (die+0x20c/0x2e4)
[??? 4.453097] [<c010ca7c>] (die) from [<c01010c4>] 
(do_undefinstr+0xc0/0x270)
[??? 4.460042] [<c01010c4>] (do_undefinstr) from [<c010d65c>] 
(__und_svc_finish+0x0/0x44)
[??? 4.467939] Exception stack(0xee86ff60 to 0xee86ffa8)
[??? 4.472974] ff60: c01087d8 00000050 ee86ffec ee870000 b6f73b00 
00000050 ffffffff 10c5387d
[??? 4.481134] ff80: 00000000 ee86e000 00000000 00000000 00000530 
ee86ffb0 b6f73b00 c010880c
[??? 4.489291] ffa0: 200001d3 ffffffff
[??? 4.492769] [<c010d65c>] (__und_svc_finish) from [<c010880c>] 
(no_work_pending+0x38/0x3c)
[??? 4.525364] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[??? 4.525364]
[??? 4.528951] CPU1: stopping
[??? 4.531612] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G????? D W?????? 
4.14.0-rc1-00013-g8bafae202c82 #3453
[??? 4.541050] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[??? 4.547181] [<c0110054>] (unwind_backtrace) from [<c010c86c>] 
(show_stack+0x10/0x14)
[??? 4.554895] [<c010c86c>] (show_stack) from [<c08266e4>] 
(dump_stack+0x90/0xc8)
[??? 4.562086] [<c08266e4>] (dump_stack) from [<c010f0bc>] 
(handle_IPI+0x174/0x1ac)
[??? 4.569464] [<c010f0bc>] (handle_IPI) from [<c0101554>] 
(gic_handle_irq+0x94/0xa0)
[??? 4.577009] [<c0101554>] (gic_handle_irq) from [<c010d570>] 
(__irq_svc+0x70/0xb0)
[??? 4.584454] Exception stack(0xee8c1f78 to 0xee8c1fc0)
[??? 4.589494] 
1f60:?????????????????????????????????????????????????????? c01092e8 
00000000
[??? 4.597664] 1f80: ee8c1fc8 00000000 c0d07c7c c0d07c20 c0c687b0 
c0d07c88 c0d5e121 00000000
[??? 4.605821] 1fa0: 00000000 00000000 00000001 ee8c1fc8 c01092e8 
c01092ec 60000053 ffffffff
[??? 4.614000] [<c010d570>] (__irq_svc) from [<c01092ec>] 
(arch_cpu_idle+0x20/0x3c)
[??? 4.621376] [<c01092ec>] (arch_cpu_idle) from [<c015dbe4>] 
(do_idle+0x144/0x214)
[??? 4.628744] [<c015dbe4>] (do_idle) from [<c015dff0>] 
(cpu_startup_entry+0x18/0x1c)
[??? 4.636294] [<c015dff0>] (cpu_startup_entry) from [<4010190c>] 
(0x4010190c)
[??? 4.643220] CPU0: stopping
[??? 4.645924] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G????? D W?????? 
4.14.0-rc1-00013-g8bafae202c82 #3453
[??? 4.655365] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[??? 4.661486] [<c0110054>] (unwind_backtrace) from [<c010c86c>] 
(show_stack+0x10/0x14)
[??? 4.669207] [<c010c86c>] (show_stack) from [<c08266e4>] 
(dump_stack+0x90/0xc8)
[??? 4.676405] [<c08266e4>] (dump_stack) from [<c010f0bc>] 
(handle_IPI+0x174/0x1ac)
[??? 4.683776] [<c010f0bc>] (handle_IPI) from [<c0101554>] 
(gic_handle_irq+0x94/0xa0)
[??? 4.691322] [<c0101554>] (gic_handle_irq) from [<c010d570>] 
(__irq_svc+0x70/0xb0)
[??? 4.698768] Exception stack(0xc0d01f40 to 0xc0d01f88)
[??? 4.703823] 1f40: c01092e8 00000000 c0d01f90 00000000 c0d07c7c 
c0d07c20 c0c687b0 c0d07c88
[??? 4.711980] 1f60: c0d5e121 00000000 00000000 00000000 00000001 
c0d01f90 c01092e8 c01092ec
[??? 4.720122] 1f80: 60000153 ffffffff
[??? 4.723625] [<c010d570>] (__irq_svc) from [<c01092ec>] 
(arch_cpu_idle+0x20/0x3c)
[??? 4.730998] [<c01092ec>] (arch_cpu_idle) from [<c015dbe4>] 
(do_idle+0x144/0x214)
[??? 4.738367] [<c015dbe4>] (do_idle) from [<c015dff0>] 
(cpu_startup_entry+0x18/0x1c)
[??? 4.745949] [<c015dff0>] (cpu_startup_entry) from [<c0c00c40>] 
(start_kernel+0x354/0x3bc)
[??? 4.754065] CPU2: stopping
[??? 4.756768] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G????? D W?????? 
4.14.0-rc1-00013-g8bafae202c82 #3453
[??? 4.766208] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[??? 4.772330] [<c0110054>] (unwind_backtrace) from [<c010c86c>] 
(show_stack+0x10/0x14)
[??? 4.780049] [<c010c86c>] (show_stack) from [<c08266e4>] 
(dump_stack+0x90/0xc8)
[??? 4.787247] [<c08266e4>] (dump_stack) from [<c010f0bc>] 
(handle_IPI+0x174/0x1ac)
[??? 4.794619] [<c010f0bc>] (handle_IPI) from [<c0101554>] 
(gic_handle_irq+0x94/0xa0)
[??? 4.802165] [<c0101554>] (gic_handle_irq) from [<c010d570>] 
(__irq_svc+0x70/0xb0)
[??? 4.809612] Exception stack(0xee8c3f78 to 0xee8c3fc0)
[??? 4.814651] 
3f60:?????????????????????????????????????????????????????? c01092e8 
00000000
[??? 4.822823] 3f80: ee8c3fc8 00000000 c0d07c7c c0d07c20 c0c687b0 
c0d07c88 c0d5e121 00000000
[??? 4.830980] 3fa0: 00000000 00000000 00000001 ee8c3fc8 c01092e8 
c01092ec 60000153 ffffffff
[??? 4.839156] [<c010d570>] (__irq_svc) from [<c01092ec>] 
(arch_cpu_idle+0x20/0x3c)
[??? 4.846527] [<c01092ec>] (arch_cpu_idle) from [<c015dbe4>] 
(do_idle+0x144/0x214)
[??? 4.853900] [<c015dbe4>] (do_idle) from [<c015dff0>] 
(cpu_startup_entry+0x18/0x1c)
[??? 4.861448] [<c015dff0>] (cpu_startup_entry) from [<4010190c>] 
(0x4010190c)
[??? 4.868436] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b
[??? 4.868436]

What can I do to help fixing it?

> ---
>   arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
>   arch/arm/kernel/entry-header.S   |  6 ++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index ad301f107dd2..bc8d4bbd82e2 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -518,4 +518,22 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>   #endif
>   	.endm
>   
> +	.macro	bug, msg, line
> +#ifdef CONFIG_THUMB2_KERNEL
> +1:	.inst	0xde02
> +#else
> +1:	.inst	0xe7f001f2
> +#endif
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +	.pushsection .rodata.str, "aMS", %progbits, 1
> +2:	.asciz	"\msg"
> +	.popsection
> +	.pushsection __bug_table, "aw"
> +	.align	2
> +	.word	1b, 2b
> +	.hword	\line
> +	.popsection
> +#endif
> +	.endm
> +
>   #endif /* __ASM_ASSEMBLER_H__ */
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index d523cd8439a3..7f4d80c2db6b 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -300,6 +300,8 @@
>   	mov	r2, sp
>   	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
>   	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
> +	tst	r1, #0xcf
> +	bne	1f
>   	msr	spsr_cxsf, r1			@ save in spsr_svc
>   #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
>   	@ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -314,6 +316,7 @@
>   						@ after ldm {}^
>   	add	sp, sp, #\offset + PT_REGS_SIZE
>   	movs	pc, lr				@ return & move spsr_svc into cpsr
> +1:	bug	"Returning to usermode but unexpected PSR bits set?", \@
>   #elif defined(CONFIG_CPU_V7M)
>   	@ V7M restore.
>   	@ Note that we don't need to do clrex here as clearing the local
> @@ -329,6 +332,8 @@
>   	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
>   	ldr	lr, [sp, #\offset + S_PC]	@ get pc
>   	add	sp, sp, #\offset + S_SP
> +	tst	r1, #0xcf
> +	bne	1f
>   	msr	spsr_cxsf, r1			@ save in spsr_svc
>   
>   	@ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -341,6 +346,7 @@
>   	.endif
>   	add	sp, sp, #PT_REGS_SIZE - S_SP
>   	movs	pc, lr				@ return & move spsr_svc into cpsr
> +1:	bug	"Returning to usermode but unexpected PSR bits set?", \@
>   #endif	/* !CONFIG_THUMB2_KERNEL */
>   	.endm
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
