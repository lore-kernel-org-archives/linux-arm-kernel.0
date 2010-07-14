From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:09:37 +0800
Subject: [RFC,PATCH 0/3] Allow late mdesc detection, v2
Message-ID: <1279073377.400469.233833413341.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Currently, we probe for a mdesc early in boot. At this early stage, the
only thing we use the mdesc for is to determine the debug page mapping.

However, the debug addresses (phys and virt) need to be coded into the
addruart macro anyway; the dynamic probing is only going to tell us what
we already know.

These (experimental!) changes allow us to use the addruart macros to
find the debug mapping addresses, rather than pulling them out of the
mdesc. This means that the addresses are only kept in the one place, and
that we don't need the mdesc nearly as early.

The first change updates all of the addruart macros to return both
physical and virtual addresses. I've used 'rp' and 'rv' as the macro
arguments to indicate which address goes where

The second change updates the debug setup routine to use the addruart
macro to establish the debug mapping, now that we can invoke the macro
to find the phyical and virtual addresses.

This allows us to delay the requirement to have a mdesc available until
much later. For example, we can parse one from the device tree once
we've reached C code.

May break OMAP1/2, as the addruart macros are more complex on these
platforms. I'd appreciate input from OMAP folks who may well tell me
that this isn't possible.

Compile-tested with all defconfigs, except ones that don't provide a
debug-macro.S file. Some configs are broken with DEBUG_LL=y (ie, even
without these changes), so I'll send a set of fixups for those
separately.

Cheers,


Jeremy

v2:
 * return both phys and virt addresses from addruart
 * mask unneeded bits from uart physical address in mapping setup
 * remove io_pg_offst and phys_io, in a separate patch

---
Jeremy Kerr (3):
      arm: return both physical and virtual addresses from addruart
      arm: use addruart macro to establish debug mappings
      arm: remove machine_desc.io_pg_offst and .phys_io
