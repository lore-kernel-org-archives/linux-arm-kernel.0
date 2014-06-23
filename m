From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 23 Jun 2014 11:34:46 +0200
Subject: [PATCH v2] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <20140623090714.GH32514@n2100.arm.linux.org.uk>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com> <1396805315.7723.8.camel@x220>
 <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
 <20140620205340.GX32514@n2100.arm.linux.org.uk>
 <1403514104.12982.20.camel@x220>
 <20140623090714.GH32514@n2100.arm.linux.org.uk>
Message-ID: <1403516086.12982.35.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-06-23 at 10:07 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 23, 2014 at 11:01:44AM +0200, Paul Bolle wrote:
> > Dropped the "if CACHE_PL310" fragments used in v1. No need to use "if
> > CACHE_L2X0" instead. Both CACHE_PL310 and CACHE_L2X0 will be
> > (indirectly) selected if MACH_ARMADA_375 or MACH_ARMADA_38X are set.
> 
> Yes there is.  We've recently seen the selection of CACHE_L2X0 be removed
> from platforms, while leaving the selection of the errata behind.  The
> result is Kconfig warnings.  My commit above ensures that this doesn't
> happen in the future by adding the proper dependencies onto those errata
> selects.

The entries I touched read (in summary):
config MACH_MVEBU_V7
        bool
        select CACHE_L2X0

config MACH_ARMADA_370
        bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
        select MACH_MVEBU_V7
        help
          [...].

config MACH_ARMADA_375
        bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
        select MACH_MVEBU_V7
        help
          [...].

So the choice I faced was between: 
- using "select PL310_ERRATA_753970 if CACHE_L2X0": that matches all
  current occurrences of "select PL310_ERRATA_*" but adds a superfluous
  dependency on CACHE_L2X0
- using just "select PL310_ERRATA_753970": sufficient, but will break
  if CACHE_L2X0 isn't selected through MACH_MVEBU_V7 anymore.

I chose to just "select PL310_ERRATA_753970" but adding "if CACHE_L2X0"
is fine with me too.

> Please do the same.

Will do later today.

Thanks,


Paul Bolle
