From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Nov 2012 23:26:22 +0000
Subject: arch-vt8500 and wm8850 support
In-Reply-To: <1352914966.3238.3.camel@gitbox>
References: <1352879641.2728.8.camel@gitbox>
 <201211141117.33485.arnd@arndb.de> <1352914966.3238.3.camel@gitbox>
Message-ID: <201211142326.23023.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 November 2012, Tony Prisk wrote:
> Makes sense - That's basically what I had in mind. My concern is with
> the bit that made no sense to me - the non-multiplatform version of the
> same. At the moment, we have the default xx_SINGLE for ARCH_VT8500.
> Would I need to add an additional xx_SINGLE variant for each different
> version?

I think either one option or two (v5 and v6/v7), but we don't need three
separate ones, as it should be possible to build v6 and v7 together.

> We would need ARCH_WM8505 (To cover VT8500/WM8505/WM8650 ARM926),
> ARCH_WM8750 (for ARMv6) and ARCH_WM8850 (for ARMv7).

Ah, right, I was mixing up the numbers.

> Do I need a ARCH_WM8750_SINGLE, ARCH_WM8850_SINGLE etc for each one to
> allow use to continue using earlyprintk?

You just need to ensure that we always set at least one of them, and
that ARCH_WM8505 isn't set at the same time as one of the v6/v7 parts.

Maybe something like

config ARCH_VT8500
      bool
      select FOO
      select BAR

config ARCH_WM8505
      bool "WonderMedia WM8505/WM8650 or VIA VT8500" if !ARCH_VT8500_SINGLE
      depends on ARCH_MULTI_V5
      default ARCH_VT8500_SINGLE
      select ARCH_VT8500
      select CPU_ARM926

config ARCH_WM8750
      bool "WonderMedia WM 8750"
      depends on ARCH_MULTI_V6 || ARCH_WM8750_SINGLE
      select ARCH_VT8500
      select CPU_V6

config ARCH_WM8850
      bool "WonderMedia WM 8850/8950"
      depends on ARCH_MULTI_V7 || ARCH_WM8750_SINGLE
      select ARCH_VT8500
      select CPU_V7

config ARCH_WM8850_AUTO
      def_bool y
      depends on ARCH_WM8750_SINGLE && !ARCH_WM8750
      select ARCH_WM8850 # ensure that ARCH_WM8850 is on if ARCH_WM8750 is off


	Arnd
