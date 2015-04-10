From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 9 Apr 2015 21:36:13 -0700
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <20150326123028.GM4701@suse.de>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk> <20150326123028.GM4701@suse.de>
Message-ID: <CADtm3G4Lb=u+BAHZF+O+RgB4VS9iW8epCPJ9ssBTj=+p3+h==Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 5:30 AM, Mel Gorman <mgorman@suse.de> wrote:
> On Thu, Mar 26, 2015 at 11:46:12AM +0000, Russell King - ARM Linux wrote:
>> <SNIP>
>>
>> Looking at Mel's commit, I don't see a reason why we couldn't use that
>> solution - it gets rid of walking the page array, which has been fraught
>> in the past due to ARM having platforms which have holes in their
>> physical memory.
>>
>> We could try that solution - I don't see much downside to it.  Most of
>> that information is as debug information for MM stuff anyway, and IMHO
>
> From an MM perspective, I can tell you that the information is close to
> useless for debugging anything. It's why I ditched it in that commit and
> AFAIK, no one has ever cared.
>
>> 8<===
>> From: Russell King <rmk+kernel@arm.linux.org.uk>
>> Subject: [PATCH] ARM: switch to use the generic show_mem() implementation
>>
>> Switch ARM to use the generic show_mem() implementation, which displays
>> the statistics from the mm zone rather than walking the page arrays.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> If this builds, boots and sysrq-m works as expected then for what it's worth
>
> Acked-by: Mel Gorman <mgorman <mgorman@suse.de>

Tried applying this change and the equivalent for 3.14.  Comparing
before/after on a brcmstb platform, all of the numbers still look
right when I run sysrq-m.

Tested-by: Gregory Fong <gregory.0xf0@gmail.com>

Before:

[   12.191615] SysRq : Show Memory
[   12.194789] Mem-info:
[   12.197069] DMA per-cpu:
[   12.199611] CPU    0: hi:  186, btch:  31 usd: 113
[   12.204409] HighMem per-cpu:
[   12.207295] CPU    0: hi:   90, btch:  15 usd:  44
[   12.212102] active_anon:734 inactive_anon:1189 isolated_anon:0
[   12.212102]  active_file:0 inactive_file:0 isolated_file:0
[   12.212102]  unevictable:0 dirty:0 writeback:0 unstable:0
[   12.212102]  free:254104 slab_reclaimable:82 slab_unreclaimable:843
[   12.212102]  mapped:429 shmem:1815 pagetables:13 bounce:0
[   12.212102]  free_cma:4032
[   12.243172] DMA free:754080kB min:3472kB low:4340kB high:5208kB
active_anon:180kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB
managed:759252kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
shmem:0kB slab_reclaimable:328kB slab_unreclaimable:3372kB
kernel_stack:240kB pagetables:12kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[   12.283257] lowmem_reserve[]: 0 0 264 264
[   12.287349] HighMem free:262336kB min:264kB low:572kB high:884kB
active_anon:2756kB inactive_anon:4756kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:270336kB managed:270336kB mlocked:0kB
dirty:0kB writeback:0kB mapped:1716kB shmem:7260kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:40kB unstable:0kB bounce:0kB free_cma:16128kB
writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[   12.328129] lowmem_reserve[]: 0 0 0 0
[   12.331859] DMA: 6*4kB (M) 11*8kB (UEM) 7*16kB (UEM) 6*32kB (UM)
4*64kB (UM) 6*128kB (UEM) 2*256kB (M) 3*512kB (UEM) 5*1024kB (UEM)
6*2048kB (UEM) 3*4096kB (EM) 88*8192kB (MR) = 754080kB
[   12.348817] HighMem: 2*4kB (UM) 1*8kB (M) 1*16kB (M) 1*32kB (M)
0*64kB 1*128kB (U) 2*256kB (UC) 3*512kB (UMC) 2*1024kB (UC) 2*2048kB
(UC) 2*4096kB (UC) 30*8192kB (MRC) = 262336kB
[   12.365058] 1815 total pagecache pages
[   12.368816] 0 pages in swap cache
[   12.372136] Swap cache stats: add 0, delete 0, find 0/0
[   12.377366] Free swap  = 0kB
[   12.380251] Total swap = 0kB
[   12.392342] 262144 pages of RAM
[   12.395494] 254306 free pages
[   12.398464] 4747 reserved pages
[   12.401609] 834 slab pages
[   12.404319] 1069 pages shared
[   12.407290] 0 pages swap cache

After:

[    3.743999] SysRq : Show Memory
[    3.747171] Mem-Info:
[    3.749451] DMA per-cpu:
[    3.751991] CPU    0: hi:  186, btch:  31 usd: 102
[    3.756790] HighMem per-cpu:
[    3.759678] CPU    0: hi:   90, btch:  15 usd:  27
[    3.764486] active_anon:724 inactive_anon:1189 isolated_anon:0
[    3.764486]  active_file:0 inactive_file:0 isolated_file:0
[    3.764486]  unevictable:0 dirty:0 writeback:0 unstable:0
[    3.764486]  free:254134 slab_reclaimable:81 slab_unreclaimable:842
[    3.764486]  mapped:429 shmem:1815 pagetables:13 bounce:0
[    3.764486]  free_cma:4032
[    3.795556] DMA free:754080kB min:3472kB low:4340kB high:5208kB
active_anon:208kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB
managed:759252kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
shmem:0kB slab_reclaimable:324kB slab_unreclaimable:3368kB
kernel_stack:240kB pagetables:36kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[    3.835641] lowmem_reserve[]: 0 0 264 264
[    3.839734] HighMem free:262456kB min:264kB low:572kB high:884kB
active_anon:2688kB inactive_anon:4756kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:270336kB managed:270336kB mlocked:0kB
dirty:0kB writeback:0kB mapped:1716kB shmem:7260kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:16kB unstable:0kB bounce:0kB free_cma:16128kB
writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[    3.880512] lowmem_reserve[]: 0 0 0 0
[    3.884244] DMA: 6*4kB (M) 11*8kB (UEM) 7*16kB (UEM) 6*32kB (UM)
4*64kB (UM) 6*128kB (UEM) 2*256kB (M) 3*512kB (UEM) 5*1024kB (UEM)
6*2048kB (UEM) 3*4096kB (EM) 88*8192kB (MR) = 754080kB
[    3.901199] HighMem: 0*4kB 1*8kB (M) 1*16kB (M) 1*32kB (M) 2*64kB
(UM) 1*128kB (U) 2*256kB (UC) 3*512kB (UMC) 2*1024kB (UC) 2*2048kB
(UC) 2*4096kB (UC) 30*8192kB (MRC) = 262456kB
[    3.917441] 1815 total pagecache pages
[    3.921198] 0 pages in swap cache
[    3.924518] Swap cache stats: add 0, delete 0, find 0/0
[    3.929748] Free swap  = 0kB
[    3.932632] Total swap = 0kB
[    3.935516] 262144 pages RAM
[    3.938401] 67584 pages HighMem/MovableOnly
[    3.942588] 651 pages reserved
[    3.945646] 4096 pages cma reserved
