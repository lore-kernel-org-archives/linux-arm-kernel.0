From: scottwood@freescale.com (Scott Wood)
Date: Fri, 2 Oct 2015 18:49:24 -0500
Subject: [PATCH] serial: Enable Freescale 16550 workaround on arm
In-Reply-To: <5286230.7Dic6OMiYf@wuerfel>
References: <20151002001616.GA3885@home.buserror.net>
 <5286230.7Dic6OMiYf@wuerfel>
Message-ID: <1443829764.5336.213.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-10-03 at 00:22 +0200, Arnd Bergmann wrote:
> On Thursday 01 October 2015 19:16:16 Scott Wood wrote:
> > 
> > +#ifdef CONFIG_SERIAL_8250_FSL
> > +       if (of_device_is_compatible(np, "fsl,ns16550") ||
> > +           of_device_is_compatible(np, "fsl,16550-FIFO64"))
> > +               port->handle_irq = fsl8250_handle_irq;
> > +#endif
> > +
> > 
> 
> Can you change this to use
> 
>       if (IS_ENABLED(CONFIG_SERIAL_8250_FSL)) && ...
> 
> The resulting code will be the same, it just get a little easier
> on the eye.

Sure.

> Other than that, I wonder if we should do this completely differently
> and have the respective entries in of_platform_serial_table[] with
> an appropriate PORT_* constant to handle the freescale case.

I'd considered that, but it seemed like it would be more complicated, with no 
real benefit.  We'd need to add a new PORT for the non-fifo64 case, and it 
would need to otherwise behave like PORT_16550A.  There's no room for an 
extra 8250-style PORT number unless we break PORT_MAX_8250 or renumber the 
"ARM specific type numbers", and for some reason these PORT numbers are 
defined in uapi (even if there's some legacy reason for that, do we really 
need to keep adding to it?).  We'd also need to make sure that autoconfig() 
doesn't overwrite the new PORT number (or ignore the fact that it gets 
overwritten after using it to substitute handle_irq).  It would also increase 
the discrepancy between how the same issue is handled on ARM versus PPC (with 
the latter using arch/powerpc/kernel/legacy_serial.c which doesn't supply 
PORT numbers).

The above check wouldn't go away, as it's not something currently addressed 
by struct serial8250_config (unless you're also asking for a new flag for 
that struct, in which case it would merely be moved elsewhere); it would just 
require a bunch of changes elsewhere to support changing it from a simple 
compatible check to a PORT check.

-Scott
