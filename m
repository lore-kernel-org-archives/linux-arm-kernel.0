From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 16:15:15 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Message-ID: <201102081615.15713.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011, Dave Martin wrote:
> I guess there are two problems we're trying to solve here:
> 
> 1) a lowest-common denominator implementation of things like wfi(),
> for use in common code.  This must be based on __LINUX_ARM_ARCH__
> (which IIUC gives the lowest arch supported by all the CPUs being
> built for -- am I correct?)
> 2) definitions for specific CPUs, for non-generic code which may be
> bundled together in a single kernel build.
> 
> For (1), We can sensibly try to define a generic macro.  If building
> for ARMv6 and ARMv7 CPUs in the same kernel, then we have to use the
> lowest-common-denominator definition, i.e., the MCR form.  For ARMv7,
> we can use WFI.

But that doesn't work if you build a combined v5/v6/v7 kernel, because
v5 supports neither form, right? I think to do that, it needs the
same kind of abstraction that we have for a number of other things
like cache management in arch/arm/mm/.

> For (2), I think the best approach is to use the actual "wfi"
> instruction and build the affected files with the appropriate -march=
> flag (omap already does that) - since those CPU-specific files should
> by definition never be run if running on another CPU.  We only support
> new enough tools these days that this should be supported; so "wfi"
> should be preferable to ".long 0xdeadbeef" - otherwise we need lots of
> #ifdef CONFIG_THUMB2_KERNEL, or a macro.  If we have a macro, it would
> be better for that to be generically implemented somewhere, becasue
> the requirements are the same for every BSP supporting v7.

Makes sense.

> I don't like the practice of pre-assembling bits of code with .long,
> in order to allow a file to be built with wrong -march= flags, and I
> would favour migrating away from this where possible ... but I accept
> it's a pragmatic solution to a problem for which gcc/binutils provide
> no good alternative.

Yes. Moreover, new instructions may always have to be that way for
a while, before they can be moved over to the proper inline
assembly.

> So, for v6K we should either always use MCR for wfi(), or we need to
> define wfi() using ALT_SMP(wfi) ALT_UP(mcr).  But whether that's a
> common enough case to care about, I can't say.
> 
> 
> Any thoughts on all that?

I think that having all instances of wfi in per-CPU source files is
good enough, because it's not performance critical, and this method
is well-supported already.

	Arnd
