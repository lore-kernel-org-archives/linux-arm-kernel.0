From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Tue, 18 May 2010 10:06:38 -0400
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005180802010.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
Message-ID: <AANLkTikg4rQdnbFxBOUkGc_0DrKqRkp9raZ8Ck5xkLG4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With respect to machine IDs, why not have our cake and eat it too?

(NOTE: This proposal assumes that the boot code has already
       determined whether ATAGs or a DT has been passed to
       the kernel, and that ATAG and DT machine IDs are in
       the same namespace)

1) We already have machine names in the mach-types file, and we
can propose that those are used as the top-level 'compatible'
tags for the DTs.

...
   compatible = "openrd\000kirkwood\000armv6\000arm"
...


2) We can trivially generate a name-to-machine ID hash table from
the mach-types file (CRC32 of the name, or some other hash)

3) Allocate per-SoC machine IDs for DT names, and a
global generic machine ID as a catch-all:

dt_arm        MACH_DT_ARM       DT_ARM       xxxx
dt_armv6      MACH_DT_ARMV6     DT_ARMV6     xxxx
dt_kirkwood   MACH_DT_KIRKWOOD  DT_KIRKWOOD  xxxx
dt_at91       MACH_DT_AT91      DT_AT91      xxxx

4) Each machine type that cares about DTs could register a
callback function, that would be placed in a linker-assembled
table mapping machine IDs (or the name hashes) to callbacks:

void at91_setup_from_dt(struct device_tree_node *dt)
{
  ...
}

DECLARE_DT_CALLBACK(at91, at91_setup_from_dt)

5) The 'arm' callback would handle common-code devices,
such as NOR flash, memory areas, etc. and would be called
after the machine-specific callbacks.

6) So, for the openrd case above, the DT parser callback
would call on, for each object in the DT:

  a) The MACH_DT_OPENRD callback, if it exists. If not, or
     if it returns -ENOTSUP:
  b) The MACH_DT_KIRKWOOD callback, if it exists. If not, or
     if it returns -ENOTSUP:
  c) The MACH_DT_ARMV6 callback, if it exists. If not, or
     if it returns -ENOTSUP:
  d) The MACH_DT_ARM callback, if it exists. If not, or
     if it returns -ENOTSUP:

-- 
Jason S. McMullan
Netronome Systems, Inc.
