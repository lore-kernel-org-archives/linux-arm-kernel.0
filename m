From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jun 2012 16:01:51 +0000
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <20120620144111.GC2179@linaro.org>
References: <20120611051502.GA24030@july> <201206201114.17033.arnd@arndb.de>
 <20120620144111.GC2179@linaro.org>
Message-ID: <201206201601.51368.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 June 2012, Dave Martin wrote:

> From my point of view, the name "smc ops" is a bit bogus.  Really these are
> platform-specific hooks which may need to be handled by firmware depending
> on the configuration, and the fact that they may be implemented by calling
> SMC is more of an implementation detail of one of the alternative
> implementations of those hooks.
> 
> So your struct might instead be called struct exynos4_firmware_ops, and
> your two instances might be called exynos4_native_firmware_ops and
> exynos4_smc_firmware_ops, or similar.  This is purely cosmetic, though.
> 
> As discussed in previous mails, the best way to choose which struct
> exynos4_firmware_ops to use may be to scan for something in the device
> tree, rather than using some scary probing hack.

Naming it firmware_ops rather than smc_ops sounds reasonable.

> If we have standard DT bindings for this stuff, we could have generic DT
> support code for selecting the correct exynos4_firmware_ops structure
> based on the DT.  Only the definition and contents of the platform-
> specific firmware_ops structs would need to vary.
> 
> Whether we could end up with a common firmware_ops structure across all
> platforms is less certain (?)

I would prefer to have a common one. Ideally I'd also like to see a
standardized firmware binary interface so that we can actually
have a generic instance of this structure for all platforms that
follow the standard and let the nonstandard ones provide their own
instance of this struct. We might need more than one standard though,
e.g. one for direct SMC calls and another one for ACPI in the future.

If we want to do something local to each platform, I would not even
call it firmware_ops, but just do whatever that platform needs.
In case of exynos, having two implementations of the pm_interface
as Kyungmin suggested sounds sufficient there, and we can do something
else for the next part of the platform that needs it.

If we want to have a more generic way to do it, I'd go all the way
and make it a platform-independent structure.

	Arnd
