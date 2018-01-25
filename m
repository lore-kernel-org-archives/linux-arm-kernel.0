From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 25 Jan 2018 23:09:52 +0200
Subject: [BISECTED] kexec issue with v4.15-rc on N8x0
In-Reply-To: <20180124223953.GO28231@n2100.armlinux.org.uk>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
 <20180115181508.GM4821@atomide.com>
 <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
 <20180123204544.GM28231@n2100.armlinux.org.uk>
 <20180123212327.GN28231@n2100.armlinux.org.uk>
 <20180124212133.qyav5w36meljaakq@darkstar.musicnaut.iki.fi>
 <20180124223953.GO28231@n2100.armlinux.org.uk>
Message-ID: <20180125210951.csx6lzuzfleqj3qy@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 24, 2018 at 10:39:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 24, 2018 at 11:21:33PM +0200, Aaro Koskinen wrote:
> > So something is missing from the size calculation...?
> 
> Maybe.  Please try this patch on top of the previous one, and report
> the new debug output.

That patch is working. See below with results before and after the patch.

Before:

kernel: 0xb6a5d008 kernel_size: 0x3c6060
MEMORY RANGES
0000000080000000-0000000087ffffff (0)
zImage header: 0x016f2818 0x00000000 0x003c6060
zImage size 0x3c6060, file size 0x3c6060
  offset 0x00003b98 tag 0x5a534c4b size 8
Kernel: address=0x80008000 size=0x00f0e000
DT    : address=0x80f17000 size=0x00008c35
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb6a5d008
segment[0].bufsz = 0x3c6060
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3c7000
segment[1].buf   = 0x16e12b8
segment[1].bufsz = 0x8c35
segment[1].mem   = 0x80f17000
segment[1].memsz = 0x9000
[    4.840179] kexec_core: Starting new kernel
[    4.844604] Bye!

After:

kernel: 0xb6a79008 kernel_size: 0x3c6060
MEMORY RANGES
0000000080000000-0000000087ffffff (0)
zImage header: 0x016f2818 0x00000000 0x003c6060
zImage size 0x3c6060, file size 0x3c6060
zImage requires 0x003d7060 bytes
  offset 0x00003b98 tag 0x5a534c4b size 8
Decompressed kernel sizes:
 text+data 0x00b47fa0 bss 0x0011674c total 0x00c5e6ec
Resulting kernel space: 0x00f1f000
Kernel: address=0x80008000 size=0x00f1f000
DT    : address=0x80f28000 size=0x00008c35
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb6a79008
segment[0].bufsz = 0x3c6064
segment[0].mem   = 0x80008000
segment[0].memsz = 0x3c7000
segment[1].buf   = 0x10152b8
segment[1].bufsz = 0x8c35
segment[1].mem   = 0x80f28000
segment[1].memsz = 0x9000
[    4.840240] kexec_core: Starting new kernel
[    4.844665] Bye!
[    0.000000] Booting Linux on physical CPU 0x0

A.
