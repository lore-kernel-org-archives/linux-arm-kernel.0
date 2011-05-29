From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 29 May 2011 15:06:44 +0200
Subject: ep93xx: status/future of the sparsemem support
Message-ID: <20110529130644.GI16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I would like to ask about the status or plans for the sparsemem support on the
ep93xx. I'm mainly talking about the ts72xx here as I don't have any other
boards, but it seems, that sparsemem is the must for the boards with more then
one memory bank. Or it's not true?

For example, right now, I'm trying to get the recent kernel working on the
ts-7300 with the 128MB RAM (two 64MB memory chips, 16 banks, 8MB each,
first 8 at 0x0000000-0x7000000, second one at 0xe0000000-0e7000000) and as you
might guess, it's unusable with flatmem (and it looks like the discontig mem
is now gone for ARM if I'm not mistaken):

	[..snip..]

	Ignoring RAM at e0000000-e07fffff (vmalloc region overlap).
	Ignoring RAM at e1000000-e17fffff (vmalloc region overlap).
	Ignoring RAM at e2000000-e27fffff (vmalloc region overlap).
	Ignoring RAM at e3000000-e37fffff (vmalloc region overlap).
	Ignoring RAM at e4000000-e47fffff (vmalloc region overlap).
	Ignoring RAM at e5000000-e57fffff (vmalloc region overlap).
	Ignoring RAM at e6000000-e67fffff (vmalloc region overlap).
	Ignoring RAM at e7000000-e77fffff (vmalloc region overlap).

	[..snip..]

	Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 128MB total
	Memory: 62076k/62076k available, 3460k reserved, 0K highmem
                ^
                |__ note, just lower 64MB available

	Virtual kernel memory layout:
	    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
	    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
	    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
	    vmalloc : 0xc8000000 - 0xfe800000   ( 872 MB)
	    lowmem  : 0xc0000000 - 0xc7800000   ( 120 MB)

If I apply the sparsemem patch as suggested here[1] it seems to work (well it
boots):

	Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 128MB total
	Memory: 127052k/127052k available, 4020k reserved, 0K highmem
	Virtual kernel memory layout:
	    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
	    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
	    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
	    vmalloc : 0xd0000000 - 0xfe800000   ( 744 MB)
	    lowmem  : 0xc0000000 - 0xcf800000   ( 248 MB)

The question is, what's the problem with the sparsemem patch[1] for ep93xx,
that it's not yet in the mainline? Nobody needed it yet? :-) If it's that the
case, I could submit it, no problem. I don't follow this mailing list and
development on the ep93xx regularly, so I might have missed some important
detail. Thank you for any pointers.

1. http://marc.info/?l=linux-arm&m=122754446724900

-- ynezz
