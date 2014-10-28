From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 15:05:21 +0000
Subject: [PATCH v2 4/5] ARM: allow errata and XIP options to be enabled
 without ARCH_MULTIPLATFORM_STRICT
In-Reply-To: <1831362.dUvM0VHfPi@wuerfel>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <6893071.4YhqEbdaBz@wuerfel>
 <20141028143118.GH27405@n2100.arm.linux.org.uk>
 <1831362.dUvM0VHfPi@wuerfel>
Message-ID: <20141028150521.GK27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:50:31PM +0100, Arnd Bergmann wrote:
> That would solve the problem for V7M, but I also don't see a reason
> to disallow XIP_KERNEL on a platform that depends on ARCH_MULTIPLATFORM.
> 
> The main problem is that any ARMv4/v5 platform that currently uses
> XIP_KERNEL breaks when we do a conversion to ARCH_MULTIPLATFORM, and
> I think that is bad.
> 
> The same applies to ZBOOT_ROM, which we should probably treat the
> same way here. An example for that is the Renesas SH-Mobile SH7372 that
> can boot directly from MMC. I really want Renesas to convert
> all of their SH-Mobile machines to multiplatform, just like all other
> ARMv7 platforms. There is nothing preventing you from running a
> multiplatform kernel on SH7372 as long as you don't want to load the
> kernel from MMC without a proper bootloader. I also don't see a reason
> to take out that feature just because they are migrating to multiplatform
> (there may or may not be other reasons to deprecate this feature, but that
> is a different matter). At the moment SH-Mobile can be built either
> as a standalone platform or as multiplatform, but even now you can build
> a kernel that uses CONFIG_ZBOOT_ROM_MMCIF and will only ever work on
> SH7372 but includes all other shmobile targets as well.
> 
> I don't see anything wrong with that, and I would like to see this
> keep working when SH7372 is part of ARCH_MULTIPLATFORM, but at the
> same time think it's good to have ARCH_MULTIPLATFORM_STRICT to prevent
> this from being selected for a kernel that is supposed to run everywhere.

What you're asking for is a multiplatform kernel which can't be run on
multiple platforms.  Think about that for a while.

If you're going to be building an ARMv5 XIP kernel, then it needs to only
include support for the ARMv5 SoC which you are targetting.  It's no good
to think "oh, we can then include other ARMv5 SoCs too" - you can, but
the kernel will never run there.

That's where the pre-multiplatform setup works well - it ensures that the
correct dependencies are there.  What we need to do is to combine these
two properly such that if you want to build with a feature which limits
you to one SoC, then the kernel configuration limits you to exactly that.
That's not done by making some magic Kconfig option which disables a load
of dependencies but still lets you chuck lots of useless stuff in together.

In any case, the thought of an XIP kernel with an allmodconfig config
rather misses one of the fundamental problems with XIP multiplatform.  If
you /ever/ want to write to the flash which the XIP kernel is contained,
you must move the interrupt handling code out into RAM, so that when an
interrupt happens, you can talk to the flash chip to make the kernel
readable again.  That takes *all* of the initial interrupt handling code
and data into RAM.

What that means is that our current IRQ multi-handler solution doesn't
work there - and we need a set of platform specific assembly fragments
to do this.

As I said previously, there's also the complexity in setting up the XIP
mappings in the assembly code, which takes quite an amount of knowledge
of the physical memory layout on the SoC.

Frankly, I think the idea of XIP and multiplatform is a pipedream.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
