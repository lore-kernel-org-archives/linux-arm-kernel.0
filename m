From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 12 Jul 2010 11:03:12 +0800
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
Message-ID: <1278903792.387175.713057245098.0.gpush@pororo>
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

The first change updates all of the addruart macros to take an argument
in the first macro register, indicating whether we want a physical or
virtual address returned. This argument replaces the check present
in the existing macro implementations.

The second change updates the debug setup routine to use the addruart
macro to establish the debug mapping, now that we invoke the macro to
find the phyical and virtual addresses.

This allows us to delay the requirement to have a mdesc available until
much later. For example, we can parse one from the device tree once
we've reached C code.

Tested on versatile only. May break OMAP1/2, as the addruart macros are
more complex on these platforms. I'd appreciate input from OMAP folks
who may well tell me that this isn't possible.

These patches are not suitable for merging yet (no documentation updates
for the new format of addruart, very little testing, no handling of
DEBUG_ICEDCC). More of a request for you folks to tell me whether or
not this is a stupid idea :)

Cheers,


Jeremy

---
Jeremy Kerr (2):
      arm: don't check MMU status in every addruart macro
      arm: use addruart macro to establish debug mappings
