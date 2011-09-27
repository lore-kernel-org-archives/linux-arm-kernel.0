From: arm.maxinbjohn@gmail.com (Maxin John)
Date: Tue, 27 Sep 2011 11:58:06 +0300
Subject: Porting linux to Stellaris Cortex-M3
In-Reply-To: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
References: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
Message-ID: <CAAJ0-p7YwKR9B6BfoHcRqrNPVvpd49XrPsDCN7UF=-5jAf8XnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fernando,

On Mon, Sep 26, 2011 at 11:19 PM, Fernando Endo
<fernando.endo@phiinnovations.com> wrote:
> Hello everybody,
>
> I'm currently porting linux to a Stellaris board from TI.
> But I'm having some problems with the execution of the Busybox init program.
>
> Some info:
> - the toolchain is CodeSourcery lite edition
> - I've followed the steps described by Catalin Marinas at
> http://www.linux-arm.org/LinuxKernel/LinuxM3
> - I'm using my own bootloader, based on the script at the site above
> and on informations found on linux/Documents
> - I've based the mach-stellaris implementation from realview and mps ones
> - the timer, irqs and uart seems to work fine
> - the system crashes after calling /init, which is linked with Busybox init
> - BUG: scheduling while atomic: init/1/0xffff000a

This is the code which corresponds to "scheduling while atomic" bug
(from "kernel/sched.c") :
-----
/*
 * Print scheduling while atomic bug:
 */
static noinline void __schedule_bug(struct task_struct *prev)
{
        struct pt_regs *regs = get_irq_regs();

        printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
                prev->comm, prev->pid, preempt_count());

        debug_show_held_locks(prev);
        print_modules();
        if (irqs_disabled())
                print_irqtrace_events(prev);

        if (regs)
                show_regs(regs);
        else
                dump_stack();
}
----

We hit this bug if we are scheduling when we should not be. ie : if we
call schedule() or sleep() from a driver while in an interrupt handler
or holding a spin-lock, that will trigger this bug. This is because of
a bug present in any of the kernel drivers.  Please share the detailed
logs.

Warm Regards,
Maxin B. John
