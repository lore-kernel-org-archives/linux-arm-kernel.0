From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Oct 2010 09:03:39 +0200
Subject: [PATCH/RFC] i.MX31 and i.MX35 : fix errate TLSbo65953 and
	ENGcm09472
In-Reply-To: <20101006063525.GS7159@buzzloop.caiaq.de>
References: <4CAAD39C.2010103@eukrea.com>
	<1286270739-18270-1-git-send-email-eric@eukrea.com>
	<20101005162920.GT11737@pengutronix.de>
	<20101006063525.GS7159@buzzloop.caiaq.de>
Message-ID: <20101006070339.GA29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 08:35:25AM +0200, Daniel Mack wrote:
> On Tue, Oct 05, 2010 at 06:29:20PM +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Oct 05, 2010 at 11:25:39AM +0200, Eric B?nard wrote:
> > > +#else
> > >  #ifdef CONFIG_ARCH_MXC91231
> > >  	if (cpu_is_mxc91231()) {
> > >  		/* Need this to set DSM low-power mode */
> > >  		mxc91231_prepare_idle();
> > >  	}
> > >  #endif
> > > -
> > >  	cpu_do_idle();
> > > +#endif
> > No.  When we start to have multi-soc support for imx and a kernel for
> > both mx35 and mxc91231 is compiled mxc91231_prepare_idle isn't called
> > anymore for mxc91231.  Ah, and cpu_do_idle isn't called anymore at all.
> > 
> > This needs to read:
> > 
> > 	#if defined (CONFIG_ARCH_MX31) || defined (CONFIG_ARCH_MX35)
> > 		if (cpu_is_mx31() || cpu_is_mx35()) {
> > 			unsigned long reg = 0;
> > 			__asm__ __volatile__(...);
> 
> A "return" statement here would save you the else branch and
> subsequently, one indentation level, right?
> 
> Also, I wonder whether the check for CONFIG_ARCH_MX3[15] is actually
> needed at all, as cpu_is_mx3x() will default to 0 at compile time in
> case those #defines are not set.
No, it's not needed, as Eric showed in his v2.  Let's continue to speak
about that one.

> 
> > 		} else
> > 	#endif
> > 		{
> > 		
> > #ifdef CONFIG_ARCH_MXC91231
> > 			if (cpu_is_mxc91231()) {
> > 				/* Need this to set DSM low-power mode */
> > 				mxc91231_prepare_idle();
> > 			}
> > #endif
> 
> In this case, though, they seem mandatory due to the symbol
> mxc91231_prepare_idle would be undefined otherwise.
yep.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
