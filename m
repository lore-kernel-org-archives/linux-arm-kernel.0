From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 16:59:51 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <54774756.40408@free.fr>
References: <5476FFA2.8010403@free.fr> <2978273.VePW8UymqL@wuerfel>
 <54774756.40408@free.fr>
Message-ID: <11601741.5istDo3S3l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 16:46:30 Mason wrote:
> On 27/11/2014 16:00, Arnd Bergmann wrote:
> 
> > On Thursday 27 November 2014 15:51:55 Mason wrote:
> >
> >> (BTW, the original code is 4-5 years old, while my target is 3.14.x)
> >
> > I meant the IO_ADDRESS stuff. Modern code uses ioremap() instead
> > since the IO_ADDRESS was platform specific, and drivers can no longer
> > use platform headers on CONFIG_ARCH_MULTIPLATFORM, which is used
> > for all new code now.
> 
> $ grep CONFIG_ARCH_MULTIPLATFORM .config
> # CONFIG_ARCH_MULTIPLATFORM is not set
> 
> One more thing on the TODO list (which is starting to look like a
> phone directory). Do you have a reference explaining this option?
> (I did read the short description in arch/arm/Kconfig)

The brief version is that instead of selecting just one platform
at a time, you can now build a kernel with (almost) all ARMv6 and
ARMv7 platforms enabled at the same time, and new platforms are no
longer allowed to be separate options. When you look at any of the
modern (e.g. sunxi, rockchip, hisi, ...) platforms you find how
their Kconfig is structured. Some older platforms still have a lot
of other files in the mach-* directories for historic reasons, but
you wouldn't do that for a new platform.

> > Would you consider submitting the code upstream?
> 
> This is definitely one of my objectives. I'm still learning the ropes
> (I rewrote the cpufreq driver to use mostly generic functions, heard
> of the clk "meta-framework" but haven't even started looking at that,
> I'm also writing a temperature sensor driver for lm-sensors.)

Ok, cool. Can you upload what you have to a public git tree for
reference? 

> > Modern platforms no longer have an include directory and use the
> > standard definitions. How many other header files do you have in there?
> 
> $ find arch/arm/mach-tangox -name *.h | wc -l
> 44

Ouch. I'm guessing that a lot of these will be driver specific.
Those headers should just be merged into whatever driver uses the
registers and removed from the platform.

Then there is the case of platform_data definitions. For platforms
using traditional board files, these should get moved to
include/linux/platform_data/, but for an upstream port you will have
to use devicetree anyway, and then you won't need platform data.

> > Actually, we also try to get rid of the need for most other files
> > in mach-* as well, though commonly you need a little bit of code for
> > bringing up secondary CPU cores. Everything else should be a device
> > driver.
> 
> I see that other platforms put their cpufreq driver in drivers/cpufreq
> Ours is in arch/arm/mach-tangox (same for cpuidle.c)
> (Hmmm, now that I look more closely, I see that we also have a generic
> clock.c in there... More on the TODO list.)

Right. We moved almost everything into subsystems. Also clocksource,
irqchip, pinctrl, gpio, dma, led, pwm, and probably some more that
I forgot.

	Arnd
