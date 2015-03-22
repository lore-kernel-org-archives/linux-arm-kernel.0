From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Mar 2015 20:48:47 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150322165710.GO8656@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150322165710.GO8656@n2100.arm.linux.org.uk>
Message-ID: <201503222048.47779.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 March 2015, Russell King - ARM Linux wrote:
> > You are correct...maybe my wording was confusing. This is what I meant:
> > 
> > config ARCH_MULTIPLATFORM
> >       bool "Allow multiple platforms to be selected"
> >       depends on MMU
> >       select ARCH_WANT_OPTIONAL_GPIOLIB
> >       select ARM_HAS_SG_CHAIN
> > -     select ARM_PATCH_PHYS_VIRT
> > +     select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
> 
> Yes, that makes sense if we agree that we want to have multi-platform
> XIP kernels.

I'd rather see this possibility enabled than have separate multiplatform
and non-multiplatform Kconfig entries for each machine that may
want XIP_KERNEL. The same thing applies to no-MMU support: we now
have platforms (i.MX for now, other likely to follow) that are already
multiplatform and that are gaining support for no-MMU implementations.

For those too, we need to set the physical address, which means
we can not run on othe rmachines that may be configured at the
same time.

> The problem is going to be expressing what a set of valid configurations
> are - soo many of them just won't boot.  For example, if any of the
> multiplatforms select SMP, but you want a non-SMP XIP kernel, you have
> to devine which platforms are forcibly selecting SMP and turn them off.
> In some of the kernel configurators, that's almost impossible to find
> out.

For a XIP kernel, I'd normally expect the user to turn off all machines
other than the one that the kernel is meant to run on, except for build
testing.

> I guess the other problem is going to be that people will want to add a
> set of reasonable defaults for CONFIG_PHYS_OFFSET based upon the
> platform selected - and we know that we have problems with that kind of
> thing when it comes to the DEBUG_LL stuff interacting with a multiplatform
> kernel.

I think a number of people have expressed that they'd rather get rid of the
DEBUG_LL list in the long run, now that we have earlycon working. If we
can treat XIP_KERNEL as a special case that would only be used for special
embedded systems, I don't think we need a preconfigured list of defaults,
but rather hide XIP_KERNEL under CONFIG_EXPERT and expect the few users
that need it to know the address or start with a working defconfig file
that has it configured.

	Arnd
