From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 7 Jun 2017 14:34:50 +0900
Subject: [PATCH v3 2/4] arm64: kgdb: disable interrupts while a software
 step is enabled
In-Reply-To: <20170605162919.GN21944@arm.com>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-3-takahiro.akashi@linaro.org>
 <20170605162919.GN21944@arm.com>
Message-ID: <20170607053449.GE26483@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 05:29:19PM +0100, Will Deacon wrote:
> On Tue, May 23, 2017 at 01:30:56PM +0900, AKASHI Takahiro wrote:
> > After entering kgdb mode, 'stepi' may unexpectedly breaks the execution
> > somewhere in el1_irq.
> > 
> > This happens because a debug exception is always enabled in el1_irq
> > due to the following commit merged in v3.16:
> >   commit 2a2830703a23 ("arm64: debug: avoid accessing mdscr_el1 on fault
> > 			paths where possible")
> > A pending interrupt can be taken after kgdb has enabled a software step,
> > but before a debug exception is actually taken.
> > 
> > This patch enforces interrupts to be masked while single stepping.
> 
> The desired behaviour here boils down to whether or not KGDB expects to step
> into or over interrupts in response a stepi instruction. What do other
> architectures do?

I don't know x86 case, but if we step into interrupt code here,
doing stepi on a normal function will be almost useless as every
attempt of stepi will end up falling into irq code (mostly for timer
interrupt).

> What happens if the instruction being stepped faults?

Well, as a matter of fact, we get a gdb control somewhere in exception code
(actually just after 'enable_dbg' in el1_sync).
But this is a synchronous event, and 'c' command will put us back where we
were before stepi.
I hope this will be a more desirable behavior.

(The only drawback here is we can't see a correct/complete backtrace of stack
because the current gdb is not kernel-aware.)

Thanks,
-Takahiro AKASHI

> Will
> 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Jason Wessel <jason.wessel@windriver.com>
> > ---
> >  arch/arm64/kernel/kgdb.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index b9176b324e5a..fddbc6be3780 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -28,6 +28,7 @@
> >  
> >  #include <asm/debug-monitors.h>
> >  #include <asm/insn.h>
> > +#include <asm/ptrace.h>
> >  #include <asm/traps.h>
> >  
> >  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> > @@ -111,6 +112,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> >  	{ "fpcr", 4, -1 },
> >  };
> >  
> > +static DEFINE_PER_CPU(unsigned int, kgdb_pstate);
> > +
> >  char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
> >  {
> >  	if (regno >= DBG_MAX_REG_NUM || regno < 0)
> > @@ -200,6 +203,10 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
> >  		err = 0;
> >  		break;
> >  	case 's':
> > +		/* mask interrupts while single stepping */
> > +		__this_cpu_write(kgdb_pstate, linux_regs->pstate);
> > +		linux_regs->pstate |= PSR_I_BIT;
> > +
> >  		/*
> >  		 * Update step address value with address passed
> >  		 * with step packet.
> > @@ -242,11 +249,20 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
> >  
> >  static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
> >  {
> > +	unsigned int pstate;
> > +
> >  	if (!kgdb_single_step)
> >  		return DBG_HOOK_ERROR;
> >  
> >  	kernel_disable_single_step();
> >  
> > +	/* restore interrupt mask status */
> > +	pstate = __this_cpu_read(kgdb_pstate);
> > +	if (pstate & PSR_I_BIT)
> > +		regs->pstate |= PSR_I_BIT;
> > +	else
> > +		regs->pstate &= ~PSR_I_BIT;
> > +
> >  	kgdb_handle_exception(1, SIGTRAP, 0, regs);
> >  	return 0;
> >  }
> > -- 
> > 2.11.1
> > 
