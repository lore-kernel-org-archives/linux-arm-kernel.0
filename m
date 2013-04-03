From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 3 Apr 2013 16:15:59 -0700
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <515C06A6.5030807@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
 <20130403100751.GD11040@mudshark.cambridge.arm.com>
 <515C06A6.5030807@arm.com>
Message-ID: <20130403231559.GG29227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 11:38:30AM +0100, Marc Zyngier wrote:
> On 03/04/13 11:07, Will Deacon wrote:
> > On Tue, Apr 02, 2013 at 02:25:14PM +0100, Marc Zyngier wrote:
> >> Our HYP init code suffers from two major design issues:
> >> - it cannot support CPU hotplug, as we tear down the idmap very early
> >> - it cannot perform a TLB invalidation when switching from init to
> >>   runtime mappings, as pages are manipulated from PL1 exclusively
> > 
> > [...]
> > 
> >> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> >> index 35a463f..b2c6967 100644
> >> --- a/arch/arm/kvm/init.S
> >> +++ b/arch/arm/kvm/init.S
> >> @@ -21,6 +21,7 @@
> >>  #include <asm/asm-offsets.h>
> >>  #include <asm/kvm_asm.h>
> >>  #include <asm/kvm_arm.h>
> >> +#include <asm/kvm_mmu.h>
> >>  
> >>  /********************************************************************
> >>   * Hypervisor initialization
> >> @@ -47,6 +48,9 @@ __kvm_hyp_init:
> >>  	W(b)	.
> >>  
> >>  __do_hyp_init:
> >> +	cmp	r2, #0			@ We have a SP?
> >> +	bne	phase2			@ Yes, second stage init
> >> +
> >>  	@ Set the HTTBR to point to the hypervisor PGD pointer passed
> >>  	mcrr	p15, 4, r0, r1, c2
> >>  
> >> @@ -96,14 +100,35 @@ __do_hyp_init:
> >>  	orr	r0, r0, r1
> >>  	isb
> >>  	mcr	p15, 4, r0, c1, c0, 0	@ HSCR
> >> -	isb
> >>  
> >> -	@ Set stack pointer and return to the kernel
> >> +	eret
> >> +
> >> +phase2:
> >> +	@ Set stack pointer
> >>  	mov	sp, r2
> >>  
> >>  	@ Set HVBAR to point to the HYP vectors
> >>  	mcr	p15, 4, r3, c12, c0, 0	@ HVBAR
> >>  
> >> +	@ Jump to the trampoline page
> >> +	ldr	r2, =#PAGE_MASK
> > 
> > Shifting right by PAGE_SHIFT can avoid the load.
> 
> Not really. We're masking out the top bits of "target" and adding them
> to the trampoline base address, so shifting doesn't help.
> 
> But, as you suggested offline, BFI can come to the rescue and make that
> code totally fun and unreadable. How about (untested):
> 
> 	ldr	r2, =#TRAMPOLINE_VA
> 	adr	r3, target
> 	bfi	r2, r3, #0, #PAGE_SHIFT
> 	mov	pc, r2
> 
> I really like it! :)
> 

What kind of drugs are you on?

Ok, I actually like it too.

> > 
> >> +	adr	r3, target
> >> +	bic	r3, r3, r2
> >> +	ldr	r2, =#TRAMPOLINE_VA
> >> +	add	r3, r3, r2
> >> +	mov	pc, r3
> >> +
> >> +	nop
> > 
> > <insert dead chicken and voodoo chant here>
> 
> ... "You know I'll never sleep no more" ...
> 

Seriously, what kind of drugs are you guys on?
