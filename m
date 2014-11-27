From: mpeg.blue@free.fr (Mason)
Date: Thu, 27 Nov 2014 16:46:30 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <2978273.VePW8UymqL@wuerfel>
References: <5476FFA2.8010403@free.fr> <7958894.CNnhBWEkgT@wuerfel>
 <54773A8B.5000200@free.fr> <2978273.VePW8UymqL@wuerfel>
Message-ID: <54774756.40408@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2014 16:00, Arnd Bergmann wrote:

> On Thursday 27 November 2014 15:51:55 Mason wrote:
>
>> (BTW, the original code is 4-5 years old, while my target is 3.14.x)
>
> I meant the IO_ADDRESS stuff. Modern code uses ioremap() instead
> since the IO_ADDRESS was platform specific, and drivers can no longer
> use platform headers on CONFIG_ARCH_MULTIPLATFORM, which is used
> for all new code now.

$ grep CONFIG_ARCH_MULTIPLATFORM .config
# CONFIG_ARCH_MULTIPLATFORM is not set

One more thing on the TODO list (which is starting to look like a
phone directory). Do you have a reference explaining this option?
(I did read the short description in arch/arm/Kconfig)

> Would you consider submitting the code upstream?

This is definitely one of my objectives. I'm still learning the ropes
(I rewrote the cpufreq driver to use mostly generic functions, heard
of the clk "meta-framework" but haven't even started looking at that,
I'm also writing a temperature sensor driver for lm-sensors.)

> Modern platforms no longer have an include directory and use the
> standard definitions. How many other header files do you have in there?

$ find arch/arm/mach-tangox -name *.h | wc -l
44

> Actually, we also try to get rid of the need for most other files
> in mach-* as well, though commonly you need a little bit of code for
> bringing up secondary CPU cores. Everything else should be a device
> driver.

I see that other platforms put their cpufreq driver in drivers/cpufreq
Ours is in arch/arm/mach-tangox (same for cpuidle.c)
(Hmmm, now that I look more closely, I see that we also have a generic
clock.c in there... More on the TODO list.)

>> IIUC, you're saying the current method using iotable_init is not
>> appropriate, and I should use the map_io callback?
>
> map_io and iotable_init is the same thing, the former calls the latter.
> What I'm saying is that relying on hardcoded virtual addresses is
> not appropriate, you can use the iotable_init call to set up a
> hugetlb mapping for performance optimization, but it should really
> work without that.

I think I don't fully understand this paragraph yet. But you've given
me a lot to think about today, so maybe It'll sink in later.

Regards.
