From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Sep 2015 15:17:03 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <560546D8.1010407@free.fr>
References: <56001B78.2090001@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <560546D8.1010407@free.fr>
Message-ID: <2210529.vnGEGUl8Dr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 15:06:32 Mason wrote:
> On 22/09/2015 16:51, Arnd Bergmann wrote:
> 
> > Move this to the platform Kconfig file. Also, drop all the
> > 'select' statements that are implied by ARCH_MULTIPLATFORM
> > and ARCH_MULTI_V7
> 
> I've trimmed my platform Kconfig down to:
> 
> config ARCH_TANGO4
>         bool "Sigma Designs Tango4 (SMP87xx)"
>         default y

drop the default

add
	depends on CPU_MULTI_V7

>         select ARCH_HAS_HOLES_MEMORYMODEL
>         select ARM_ERRATA_754322
>         select ARM_ERRATA_764369

	add 'if SMP'

>         select ARM_GIC
>         select CACHE_L2X0

remove CACHE_L2X0, we want to be able to turn this off.

>         select CLKSRC_MMIO
>         select GENERIC_IRQ_CHIP
>         select HAVE_ARM_SCU
>         select HAVE_ARM_TWD

	'if SMP'

>         select NEON
>         select SMP

These should be user-selectable as well, so drop the 'select'
and make sure the kernel builds with them turned off.
 
> 
> Didn't find much documentation on ARCH_HAS_HOLES_MEMORYMODEL.
> What is it used for?

You need this if the RAM is not physically contiguous, e.g. 256MB at one
address and another 256MB somewhere else.

> Is it OK to select CACHE_L2X0, NEON, and SMP?

no

	Arnd
