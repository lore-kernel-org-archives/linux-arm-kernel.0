From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jun 2011 17:14:11 +0100
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <alpine.DEB.2.00.1106081707040.11513@localhost6.localdomain6>
References: <1307379898-14256-5-git-send-email-will.deacon@arm.com>
	<alpine.DEB.2.00.1106071126290.2247@localhost6.localdomain6>
	<alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
	<20110607132220.GB12639@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106071435020.2247@localhost6.localdomain6>
	<20110607153654.GA19855@arm.com>
	<alpine.DEB.2.00.1106071714400.2236@localhost6.localdomain6>
	<alpine.DEB.2.00.1106081638420.11513@localhost6.localdomain6>
	<20110608160527.GA6851@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106081707040.11513@localhost6.localdomain6>
Message-ID: <20110608161411.GB6851@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 05:10:05PM +0100, Frank Hofmann wrote:
> >> Just found a problem with this.
> >>
> >> If you have a MULTI_CPU config, this doesn't compile. For two reasons:
> >>
> >> 1. you cannot use cpu_reset as argument to virt_to_phys because you can't
> >>     take the address
> >>     That bit can be fixed by changing the MULTI_CPU #define in
> >>     <asm/proc-fns.h> not to include the macro argument.
> >>     (There is no code in the arm tree using cpu_reset_whatever names which
> >>     would break from that change ... still, not that nice)
> >>
> >> 2. even when you do that, you loose the "typeof()" information and the
> >>     above still doesn't compile.
> >>
> >> Only a manual type override,
> >>
> >>  	void (*phys_reset)(unsigned long) = (void (*)(unsigned long))cpu_reset;
> >>
> >> is accepted then.
> >
> > Damn, yes, I assumed the MULTI_CPU case would just pointer at the structure field,
> > but it takes the argument as parameter for the invocation. Oh well, I'll hardcode
> > the type after all then!
> 
> It's not just that - the worse bit is that as long as the #define looks 
> like:
> 
> #define	cpu_reset(addr)		processor.reset(addr)
> 
> compile is being refused; one has to ditch the argument part of the macro 
> to be able to take the address.
> 
> I'm unsure how desirable that change is; it's got the unwanted consequence 
> that people who decide to use function names like "graphics_cpu_reset" or 
> "cpu_reset_specialregisters" would fall flat on their face.

Isn't this already a problem in the !MULTI_CPU case? cpu_reset will be expanded
to something like armv7_cpu_reset by the macro.

> As said, not that anyone does so right now; just not nice to introduce 
> such behaviour.

But if that behaviour is already there, I don't think it's a big deal.

Will
