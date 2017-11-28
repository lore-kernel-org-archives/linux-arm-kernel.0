From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Nov 2017 15:24:06 +0000
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
Message-ID: <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 02:13:55PM +0000, Mark Rutland wrote:
> On Tue, Nov 28, 2017 at 01:57:49PM +0100, Dmitry Vyukov wrote:
> > On Tue, Nov 28, 2017 at 1:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > As a heads-up, I'm seeing a number of what appear to be false-positive
> > > use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
> > > when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
> > > without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
> > >
> > > The reports vary depending on configuration even with the same trigger. I'm not
> > > sure if it's the reporting that's misleading, or whether the detection is going
> > > wrong.

> ... it looks suspiciously like something is setting up non-zero shadow
> bytes, but not zeroing them upon return.

It looks like this is the case.

The hack below detects leftover poison on an exception return *before*
the false-positive warning (example splat at the end of the email). With
scripts/Makefile.kasan hacked to not pass
-fsanitize-address-use-after-scope, I see no leftover poison.

Unfortunately, there's not enough information left to say where exactly
that happened.

Given the report that Andrey linked to [1], it looks like the compiler
is doing something wrong, and failing to clear some poison in some
cases. Dennis noted [2] that this appears to be the case where inline
functions are called in a loop.

It sounds like this is a general GCC 7.x problem, on both x86_64 and
arm64. As we don't have a smoking gun, it's still possible that
something else is corrupting the shadow, but it seems unlikely.

[1] https://lkml.kernel.org/r/20171128124534.3jvuala525wvn64r at wfg-t540p.sh.intel.com
[2] https://lkml.kernel.org/r/20171127210301.GA55812 at localhost.corp.microsoft.com

Thanks,
Mark.

Hack
--------
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6d14b8f29b5f..8191e122d6f4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -220,6 +220,8 @@ alternative_else_nop_endif
        .endm
 
        .macro  kernel_exit, el
+       mov     x0, sp
+       bl      kasan_assert_task_stack_is_clean_below
        .if     \el != 0
        disable_daif
 
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 405bba487df5..dab8a51ee52f 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -37,6 +37,8 @@
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
 
+#include <asm/stacktrace.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -241,6 +243,33 @@ static __always_inline bool memory_is_poisoned(unsigned long addr, size_t size)
        return memory_is_poisoned_n(addr, size);
 }
 
+/*
+ * In some contexts (e.g. when returning from an exception), all shadow beyond
+ * a certain point on the stack should be clear. This helper can be called by
+ * assembly code to verify this is the case.
+ */
+asmlinkage void kasan_assert_task_stack_is_clean_below(unsigned long watermark)
+{
+       unsigned long base;
+
+       /*
+        * This is an arm64-specific hack. This should be fixed properly to
+        * discover and check the bounds of the current stack in an
+        * arch-agnostic manner.
+        */
+       if (!on_task_stack(current, watermark))
+               return;
+
+       /*
+        * Calculate the task stack base address.  Avoid using 'current'
+        * because this function is called by early resume code which hasn't
+        * yet set up the percpu register (%gs).
+        */
+       base = watermark & ~(THREAD_SIZE - 1);
+
+       WARN_ON_ONCE(memory_is_poisoned(base, watermark - base));
+}
+
 static __always_inline void check_memory_region_inline(unsigned long addr,
                                                size_t size, bool write,
                                                unsigned long ret_ip)
--------

