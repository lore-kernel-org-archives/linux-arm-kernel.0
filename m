From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Aug 2011 17:07:12 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110818161105.GA12527@S2100-06.ap.freescale.net>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
Message-ID: <20110818160712.GA26691@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Aug 18, 2011 at 05:11:06PM +0100, Shawn Guo wrote:
> On Tue, Aug 16, 2011 at 10:41:11PM +0100, Will Deacon wrote:
> > Enabling CONFIG_DEBUG_LL (which is required for earlyprintk) hardwires
> > the debug UART address into the kernel, so that we can print before the
> > platform is initialised.
> > 
> > If the user inadvertently selects multiple platforms with DEBUG_LL
> > enabled, the UART address may not be correct and will likely cause the
> > kernel to hang in the very early stages of boot.
> > 
> > This patch, based on a skeleton from Russell, uses a Kconfig choice for
> > selecting the DEBUG_LL UART, therefore allowing the user to make a
> > choice about the supported platform when DEBUG_LL is enabled.
> > 
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/Kconfig.debug |   41 ++++++++++++++++++++++++-----------------
> >  1 files changed, 24 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 81cbe40..11604c9 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -72,6 +72,30 @@ config DEBUG_LL
> >  	  in the kernel.  This is helpful if you are debugging code that
> >  	  executes before the console is initialized.
> >  
> > +choice
> > +	prompt "Kernel low-level debugging port"
> > +	depends on DEBUG_LL
> > +
> > +	config DEBUG_DC21285_PORT
> > +		bool "Kernel low-level debugging messages via footbridge serial port"
> > +		depends on FOOTBRIDGE
> > +		help
> > +		  Say Y here if you want the debug print routines to direct
> > +		  their output to the serial port in the DC21285 (Footbridge).
> > +		  Saying N will cause the debug messages to appear on the first
> > +		  16550 serial port.
> > +
> > +	config DEBUG_CLPS711X_UART2
> 
> I would expect this will become a long list when other platforms start
> adding CONFIG symbol here.  It may be a good idea to sort this list
> in symbol from the beginning.

I'm not sure that sorting this list in alphabetical order is a good idea.
This is a Kconfig choice, so the default value is the first one in the list
that has its dependencies satisfied. Therefore, the ordering has a direct
impact on the default UART selection.

Will
