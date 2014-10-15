From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Oct 2014 17:20:06 +0100
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
Message-ID: <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 04:37:14AM +0100, vichy wrote:
> hi all:
> When tracing arm kernel source code, I cannot find the place where and
> how kernel first time jump from svc mode to user mode to execute the
> first user mode program.
> 
> Would you mind to show me where/how it happen?

As a quick answer, it's ret_to_user (or ret_slow_syscall to be more
precise) in arch/arm/kernel/entry-common.S.

How it gets there is a bit more complicated. The initial kernel call
path:

start_kernel()
  rest_init()
    kernel_thread(kernel_init)

kernel_thread() creates a new thread which executes the kernel_init()
function. After the multitude of calls that kernel_thread() -> do_fork()
does, it eventually calls copy_thread() which sets the
thread->cpu_context.pc to ret_from_fork and the actual address of
kernel_init in thread->cpu_context.r5. When the kernel eventually
switches to the new kernel thread, it will jump to
thread->cpu_context.pc which is ret_from_fork (see __switch_to in
arch/arm/kernel/entry-armv.S). ret_from_fork() branches to kernel_init()
but sets the return address (LR) to label 1 in ret_from_fork.

After kernel_init() does its work, it eventually calls
run_init_process() which invokes do_execve() and eventually
load_elf_binary(). If the ELF binary was successfully loaded, this
function calls start_thread() with the ELF entry point. The
start_thread() function populates the pt_regs structure on the stack so
that regs->ARM_pc points to the ELF entry point and regs->ARM_cpsr has
the user mode bits set.

Going back to kernel_init(), if run_init_process() was successful, it
returns to label 1 in ret_from_fork which branches to ret_slow_syscall
which eventually returns to user space via the restore_user_regs macro
(in arch/arm/kernel/entry-header.S).

-- 
Catalin
