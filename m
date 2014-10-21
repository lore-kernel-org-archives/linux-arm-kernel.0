From: vichy.kuo@gmail.com (vichy)
Date: Tue, 21 Oct 2014 19:37:02 +0800
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
 <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
Message-ID: <CAOVJa8Fa25W=oNHridmq+zZCRWRgKZtH+Ykt=w_YSwcaqpaNhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Catalin:
> As a quick answer, it's ret_to_user (or ret_slow_syscall to be more
> precise) in arch/arm/kernel/entry-common.S.
>
> How it gets there is a bit more complicated. The initial kernel call
> path:
>
> start_kernel()
>   rest_init()
>     kernel_thread(kernel_init)
>
> kernel_thread() creates a new thread which executes the kernel_init()
> function. After the multitude of calls that kernel_thread() -> do_fork()
> does, it eventually calls copy_thread() which sets the
> thread->cpu_context.pc to ret_from_fork and the actual address of
> kernel_init in thread->cpu_context.r5. When the kernel eventually
> switches to the new kernel thread, it will jump to
> thread->cpu_context.pc which is ret_from_fork (see __switch_to in
> arch/arm/kernel/entry-armv.S). ret_from_fork() branches to kernel_init()
> but sets the return address (LR) to label 1 in ret_from_fork.
>
> After kernel_init() does its work, it eventually calls
> run_init_process() which invokes do_execve() and eventually
> load_elf_binary(). If the ELF binary was successfully loaded, this
> function calls start_thread() with the ELF entry point. The
> start_thread() function populates the pt_regs structure on the stack so
> that regs->ARM_pc points to the ELF entry point and regs->ARM_cpsr has
> the user mode bits set.
Many thanks for your kind and detail explanation.

>
> Going back to kernel_init(), if run_init_process() was successful, it
> returns to label 1 in ret_from_fork which branches to ret_slow_syscall
> which eventually returns to user space via the restore_user_regs macro
> (in arch/arm/kernel/entry-header.S).

Below is excerpted from arch/arm/kernel/entry-header.S

        .macro  restore_user_regs, fast = 0, offset = 0
        ldr     r1, [sp, #\offset + S_PSR]      @ get calling cpsr
        ldr     lr, [sp, #\offset + S_PC]!      @ get pc
        msr     spsr_cxsf, r1                   @ save in spsr_svc
        ..........
        add     sp, sp, #S_FRAME_SIZE - S_PC
        movs    pc, lr                          @ return & move
spsr_svc into cpsr
        .endm

so before armv8 architecture and kernel switch to user mode (arm svn-> user),
we first put the cpsr, the mode we want to jump to, in current spsr.
Then update pc counter to where the ELF entry, right?

BTW, in armv8, aarch64, arch/arm64/entry.S, kernel_exit,
(if I look at the right place.)

.macro  kernel_exit, el, ret = 0
        ..............................
        msr     elr_el1, x21                    // set up the return data
        msr     spsr_el1, x22
        .if     \el == 0
        msr     sp_el0, x23
        .endif
        pop     x10, x11
        ............................
        ldr     lr, [sp], #S_FRAME_SIZE - S_LR  // load LR and restore SP
        eret                                    // return to kernel
.endm

Is there any special reason we use eret in v8 instead of modify pc in v7?
I have looked arm v8 architecture reference menu but get no explanation so far.

Sincerely appreciate your kind help,


>
> --
> Catalin
