From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 7 Apr 2015 03:31:03 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150405160203.GF13898@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150405160203.GF13898@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB05619EB06ED9EA52495B06038AFD0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We have had something that worked very well for this kind of stuff for many many years - that
> is the top level choice statement where the multi-platform option can be found.


In arch/arm/Kconfig, there is already a
config ARCH_SHMOBILE_LEGACY
	bool "Renesas ARM SoCs (non-multiplatform)"
	select ARCH_SHMOBILE

But, that will only get you to a limited number of systems to choose from.


The system I want (ARCH_R7S72100), in arch/arm/mach-shmobile/Kconfig is buried inside
if ARCH_SHMOBILE_MULTI
. . .
. . .
config ARCH_R7S72100
	bool "RZ/A1H (R7S72100)"
	select SYS_SUPPORTS_SH_MTU2
. . .
. . .
endif


Hence, I can't select ARCH_R7S72100 without first selecting multi-platform.

So, to not break multi-platform, but still allow single builds (and not
break anyone's existing config files), we'd have to go back to the way
it was, which was having duplicate ARCH entries in:

if ARCH_SHMOBILE_MULTI
. . .
. . .
endif

 and

if ARCH_SHMOBILE_LEGACY
. . .
. . .
endif

However, this idea conflicts with Arnd's statement:

> a) building a kernel for a single machine while CONFIG_ARCH_MULTIPLATFORM is
>    enabled
>
> I have patches to make ARCH_MULTIPLATFORM always enabled on all ARMv6/v7 (snip)
>
> This means that I would definitely want to see XIP_KERNEL being possible on your machine with a)


I must be missing something, but the only way to have it show up in the menu under multi-platform and single-platform is to duplicate the ARCH_xxx entry.


Chris
