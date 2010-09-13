From: milan.svoboda@centrum.cz (Milan Svoboda)
Date: Mon, 13 Sep 2010 14:18:43 +0200
Subject: Regression on UP ARM from commit
Message-ID: <1284380323.405634.1921.nullmailer@mail1002.cent>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Sun, Sep 12, 2010 at 11:47:39PM +0200, Linus Walleij wrote:
> > commit e18d65f0500b95d8724b17d8ea9f1116cf390bbe
> > "slub: Remove static kmem_cache_cpu array for boot"

> In which tree have you found this commit? I cant find 
> e18d65f0500b95d8724b17d8ea9f1116cf390bbe in Linus' (Torvalds) tree up to -rc4.

> baruch

> > made my ARM 926 UP system hang at boot, if I revert this (have
> > to back out a lot of SLUB patches for that) it comes back up. (Same if I
> > switch to SLAB.)
> > 
> > Any hints on how I can get patch around this in a nice way?

This patch may help you. I got similarly looking problem, so there is
chance it is the same problem you are dealing with.
I don't know if there is some other problem, but this patch
fixes a problem caused by illogical assigning max_addr and boot
proceeds as usual and I see no problem during boot and use of the
system.

Best regards,
Milan Svoboda

commit 4b970a1688a42c74de4e7ee151608ef6ff8d290c
Author: Milan Svoboda <msvoboda@ra.rockwell.com>
Date:   Tue Aug 17 08:11:43 2010 +0200

    ARM: MM: fix memblock to pass early stage of booting

diff --git a/mm/memblock.c b/mm/memblock.c
index 3024eb3..a10dacb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -396,11 +396,6 @@ u64 __init __memblock_alloc_base(u64 size, u64 align, u64 max_addr)

        size = memblock_align_up(size, align);

-       /* On some platforms, make sure we allocate lowmem */
-       /* Note that MEMBLOCK_REAL_LIMIT may be MEMBLOCK_ALLOC_ANYWHERE */
-       if (max_addr == MEMBLOCK_ALLOC_ANYWHERE)
-               max_addr = MEMBLOCK_REAL_LIMIT;
-
        for (i = memblock.memory.cnt - 1; i >= 0; i--) {
                u64 memblockbase = memblock.memory.region[i].base;
                u64 memblocksize = memblock.memory.region[i].size;
