From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Sun, 12 Apr 2015 18:21:15 -0700
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <20150413010913.GA15225@corellia.local>
References: <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk>
 <20150326123028.GM4701@suse.de>
 <CADtm3G4Lb=u+BAHZF+O+RgB4VS9iW8epCPJ9ssBTj=+p3+h==Q@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D104A310D42397@CNBJMBX05.corpusers.net>
 <20150410112430.GB12732@n2100.arm.linux.org.uk>
 <20150413010913.GA15225@corellia.local>
Message-ID: <20150413012115.GB15225@corellia.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 12, 2015 at 06:09:13PM -0700, Gregory Fong wrote:
> On Fri, Apr 10, 2015 at 12:24:31PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 10, 2015 at 01:18:04PM +0800, Wang, Yalin wrote:
> > > > [   12.212102] active_anon:734 inactive_anon:1189 isolated_anon:0
> > > > [   12.212102]  active_file:0 inactive_file:0 isolated_file:0
> > > > [   12.212102]  unevictable:0 dirty:0 writeback:0 unstable:0
> > > > [   12.212102]  free:254104 slab_reclaimable:82 slab_unreclaimable:843
> > 
> > Here, we have 82 pages reclaimable, which is 328kB, and 843 unreclaimable
> > which is 3372kB, which is a total of 925 pages.
> > 
> > > > [   12.212102]  mapped:429 shmem:1815 pagetables:13 bounce:0
> > > > [   12.212102]  free_cma:4032
> > > > [   12.243172] DMA free:754080kB min:3472kB low:4340kB high:5208kB
> > > > active_anon:180kB inactive_anon:0kB active_file:0kB inactive_file:0kB
> > > > unevictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB
> > > > managed:759252kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
> > > > shmem:0kB slab_reclaimable:328kB slab_unreclaimable:3372kB
> > 
> > Which agrees here.
> > 
> > > > [   12.401609] 834 slab pages
> > 
> > but not here... this is an interesting difference, because in the ARM
> > version of show_mem(), we count the actual number of pages where
> > PageSlab() returns true.  Can slab pages also be reserved pages or
> > swap cache pages?  I thought they were exclusive of those.  So, the
> > question comes... why the difference in accounting, and which one is
> > correct.
> > 
> > Maybe there's a bug in the accounting somewhere...
> 
> Yes, the ARM show_mem wasn't updated after the various allocators
> (SLUB, SLAB, SLOB) were updated to use compound pages.  Fixing it, you
> get
> 
> [    7.081826] sysrq: SysRq : Show Memory
> [    7.085610] Mem-info:
> [    7.087890] DMA per-cpu:
> [    7.090431] CPU    0: hi:  186, btch:  31 usd:  98
> [    7.095230] HighMem per-cpu:
> [    7.098116] CPU    0: hi:   90, btch:  15 usd:  29
> [    7.102923] active_anon:724 inactive_anon:1189 isolated_anon:0
> [    7.102923]  active_file:0 inactive_file:0 isolated_file:0
> [    7.102923]  unevictable:0 dirty:0 writeback:0 unstable:0
> [    7.102923]  free:253980 slab_reclaimable:83 slab_unreclaimable:846
> [    7.102923]  mapped:429 shmem:1815 pagetables:15 bounce:0
> [    7.102923]  free_cma:4032
> [    7.133995] DMA free:753344kB min:3472kB low:4340kB high:5208kB active_anon:292kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB managed:759188kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:332kB slab_unreclaimable:3384kB kernel_stack:256kB pagetables:36kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
> [    7.174080] lowmem_reserve[]: 0 0 264 264
> [    7.178175] HighMem free:262576kB min:264kB low:572kB high:884kB active_anon:2604kB inactive_anon:4756kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:270336kB managed:270336kB mlocked:0kB dirty:0kB writeback:0kB mapped:1716kB shmem:7260kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:24kB unstable:0kB bounce:0kB free_cma:16128kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
> [    7.218955] lowmem_reserve[]: 0 0 0 0
> [    7.222687] DMA: 8*4kB (UEM) 8*8kB (UM) 4*16kB (UEM) 5*32kB (UM) 2*64kB (M) 4*128kB (UEM) 3*256kB (M) 2*512kB (EM) 5*1024kB (UEM) 6*2048kB (UEM) 3*4096kB (EM) 88*8192kB (MR) = 753344kB
> [    7.239477] HighMem: 0*4kB 0*8kB 1*16kB (M) 1*32kB (M) 2*64kB (UM) 2*128kB (UM) 2*256kB (UC) 3*512kB (UMC) 2*1024kB (UC) 2*2048kB (UC) 2*4096kB (UC) 30*8192kB (MRC) = 262576kB
> [    7.255455] 1815 total pagecache pages
> [    7.259211] 0 pages in swap cache
> [    7.262533] Swap cache stats: add 0, delete 0, find 0/0
> [    7.267764] Free swap  = 0kB
> [    7.270647] Total swap = 0kB
> [    7.282890] 262144 pages of RAM
> [    7.286041] 254274 free pages
> [    7.289013] 4763 reserved pages
> [    7.292157] 929 slab pages
> [    7.294868] 1063 pages shared
> [    7.297839] 0 pages swap cached
> 
> And now we see 83 slab_reclaimable + 846 slab_unreclaimable adds up
> correctly to the total of 929.
> 
> The patch below will end up with the correct count.
> 

Sorry, messed up the patch formatting.  Here it is fixed:

8<===
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b02..8d606bb 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -117,7 +117,7 @@ void show_mem(unsigned int filter)
 			else if (PageSwapCache(page))
 				cached++;
 			else if (PageSlab(page))
-				slab++;
+				slab += 1 << compound_order(page);
 			else if (!page_count(page))
 				free++;
 			else

-- 
 Gregory V. Fong >< GPG key: 782EF5EE
