From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Feb 2014 15:54:45 +0100
Subject: [Patch v3 20/23] ARM: config: Add a multi_v5_defconfig
In-Reply-To: <1392819548.815735822@f395.i.mail.ru>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392819174-11634-21-git-send-email-andrew@lunn.ch>
 <1392819548.815735822@f395.i.mail.ru>
Message-ID: <2697728.sKu8bCFvXU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 February 2014 18:19:08 Alexander Shiyan wrote:
> ?????, 19 ??????? 2014, 15:12 +01:00 ?? Andrew Lunn <andrew@lunn.ch>:
> > To allow regression build testing of multi v5 systems, add a
> > multi_v5_defconfig, similar to the multi_v7_defconfig. This is based
> > on kirkwood_defconfig, but with a few other boards added which claim
> > to be MULTI_v5.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/configs/multi_v5_defconfig | 183 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> >  create mode 100644 arch/arm/configs/multi_v5_defconfig
> > 
> > diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> ...
> > +CONFIG_DEBUG_LL=y
> > +CONFIG_DEBUG_MVEBU_UART_ALTERNATE=y
> > +CONFIG_DEBUG_UART_VIRT=0xfed12000
> 
> Should we disable lowlevel debug for multi-* config?

Yes, definitely.

On a related note, I'd like to add a CONFIG_BROKEN_MULTIPLATFORM Kconfig
symbol and make all options depend on that which will result in a kernel
that is not actually multiplatform but can only run on a subset of the
platforms you can enable together. Aside from DEBUG_LL, this would
include XIP_KERNEL, !MMU, !ARM_PATCH_PHYS_VIRT, ZBOOT_ROM, !AUTO_ZRELADDR
and possibly more. A multi_*_defconfig by definition must not enable
BROKEN_MULTIPLATFORM, but there can be good reasons for individual
configurations to enable that when you want to build for a specific
system that happens to be part of ARCH_MULTIPLATFORM.

	Arnd
