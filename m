From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 01 Sep 2010 09:07:50 +0800
Subject: [PATCH 0/3] Allow late mdesc detection, v5
Message-ID: <1283303270.565454.673065645961.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Currently, we probe for a mdesc early in boot. At this early stage, the
only thing we use the mdesc for is to determine the debug page mapping.

However, the debug addresses (phys and virt) need to be coded into the
addruart macro anyway; the dynamic probing is only going to tell us what
we already know.

These changes allow us to use the addruart macros to find the debug
mapping addresses, rather than pulling them out of the mdesc. This means
that the addresses are only kept in the one place, and that we don't
need the mdesc nearly as early.

The first change updates all of the addruart macros to return both
physical and virtual addresses. I've used 'rp' and 'rv' as the macro
arguments to indicate which address goes where

The second change updates the debug setup routine to use the addruart
macro to establish the debug mapping, now that we can invoke the macro
to find the phyical and virtual addresses.

This allows us to delay the requirement to have a mdesc available until
much later. For example, we can parse one from the device tree once
we've reached C code.

As they have more complex and/or new debug macros, the following platforms
could do with extra testing:
 * omap (mach-omap1 and mach-omap2)
 * davinci (done, thanks Kevin)
 * tegra

Cheers,


Jeremy

v5:
 * Add handing for !CONFIG_MMU

v4:
 * updates for 2.6.36
 * add changes for tegra
 * update davinci
 * include fixes for omap[12]
 * drop mdesc changes

v3:
 * only establish page mapping if !DEBUG_ICEDCC

v2:
 * return both phys and virt addresses from addruart
 * mask unneeded bits from uart physical address in mapping setup
 * remove io_pg_offst and phys_io, in a separate patch

---
Jeremy Kerr (3):
      arm/debug: consolidate addruart macros for CONFIG_DEBUG_ICEDCC
      arm: return both physical and virtual addresses from addruart
      arm: use addruart macro to establish debug mappings
