From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 11:39:23 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <170b7522fb120f3afcc4b7aa1f90e341@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <3824169.vxchxyBt3o@wuerfel> <170b7522fb120f3afcc4b7aa1f90e341@agner.ch>
Message-ID: <6200216.zaJV8lHmUr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 10:54:48 Stefan Agner wrote:
> > Another option might be to consolidate these three into a single
> > directory, if someone can come up with a good name. The machine
> > files are all trivial, so they could even be merged into one as
> > far as I can tell, we just need slightly different 'select'
> > statements above.
> > 
> > If we do that, is it possible to merge Vybrid into that as well?
> > I guess the main question here is how much other infrastructure
> > (if any) from mach-imx is used on vf610, and if there is some other
> > way to do that.
> 
> I think it is nice today to use the same Kconfig symbol (SOC_VF610) as
> we use for the primary Cortex-A5 processor. After all, the kernel is
> running on the same SoC... Its just a different processor we are running
> on.

Yes, though you can in fact have multiple definitions of the same symbol,
so that would still work if you define CONFIG_SOC_VF610 outside again
outside of mach-imx. It would be a little ugly and possibly confusing
though.

> Today, I rely on several config symbols set by ARCH_MXC or SOC_VF610,
> some of that quite SoC specific (PINCTRL_VF610). However, after the move
> of the clock stuff which is in imx-next, there is really almost no
> machine specific code required from mach-imx. However, I plan to add PM
> support, which probably still will land in the machine folder?

What kind of PM support? We should have driver subsystems for most of
it now, and the goal has always been that you're able to do it without
platform specific code.

> I also think that it would a bit risky to do this for that release. So
> maybe as first step, simply split out the machines in individual Kconfig
> files?
> 
> What do you think about the defconfig dependency Uwe pointed out? Shall
> I create a single patch on-top of a soc/defconfig merged branch?

I think for efm32, we want to change the defconfig in the same commit
that moves the option around, to it keeps working across bisection.

For the other ones, it is probably easier as a separate patch, as the
defconfigs do not exist in the next/soc branch yet and there is no
possible regression either.

	Arnd
