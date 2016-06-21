From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 00:43:21 -0700
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160621074319.GH22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Russell King <rmk@armlinux.org.uk> [160617 12:52]:
> If we want to assume that the compressed image will expand by a maximum
> of 4x, we actually need to reserve 5x the space, since we need to keep
> a copy of the compessed image around while decompressing.

Looks like 5x is not enough with omap2plus_defconfig at least..
This one needs to be set to 6x for that. Maybe we should just make
it go all the way to 11 :)

Otherwise we get this without initrd:

kernel: 0xb6c2d008 kernel_size: 0x3a4418
MEMORY RANGES
0000000080000000-00000000bfdfffff (0)
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb6c2d008
segment[0].bufsz = 0x3a4418
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3a5000
segment[1].buf   = 0xadf80
segment[1].bufsz = 0xe000
segment[1].mem   = 0x8123f000
segment[1].memsz = 0xe000
[   32.886077] kexec_core: Starting new kernel
[   32.890502] Disabling non-boot CPUs ...
[   32.926696] CPU1: shutdown
[   32.991882] Bye!
Warning: Neither atags nor dtb found

And we get this with initrd:

kernel: 0xb6bf4008 kernel_size: 0x3a4418
MEMORY RANGES
0000000080000000-00000000fedfffff (0)
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb6bf4008
segment[0].bufsz = 0x3a4418
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3a5000
segment[1].buf   = 0xb6686008
segment[1].bufsz = 0x56dba2
segment[1].mem   = 0x8123e000
segment[1].memsz = 0x56e000
segment[2].buf   = 0xadf80
segment[2].bufsz = 0xd080
segment[2].mem   = 0x817ac000
segment[2].memsz = 0xe000
...
INITRD: 0x8123e000+0x0056dba2 overlaps in-use memory region - disabling initrd

Regards,

Tony
