From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 May 2015 15:57:15 +0100
Subject: Fwd: Re: Re: [EDT] [PATCH 1/1] Fix: hw watchpoint continually
 triggers callback
In-Reply-To: <1609501084.68951431436373294.JavaMail.weblogic@ep2mlwas08a>
References: <1609501084.68951431436373294.JavaMail.weblogic@ep2mlwas08a>
Message-ID: <20150512145714.GC2062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:12:54PM +0100, Vaneet Narang wrote:
> On Tue, May 12, 2015 at 12:48:13PM +0100, Maninder Singh wrote:
> >> On ARM, when a watchpoint is registered using register_wide_hw_breakpoint, 
> >> the callback handler endlessly runs until the watchpoint is unregistered.
> >> The reason for this issue is debug interrupts gets raised before
> >> executing the instruction, and after interrupt handling ARM tries to
> >> execute the same instruction again , which results in interrupt getting
> >> raised again.
> >> 
> >> This patch fixes this issue by using KPROBES (getting the instruction
> >> executed and incrementing PC to next instruction).
> >> 
> >> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> >> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> >> Reviewed-by: Amit Arora <amit.arora@samsung.com>
> >> Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
> >> ---
> >>  arch/arm/kernel/hw_breakpoint.c |   18 ++++++++++++++++++
> >>  1 files changed, 18 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> >> index dc7d0a9..ec72f86 100644
> >> --- a/arch/arm/kernel/hw_breakpoint.c
> >> +++ b/arch/arm/kernel/hw_breakpoint.c
> >> @@ -37,6 +37,9 @@
> >>  #include <asm/hw_breakpoint.h>
> >>  #include <asm/kdebug.h>
> >>  #include <asm/traps.h>
> >> +#ifdef CONFIG_KPROBES
> >> +#include <linux/kprobes.h>
> >> +#endif
> >>  
> >>  /* Breakpoint currently in use for each BRP. */
> >>  static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
> >> @@ -757,6 +760,21 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
> >>  		 */
> >>  		if (!wp->overflow_handler)
> >>  			enable_single_step(wp, instruction_pointer(regs));
> >> +#ifdef CONFIG_KPROBES
> >> +		else {
> >> +			struct kprobe kp;
> >> +			unsigned long flags;
> >> +
> >> +			arch_uninstall_hw_breakpoint(wp);
> >> +			kp.addr = (kprobe_opcode_t *)instruction_pointer(regs);
> >> +			if (!arch_prepare_kprobe(&kp)) {
> >> +				local_irq_save(flags);
> >> +				kp.ainsn.insn_singlestep(&kp, regs);
> >> +				local_irq_restore(flags);
> >> +			}
> >> +			arch_install_hw_breakpoint(wp);
> >> +		}
> >> +#endif
> 
> >I don't think this is the right thing to do at all; the kernel already
> >handles step exceptions using mismatched breakpoints when there is no
> >overflow handler specified (e.g. using perf mem events). If you register a
> >handler (e.g. gdb via ptrace) then you have to handle the step yourself.
> 
> This fix is given for kernel developers who wants to use perf interface by
> registering callback using register_wide_hw_breakpoint API.  On every
> callback trigger they have to unregister watchpoints otherwise callback
> gets called in a loop and now issue is "when to register watch point back
> ?". 

If you want to solve this, I think we need a better way to expose software
single-step/emulation to the overflow handler. If we try to do this in
the hw_breakpoint code itself, we run into problems:

  - What if another thread hits the same instruction whilst we are trying
    to step it?

  - What if there are two breakpoints or a breakpoint + watchpoint
    triggered by the same instruction?

  - What if the debugger didn't want to execute the instruction at all?

> With this issue in place, it makes perf interface unusable. We didn't
> faced this issue with x86. 

This is a good point. If perf/hw_breakpoint are supposed to hide the
internal details of the debug architecture and make everything look and
smell like x86, I'd like to see that documented somewhere. I don't think
we'd generally be able to achieve that whilst solving the caveats I mention
above, so we'd probably just end up removing this feature altogether, which
would be a shame (and I don't think possible as it stands, since
hw_breakpoint doesn't know about its caller).

Will
