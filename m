From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 Jun 2011 18:39:33 +0300
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <4E0B43BA.803@atmel.com>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628103549.GG2612@legolas.emea.dhcp.ti.com>
	<4E09C573.2030607@atmel.com>
	<20110628122650.GK2612@legolas.emea.dhcp.ti.com>
	<4E0B43BA.803@atmel.com>
Message-ID: <20110629153932.GB2760@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 29, 2011 at 05:24:42PM +0200, Nicolas Ferre wrote:
> > yet you will prevent the driver from being easily used by other
> > architectures. What will happen is that a certain amount of:
> > 
> > depends on (ARCH_AT91SAM9X5 || ARCH_FOO || ARCH_BAR || ARCH_BAZ)
> 
> Yes, exactly like:
> 
> config USB_GADGET_ATMEL_USBA
> [..]
>         depends on AVR32 || ARCH_AT91CAP9 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
> 
> or
> 
> config MMC_ATMELMCI_DMA
> [..]
>         depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE && EXPERIMENTAL
> 
> or 
> 
> config TOUCHSCREEN_ATMEL_TSADCC
> [..]
>         depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45

are you saying that's correct ? Well, I see those are platform_drivers,
so it's probably some IP integrated inside ATMEL chips. Now, what if the
same IP is used by some other SoC ? I mean, other than AT91* even.

> Those are places where I wanted to add my little ARCH_AT91SAM9X5...

After a couple years, someone else comes with another patch adding
ARCH_AT91SAMXXX and ARCH_AT91SAMYYY and ARCH_AT91_SAMZZZ...

But then again, at the end of the day Russell is the final judge :-) I
just wanted to say that it's far better to remove those dependencies and
allow those drivers to be built as modules rather than keep adding
dependencies to the end of times ;-)

> And as Jean-Christophe said, when those lines are getting too long, we
> change this to a nice: HAVE_xxx config option.
> 
> > will continue to proliferate.
> 
> So what?
> It will:
> - ease xconfig/menuconfig reading by user: who cares about my Atmel
> driver while running OMAPs?

what if in a couple of years comes one OMAP with the same IP that you're
using ? ;-)

it's rather unlikely, but for a simple example look at how many
Cortex-A9 MPCore Interrupt Controller drivers we have under arch/arm/
where it would be simpler to have _one_ driver being re-used by many
archs ;-)

> - ease user choice by selecting default values depending on chip
> availability

IMHO, it's far simpler to answer 'M' to a driver such as a touchscreen
controller without even thinking about it ;-)

> > Here are a few questions:
> > i) The drivers you're willing to send, are those for Atmel's IPs or are
> > 	the IPs sourced from some other company ?
> > ii) Even if they are Atmel-specific, do you see the possibility of Atmel
> > 	licensing them ?
> > iii) Does your driver current depend on asm/ or mach/ headers ?
> > iv) Is there a generic header which you could use instead of asm/ mach/ ?
> 
> I just want to hide drivers that are not relevant for others: I have
> the feeling that it is a good practice. This tiny patch will ease this
> during my publication flow. Do you seriously care?

Well, it's not that I care. I just don't see the point in hiding the
drivers. For starters we loose the very nice linux-next infrastructure
for giving us compile tests ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110629/e06d0926/attachment.sig>
