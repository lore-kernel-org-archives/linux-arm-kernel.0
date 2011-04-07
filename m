From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 7 Apr 2011 12:35:33 +0100 (BST)
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for
 Thumb-2
In-Reply-To: <BANLkTi=q=A=RBh-mQgZ_4S6NkUJ0O7ERig@mail.gmail.com>
References: <mailman.19600.1302086322.1534.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1104061208310.15572@localhost6.localdomain6>
	<BANLkTi=q=A=RBh-mQgZ_4S6NkUJ0O7ERig@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1104071133340.1147@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Apr 2011, Dave Martin wrote:

[ ... ]
> Well, I'm not hoping for the assembly to be inlined, *just* the C
> wrapper.  Since the C wrapper is trivial, I prefer to avoid emitting a
> function body for this.

_That_ specific bit is what isn't going to happen; it's a separate 
compilation unit, it needs to be callable from places not known at compile 
nor link time, and the function isn't "static". The "inline" is 
meaningless here.

Making set_fiq_regs() a wrapper in C will emit the symbol and the code for 
it, just objdump -d vmlinux.o and see what you find - set_fiq_regs _will_ 
exist with your change (caveat: it's not even compiled, normally, see 
below):

0000560c <get_fiq_regs>:
     560c:       e2800020        add     r0, r0, #32     ; 0x20
     5610:       eafffffe        b       56f8 <__get_fiq_regs>

00005614 <set_fiq_regs>:
     5614:       e2800020        add     r0, r0, #32     ; 0x20
     5618:       eafffffe        b       56d0 <__set_fiq_regs>


There's no other way of forcing the thing to be actually inlined into the 
code of the callers but putting it into fiq.h instead:

#define	set_fiq_regs(arg)	__set_fiq_regs(&((arg)->ARM_r8))

But then if you actually want to go that route, you can make it inline 
assembly right at that place, like e.g. the 64bit division stuff.




A bit more on "not even compiled normally":

Many architectures don't seem to compile FIQ in by default; fiq.c 
references "FIQ_START" and doesn't compile if the define doesn't exist. 
It's only defined for a few:

arch/arm/mach-at91/include/mach/irqs.h		46 #define FIQ_START AT91_ID_FIQ
arch/arm/mach-rpc/include/mach/irqs.h		43 #define FIQ_START               64
arch/arm/mach-s3c2410/include/mach/irqs.h	200 #define FIQ_START               IRQ_EINT0
arch/arm/mach-stmp378x/include/mach/irqs.h	92 #define FIQ_START               IRQ_DEBUG_UART
arch/arm/mach-stmp37xx/include/mach/irqs.h	94 #define FIQ_START                       IRQ_TIMER0
arch/arm/plat-mxc/include/mach/irqs.h		72 #define FIQ_START       0
arch/arm/plat-omap/include/plat/irqs.h		450 #define FIQ_START               1024
arch/arm/plat-s3c24xx/irq.c			505                 offs = irq - FIQ_START;

Also inconsistent here is that some of those do a "select FIQ" from 
arch/arm/Kconfig while others (like OMAP) seem to expect a "CONFIG_FIQ=y" 
from defconfig.


In all likelihood, it's not being compiled ...



Which also explains that your fiqasm.S code, as posted, doesn't compile - 
it lacks #include <linux/linkage.h> for the ENTRY/ENDPROC, and 
<arm/assembler.h> doesn't exist what you seem to mean is <asm/assembler.h> 
...

Except that all you use from there is the #include <asm/ptrace.h> (for 
the cpsr bit definitions).


[ ... ]
> Does that answer your concerns?

I agree with you that this should be assembly, no arguing it's better to 
nip gcc's optimizer escapades in the bud ...

The urgency I don't get, though; this code still looks a bit "hot".



FrankH.
