From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2012 10:43:34 +0100
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <4FE125C6.3030401@codeaurora.org>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
 <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
 <201206181410.39267.arnd@arndb.de>
 <4FE125C6.3030401@codeaurora.org>
Message-ID: <20120620094334.GA32666@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jun 20, 2012 at 02:22:14AM +0100, Stephen Boyd wrote:
> On 06/18/12 07:10, Arnd Bergmann wrote:
> > Instead of checking for trustzone_enabled() in each place where
> > we call into smc, we can have a generic implementation that
> > we call for the disabled case, and provide a vendor specific
> > version of that struct with functions that call into smp 
> > where necessary.
> >
> 
> What if we tried to read the SCR.NS bit to determine if we're running in
> secure state or not? It looks like reading SCR is UNDEFINED (i.e. causes
> an undefined instruction exception) if we're running in the non-secure
> state so I propose we set up an undef hook that traps the SCR access and
> lies about the value of the NS bit to indicate we're non-secure.
> Basically this:

Well, I can't resist reviewing the code, but I don't think we should be
trying to detect this (see below).

> static int scr_trap(struct pt_regs *regs, unsigned int instr)
> {
>         int reg = (instr >> 12) & 15;
>         if (reg == 15)
>                 return 1;

Eek -- surely GCC won't allocate PC for the destination register?!

>         regs->uregs[reg] = BIT(0); /* Trapped = non-secure */
>         regs->ARM_pc += 4;
>         return 0;
> }
> 
> static struct undef_hook scr_hook = {
>         .instr_mask     = 0x0fff0fff,
>         .instr_val      = 0x0e110f11,
>         .fn             = scr_trap,
> };
> 
> int in_secure_state(void)
> {
>         unsigned int scr;
> 
> 	register_undef_hook(&scr_hook);
> 
>         asm volatile(
>         "       mrc p15, 0, %0, c1, c1, 0\n"
>         : "=r" (scr)
>         :
>         : "cc");

I don't think you need this clobber either.

> It seems to mostly work, although I haven't figured out what you do
> about the hypervisor case when the hypervisor has disabled the smc
> instruction entirely (SCR.SCD=1). At that point I throw up my hands.
> Maybe Will has some idea.

I think this is part of a bigger problem, which is about how we know where
we live in the privilege hierarchy and what we have sitting above us. We
have exactly the same issue with hypervisors and the hvc instruction.

Rather than try to probe the instruction (which by itself isn't enough,
since we can't guarantee that the exception will be handled by the upper
layers) I would personally prefer to see this described in the device tree.
We could have a simple property in the CPU node that says what the interface
looks like:

	smc-interface = "samsung, exynos";

or whatever you need to identify the interface uniquely. You could have a
corresponding entry for hvc-interface (and something like KVM could pass
its version to the guest for paravirualisation). If the property is missing,
then we take that to mean that the instruction shouldn't be executed on that
core -- it may be undefined or there may not be anything to pick up the
exception.

I realise I'm glossing over a lot of detail, but I prefer something along
these lines to the fragile probing code.

Cheers,

Will
