From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 31 Aug 2011 18:47:09 -0400 (EDT)
Subject: [PATCH 01/10] ARM: kprobes: Add config option for selecting the
	ARM kprobes tests
In-Reply-To: <1314688610.2371.12.camel@computer2>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
	<1314621249-958-2-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1108291431300.20358@xanadu.home>
	<1314688610.2371.12.camel@computer2>
Message-ID: <alpine.LFD.2.00.1108311836240.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2011, Tixy wrote:

> On Mon, 2011-08-29 at 14:44 -0400, Nicolas Pitre wrote:
> > On Mon, 29 Aug 2011, Tixy wrote:
> > 
> > > From: Jon Medhurst <tixy@yxit.co.uk>
> > > 
> > > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > > ---
> > >  arch/arm/Kconfig.debug |   10 ++++++++++
> > >  1 files changed, 10 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > > index 81cbe40..8f95417 100644
> > > --- a/arch/arm/Kconfig.debug
> > > +++ b/arch/arm/Kconfig.debug
> > > @@ -129,4 +129,14 @@ config DEBUG_S3C_UART
> > >  	  The uncompressor code port configuration is now handled
> > >  	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
> > >  
> > > +config ARM_KPROBES_TESTS
> > > +	bool
> > > +
> > > +config ARM_KPROBES_TEST_MODULE
> > > +	tristate "Kprobes test module"
> > > +	depends on KPROBES && MODULES
> > > +	select ARM_KPROBES_TESTS
> > > +	help
> > > +	  "Perform tests of kprobes API and instruction set simulation"
> > > +
> > 
> > Why do you need two config symbols here? Isn't ARM_KPROBES_TEST_MODULE 
> > redundant?
> 
> When ARM_KPROBES_TEST_MODULE is configured for a stand-alone module,
> rather than built-in, then
> 
> #ifdef CONFIG_ARM_KPROBES_TEST_MODULE
> 
> is false.

OK... It seems that, when you have a tristate config symbol FOOBAR, if 
CONFIG_FOOBAR=y then the CONFIG_FOOBAR preprocessor symbol is defined.  
If you have CONFIG_FOOBAR=m then the CONFIG_FOOBAR_MODULE preprocessor 
symbol is defined.

In your example above you would end up with 
CONFIG_ARM_KPROBES_TEST_MODULE_MODULE being defined.

> I found other examples where people seemed to have gotten around this 
> by selecting a second config symbol and copied that. E.g. 
> FTRACE_STARTUP_TEST selects FTRACE_SELFTEST which is then used in 
> #ifdef statements.
> 
> Is there a better way? If not, I should explain this anyway in the
> changelog.

What I'd suggest is that you have:

config ARM_KPROBES_TEST
	tristate ...

And then you may use this in the code:

#ifdef CONFIG_ARM_KPROBES_TEST_MODULE
EXPORT_SYMBOL_GPL(...);
#endif

so those symbols are only exported when necessary.


Nicolas
