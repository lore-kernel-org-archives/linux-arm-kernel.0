From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 16:43:39 +0100
Subject: [PATCH] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <1370532888.3500.11.camel@computer5.home>
References: <1370527112.3695.47.camel@linaro1.home>
 <20130606150156.GF16794@mudshark.cambridge.arm.com>
 <1370532888.3500.11.camel@computer5.home>
Message-ID: <20130606154339.GH16794@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 04:34:48PM +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-06-06 at 16:01 +0100, Will Deacon wrote:
> > > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > > index 5907e10..fe637e9 100644
> > > --- a/arch/arm/mach-vexpress/Kconfig
> > > +++ b/arch/arm/mach-vexpress/Kconfig
> > > @@ -56,5 +56,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> > >  
> > >  config ARCH_VEXPRESS_CA9X4
> > >  	bool "Versatile Express Cortex-A9x4 tile"
> > > +	select ARM_ERRATA_643719
> > 
> > We don't do this for any other workarounds, so I'd suggest either dropping
> > this or having a separate patch adding all of those that are required.
> 
> Not quite sure by what you mean by 'all of those that are required'. All
> the errata required for vexpress? Or all platforms which require the
> errata workaround?

I mean, the A9 coretile on vexpress also has other errata, for which we have
workarounds in the kernel. They aren't automatically selected (for example,
ARM_ERRATA_720789) so if you want to do this, it's worth selecting all or
none, rather than make it look like you're selecting all those that apply
when you're not.

> If we don't enable the workaround in the Kconfig, then do we just add it
> to the vexpress_defconfig and hope people notice? Or, as we have
> ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA, we could select it in there?

It doesn't affect A5, so I wouldn't put it there. The usual place is the
defconfig.

> Finally, whilst I'm asking questions ;-) I was hoping to fix a
> regression that slipped into 3.10, is this late -rc material or will it
> end up waiting for 3.11?

The fix to v7_flush_dcache_louis should go in for 3.10 and probably stable
as well. I don't think the vexpress kconfig stuff is as important.

Will