Splat
--------
[  186.951300] WARNING: CPU: 1 PID: 2429 at mm/kasan/kasan.c:270 kasan_assert_task_stack_is_clean_below+0x144/0x150
[  186.961418] Modules linked in:
[  186.964468] CPU: 1 PID: 2429 Comm: perf Not tainted 4.15.0-rc1-00001-g7780802c256e #6
[  186.972249] Hardware name: ARM Juno development board (r1) (DT)
[  186.978133] task: ffff800933fe6900 task.stack: ffff80092c990000
[  186.984019] pstate: 200003c5 (nzCv DAIF -PAN -UAO)
[  186.988789] pc : kasan_assert_task_stack_is_clean_below+0x144/0x150
[  186.995022] lr : ret_fast_syscall+0x34/0x98
[  186.999177] sp : ffff80092c997ec0
[  187.002472] x29: ffff80092c997ff0 x28: ffff800933fe6900 
[  187.007760] x27: ffff200009264000 x26: 00000000000000f1 
[  187.013047] x25: 0000000000000124 x24: 0000000000000015 
[  187.018334] x23: 0000000060000000 x22: 0000ffffae4b7554 
[  187.023621] x21: 00000000ffffffff x20: 000060092de30000 
[  187.028908] x19: 0000000000000000 x18: 0000ffffd2ec5330 
[  187.034195] x17: 0000ffffae4b7530 x16: ffff200008270508 
[  187.039482] x15: 0000ffffae538588 x14: 0000000000000000 
[  187.044769] x13: ffffffffffffffff x12: ffffffffffffffff 
[  187.050060] x11: 1ffff00125932f33 x10: ffff100125932f33 
[  187.055349] x9 : dfff200000000000 x8 : dfff200000000008 
[  187.060638] x7 : 1ffff00125932fd7 x6 : ffff100125932fd7 
[  187.065927] x5 : ffff80092c997ebf x4 : ffff100125932fd8 
[  187.071217] x3 : dfff200000000000 x2 : ffff100125932e30 
[  187.076506] x1 : ffff100125932e28 x0 : 00000000000000f8 
[  187.081793] Call trace:
[  187.084238]  kasan_assert_task_stack_is_clean_below+0x144/0x150
[  187.090122] ---[ end trace 9c3a99d1de859687 ]---
[  187.212571] ==================================================================
[  187.219786] BUG: KASAN: use-after-scope in __save_stack_trace+0x1c8/0x2f0
[  187.226537] Read of size 4 at addr ffff800930e4f048 by task true/2432
[  187.232935] 
[  187.234430] CPU: 2 PID: 2432 Comm: true Tainted: G        W        4.15.0-rc1-00001-g7780802c256e #6
[  187.243507] Hardware name: ARM Juno development board (r1) (DT)
[  187.249389] Call trace:
[  187.251830]  dump_backtrace+0x0/0x320
[  187.255477]  show_stack+0x20/0x30
[  187.258782]  dump_stack+0x108/0x174
[  187.262256]  print_address_description+0x60/0x270
[  187.266936]  kasan_report+0x210/0x2f0
[  187.270584]  __asan_load4+0x84/0xa8
[  187.274059]  __save_stack_trace+0x1c8/0x2f0
[  187.278224]  save_stack_trace+0x24/0x30
[  187.282044]  kasan_kmalloc+0xd0/0x180
[  187.285688]  kasan_slab_alloc+0x14/0x20
[  187.289508]  kmem_cache_alloc+0x128/0x1e8
[  187.293499]  perf_event_mmap+0x2dc/0x968
[  187.297405]  mmap_region+0x24c/0xa60
[  187.300963]  do_mmap+0x404/0x640
[  187.304178]  vm_mmap_pgoff+0x15c/0x190
[  187.307909]  vm_mmap+0x70/0xb0
[  187.310951]  elf_map+0x114/0x150
[  187.314165]  load_elf_binary+0x728/0x1b84
[  187.318158]  search_binary_handler+0xe4/0x3b8
[  187.322495]  do_execveat_common.isra.12+0xaa4/0xc60
[  187.327349]  SyS_execve+0x48/0x60
[  187.330650]  el0_svc_naked+0x20/0x24
[  187.334202] 
[  187.335685] The buggy address belongs to the page:
[  187.340453] page:ffff7e0024c393c0 count:0 mapcount:0 mapping:          (null) index:0x0
[  187.348414] flags: 0x1fffc00000000000()
[  187.352240] raw: 1fffc00000000000 0000000000000000 0000000000000000 00000000ffffffff
[  187.359947] raw: 0000000000000000 ffff7e0024c393e0 0000000000000000 0000000000000000
[  187.367643] page dumped because: kasan: bad access detected
[  187.373178] 
[  187.374661] Memory state around the buggy address:
[  187.379428]  ffff800930e4ef00: f1 f1 f8 f2 f2 f2 f2 f2 f2 f2 00 00 f2 f2 f2 f2
[  187.386612]  ffff800930e4ef80: f2 f2 00 00 f2 f2 f3 f3 f3 f3 f8 f8 f8 f8 f8 f8
[  187.393795] >ffff800930e4f000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 00 00 00 00 00 00
[  187.400973]                                               ^
[  187.406516]  ffff800930e4f080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  187.413699]  ffff800930e4f100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  187.420877] ==================================================================
--------
