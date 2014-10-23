From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 22 Oct 2014 19:10:58 -0700
Subject: CMA region and highmem
In-Reply-To: <20140813191811.GP30401@n2100.arm.linux.org.uk>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
Message-ID: <CADtm3G65f0RZR-RBw=kdKWoTP0RFOPwPjhjkEbF2JFeUV0YZPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Aug 13, 2014 at 12:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [...]
> The reason I ask is that this morning, I was greeted by this excellent
> OOM on one of my platforms.  It has 2G of memory, and no real DMA
> restrictions, and with much of the memory still available, it OOM'd
> because I need a relatively large CMA block.
> [...]
> xdg-screensaver invoked oom-killer: gfp_mask=0x4d0, order=2, oom_score_adj=0
> CPU: 2 PID: 6476 Comm: xdg-screensaver Not tainted 3.16.0+ #1322
> ...
> [<c001c8e8>] (pgd_alloc) from [<c00237b8>] (mm_init.isra.51+0xc0/0x120)
> ...
> Mem-info:
> Normal per-cpu:
> CPU    0: hi:  186, btch:  31 usd:  29
> CPU    1: hi:  186, btch:  31 usd:   0
> CPU    2: hi:  186, btch:  31 usd:   0
> CPU    3: hi:  186, btch:  31 usd:   0
> HighMem per-cpu:
> CPU    0: hi:  186, btch:  31 usd:   0
> CPU    1: hi:  186, btch:  31 usd:  21
> CPU    2: hi:  186, btch:  31 usd:   0
> CPU    3: hi:  186, btch:  31 usd:   0
> active_anon:47933 inactive_anon:2583 isolated_anon:0
>  active_file:16171 inactive_file:71321 isolated_file:0
>  unevictable:0 dirty:0 writeback:0 unstable:0
>  free:244622 slab_reclaimable:3605 slab_unreclaimable:95994
>  mapped:21360 shmem:5230 pagetables:1176 bounce:0
>  free_cma:37697
> Normal free:159400kB min:3440kB low:4300kB high:5160kB active_anon:54336kB
>  inactive_anon:2580kB active_file:56kB inactive_file:204kB unevictable:0kB
>  isolated(anon):0kB isolated(file):0kB present:778240kB managed:740044kB
>  mlocked:0kB dirty:0kB writeback:0kB mapped:5336kB shmem:5428kB
>  slab_reclaimable:14420kB slab_unreclaimable:383976kB kernel_stack:2512kB
>  pagetables:1088kB unstable:0kB bounce:0kB free_cma:150788kB
>  writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 10304 10304
> HighMem free:818228kB min:512kB low:2044kB high:3576kB active_anon:138352kB
>  inactive_anon:7752kB active_file:64692kB inactive_file:285204kB unevictable:0kB
>  isolated(anon):0kB isolated(file):0kB present:1318912kB managed:1318912kB
>  mlocked:0kB dirty:0kB writeback:0kB mapped:80072kB shmem:15492kB
>  slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
>  pagetables:3636kB unstable:0kB bounce:0kB free_cma:0kB
>  writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0
> Normal: 117*4kB (UEMC) 959*8kB (UEMC) 2*16kB (C) 2*32kB
>  (C) 2*64kB (C) 0*128kB 0*256kB 0*512kB 1*1024kB (C) 1*2048kB (C)
>  36*4096kB (C) = 158892kB
> HighMem: 32*4kB (UM) 75*8kB (UM) 633*16kB (UM) 377*32kB (UM) 191*64kB
>  (UM) 86*128kB (UM) 40*256kB (M) 19*512kB (M) 14*1024kB (UM) 6*2048kB
>  (UM) 177*4096kB (MR) = 817736kB
> 92769 total pagecache pages
> 0 pages in swap cache
> Swap cache stats: add 0, delete 0, find 0/0
> Free swap  = 0kB
> Total swap = 0kB
> 524288 pages of RAM
> 244139 free pages
> 9549 reserved pages
> 27079 slab pages
> 55230910 pages shared
> 0 pages swap cached
> ...
> Out of memory: Kill process 3460 (vlc) score 38 or sacrifice child
> Killed process 3460 (vlc) total-vm:278340kB, anon-rss:30360kB, file-rss:48988kB
> [...]
> As you can see, there's plenty of precious lowmem still available, but
> because we only have 760MB of lowmem, from which we steal 256MB for
> CMA, this leaves around 500MB of lowmem free - and that puts quite a
> lot of pressure on lowmem.  Meanwhile, we have oodles of highmem still
> available which would be better suited to CMA - especially as CMA would
> not have to do dance around changing the page tables.

I am running into a similar issue with CMA, and am still confused: how
is it that even though there's ~160 MB of lowmem free shown above, and
based on

> Normal: 117*4kB (UEMC) 959*8kB (UEMC) 2*16kB (C) 2*32kB
>  (C) 2*64kB (C) 0*128kB 0*256kB 0*512kB 1*1024kB (C) 1*2048kB (C)
>  36*4096kB (C) = 158892kB

it doesn't look like the fragmentation is _too_ terrible, an OOM still
happens?  Since this didn't seem surprising to you, I'm thinking my
understanding might be wrong, and was wondering if you might be able
to help me understand how an OOM like this happens with such a large
amount of lowmem still free.

Thanks and regards,
Gregory
