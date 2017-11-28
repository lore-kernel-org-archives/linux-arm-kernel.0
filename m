From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 28 Nov 2017 16:00:49 +0300
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
Message-ID: <747765dd-b156-9388-6471-bb0f9a256a89@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/28/2017 03:35 PM, Mark Rutland wrote:
> Hi,
> 
> As a heads-up, I'm seeing a number of what appear to be false-positive
> use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
> when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
> without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
> 
> The reports vary depending on configuration even with the same trigger. I'm not
> sure if it's the reporting that's misleading, or whether the detection is going
> wrong.
> 
> For example, with v4.15-rc1, defconfig + KCOV + KASAN_OUTLINE, I can trigger a
> splat:
> 
> $ perf record true
> 
> [   37.577497] ==================================================================
> [   37.584702] BUG: KASAN: use-after-scope in __alloc_pages_nodemask+0x104/0x1608
> [   37.591883] Write of size 24 at addr ffff80092d65f160 by task perf/2430
> [   37.598452] 
> [   37.599944] CPU: 1 PID: 2430 Comm: perf Not tainted 4.15.0-rc1-00001-gaf82bf81ebae #1
> [   37.607725] Hardware name: ARM Juno development board (r1) (DT)
> [   37.613605] Call trace:
> [   37.616051]  dump_backtrace+0x0/0x320
> [   37.619700]  show_stack+0x20/0x30
> [   37.623005]  dump_stack+0x108/0x174
> [   37.626481]  print_address_description+0x60/0x270
> [   37.631162]  kasan_report+0x210/0x2f0
> [   37.634811]  check_memory_region+0x148/0x198
> [   37.639063]  __asan_storeN+0x14/0x20
> [   37.642624]  __alloc_pages_nodemask+0x104/0x1608
> [   37.647221]  alloc_pages_vma+0xa0/0x2d8
> [   37.651042]  wp_page_copy+0x15c/0xee0
> [   37.654689]  do_wp_page+0x404/0xa70
> [   37.658165]  __handle_mm_fault+0xb28/0x13e0
> [   37.662331]  handle_mm_fault+0x290/0x390
> [   37.666237]  do_page_fault+0x32c/0x5c0
> [   37.669969]  do_mem_abort+0xa8/0x1e0
> [   37.673528]  el0_da+0x20/0x24
> [   37.676477] 
> [   37.677961] The buggy address belongs to the page:
> [   37.682730] page:ffff7e0024b597c0 count:0 mapcount:0 mapping:          (null) index:0x0
> [   37.690692] flags: 0x1fffc00000000000()
> [   37.694518] raw: 1fffc00000000000 0000000000000000 0000000000000000 00000000ffffffff
> [   37.702225] raw: 0000000000000000 ffff7e0024b597e0 0000000000000000 0000000000000000
> [   37.709922] page dumped because: kasan: bad access detected
> [   37.715457] 
> [   37.716941] Memory state around the buggy address:
> [   37.721709]  ffff80092d65f000: f2 f2 04 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
> [   37.728893]  ffff80092d65f080: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
> [   37.736078] >ffff80092d65f100: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f8 f8 f8 00 f2
> [   37.743257]                                                        ^
> [   37.749576]  ffff80092d65f180: f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 f2 f3 f3
> [   37.756761]  ffff80092d65f200: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   37.763939] ==================================================================
> [   37.771117] Disabling lock debugging due to kernel taint
> 
> $ ./scripts/faddr2line vmlinux __alloc_pages_nodemask+0x104/0x1608
> __alloc_pages_nodemask+0x104/0x1608:
> __alloc_pages_nodemask at mm/page_alloc.c:4215
> 
> ... which is the declaration+initialisation of a local variable in
> __alloc_pages_nodemask:
> 
> 4208 struct page *
> 4209 __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> 4210                                                         nodemask_t *nodemask)
> 4211 {
> 4212         struct page *page;
> 4213         unsigned int alloc_flags = ALLOC_WMARK_LOW;
> 4214         gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> 4215         struct alloc_context ac = { };
> 
> ... which is clearly not a use-after-scope bug.
> 
> If I separate the declaration and assignment, I get a splat corresponding to the
> assignment to ac.
> 
> I wondered if we were missing some shadow initialisation, so I hacked a call to
> kasan_unpoison_task_stack() into dup_task_struct(), but this had no effect. I
> also wondered if this was the result of an overflow caused by instrumentation
> bloating the stack, but doubling my stack size (from 32K to 64K) also had no
> effect.
> 
> Any ideas? I'm a bit confused by this.


Search in lkml gave me this: http://lkml.kernel.org/r/<20171128124534.3jvuala525wvn64r@wfg-t540p.sh.intel.com>

Do you have  GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y ?

Note, that in  Fengguang's config, CONFIG_KCOV=y but CONFIG_KCOV_INSTRUMENT_ALL=n,  so at least in his case
KCOV shouldn't be involved.


> Thanks,
> Mark.
> 
