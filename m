From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri, 19 Aug 2011 15:26:38 -0400
Subject: [PATCH RFC] ARM: vexpress: Use assembler mnemonic for WFI in
	platform_do_lowpower.
In-Reply-To: <20110819181514.GA12654@gallagher>
References: <1313777004-4716-1-git-send-email-nbowler@elliptictech.com>
	<20110819181514.GA12654@gallagher>
Message-ID: <20110819192638.GA21043@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-08-19 19:15 +0100, Jamie Iles wrote:
> On Fri, Aug 19, 2011 at 02:03:24PM -0400, Nick Bowler wrote:
[...]
> > -		/*
> > -		 * here's the WFI
> > -		 */
> > -		asm(".word	0xe320f003\n"
> > +		asm("wfi\n"
> >  		    :
> >  		    :
> >  		    : "memory", "cc");
> 
> There's a wfi() macro defined in arch/arm/include/asm/system.h that 
> could be used here.

Indeed, thanks for pointing that out.

I'm a little wary, however: the wfi macro does not include the "cc"
clobber that this code has currently, and I don't know what the
implications of removing it are.  There appears to be no current
users of the wfi macro.

Taking a closer look, there appear to be five platforms that have a
hardcoded WFI just like the above (including the "cc" clobber):
exynos4, realview, shmobile, tegra and vexpress.  omap defines its
own do_wfi macro, *without* the "cc" clobber.

Nevertheless, using the macro seems to work just fine, so I can
certainly re-spin the patch with that instead.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
