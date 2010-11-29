From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 14:22:00 +0000
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <201011271639.21694.arnd@arndb.de>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
	<AANLkTinbAVFE+HZrx+9KUwx8=MKFHPqrhpOpAWAEQFv-@mail.gmail.com>
	<201011271639.21694.arnd@arndb.de>
Message-ID: <20101129142200.GA14941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 27, 2010 at 04:39:21PM +0100, Arnd Bergmann wrote:
> On Saturday 27 November 2010 14:01:20 Micha? Miros?aw wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index db524e7..74ea522 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1164,7 +1164,7 @@ config ISA_DMA_API
> >         bool
> > 
> >  config PCI
> > -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> > +       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> > ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX ||
> > ARCH_GEMINI
> >         help
> >           Find out whether you have a PCI motherboard. PCI is the name of a
> >           bus system, i.e. the way the CPU talks to the other stuff inside
> > 
> 
> This approach really does not scale as we add more boards to the list.
> 
> Better make a new CONFIG_HAVE_PCI option that you can select from the
> individual boards, and make that the only dependency that CONFIG_PCI has.

Be careful.  There are two things going on here:

1. those which PCI support is configurable
2. those which always have PCI support

Making PCI "depend on HAVE_PCI" is wrong, and will throw up lots of
Kconfig warnings, as those platforms which always have PCI support
won't select HAVE_PCI - and making them do so such that "PCI support"
gets offered to them - with the only possible value being 'Y' is
silly.

So, rather than HAVE_PCI, it should be MIGHT_HAVE_PCI, and that
symbol needs to control whether the "PCI support" prompt is offered
to the user, not whether PCI is available or not.
