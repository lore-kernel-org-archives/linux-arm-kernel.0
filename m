From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 16:05:27 +0000
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <201011291657.53316.arnd@arndb.de>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<20101129142200.GA14941@n2100.arm.linux.org.uk>
	<alpine.LNX.2.00.1011291546550.12293@localhost.localdomain>
	<201011291657.53316.arnd@arndb.de>
Message-ID: <20101130160527.GB2377@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 04:57:53PM +0100, Arnd Bergmann wrote:
> On Monday 29 November 2010, Hans Ulli Kroll wrote:
> > @@ -1164,7 +1169,7 @@ config ISA_DMA_API
> >         bool
> >  
> >  config PCI
> > -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || 
> > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> > +       bool "PCI support" if MIGHT_HAVE_PCI
> >         help
> >           Find out whether you have a PCI motherboard. PCI is the name of 
> > a
> >           bus system, i.e. the way the CPU talks to the other stuff inside
> 
> This does not solve the problem that Russell mentioned: existing platforms
> select PCI unconditionally, e.g. Iop13XX, some IXP, Orion, Shark
> and more. At the very least, these would need to also select MIGHT_HAVE_PCI
> to avoid the warning.

No, the above is correct.  What I was talking about was the difference
between these:

config PCI
	bool "PCI support" if MIGHT_HAVE_PCI

and

config PCI
	bool "PCI support"
	depends on MIGHT_HAVE_PCI

In the first instance, PCI itself does not depend on MIGHT_HAVE_PCI.
MIGHT_HAVE_PCI controls whether the user is offered the "PCI support"
option.

In the second instance, PCI depends on MIGHT_HAVE_PCI, which must be
set to 'y' to offer the option _and_ also if PCI is selected.

We want the first behaviour.  Platforms which must have PCI support can
continue to select PCI as they currently do, and leave the MIGHT_HAVE_PCI
option alone.

Platforms which may optionally have PCI support should select
MIGHT_HAVE_PCI instead.
