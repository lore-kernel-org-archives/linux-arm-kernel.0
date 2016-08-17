From: james.morse@arm.com (James Morse)
Date: Wed, 17 Aug 2016 16:33:31 +0100
Subject: [PATCH] fixup! arm64: kdump: add kdump support
In-Reply-To: <57B2E759.201@arm.com>
Message-ID: <1471448011-20386-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

copy_oldmem_page() and mmap_vmcore() provide two ways for userspace to read
from /proc/vmcore. Neither of these check with memblock to see if the page
they are accessing is nomap. On Seattle this causes:

[  174.393875] Unhandled fault: synchronous external abort (0x96000210) at
0xffffff80096b6000
[  174.402158] Internal error: : 96000210 [#1] PREEMPT SMP
[  174.407370] Modules linked in:
[  174.410417] CPU: 6 PID: 2059 Comm: cp Tainted: G S      W I     4.8.0-rc1+ #4708
[  174.417799] Hardware name: AMD Overdrive/Supercharger/Default string, BIOS
ROD1002C 04/08/2016
[  174.426396] task: ffffffc0fdec5780 task.stack: ffffffc0f34bc000
[  174.432313] PC is at __arch_copy_to_user+0x180/0x280
[  174.437274] LR is at copy_oldmem_page+0xac/0xf0
[  174.441791] pc : [<ffffff800835e080>] lr : [<ffffff8008095b9c>] pstate: 20000145
[  174.449173] sp : ffffffc0f34bfc90
[  174.452474] x29: ffffffc0f34bfc90 x28: 0000000000000000
[  174.457776] x27: 0000000008000000 x26: 000000000000d000
[  174.463077] x25: 0000000000000001 x24: ffffff8008eb5000
[  174.468378] x23: 0000000000000000 x22: ffffff80096b6000
[  174.473679] x21: 0000000000000001 x20: 0000000030127000
[  174.478979] x19: 0000000000001000 x18: 0000007ff7085d60
[  174.484279] x17: 0000000000429358 x16: ffffff80081d9e88
[  174.489579] x15: 0000007fae377590 x14: 0000000000000000

[  174.494880] x13: 0000000000000000 x12: ffffff8008dd1000
[  174.500180] x11: ffffff80096b6fff x10: ffffff80096b6fff
[  174.505480] x9 : 0000000040000000 x8 : ffffff8008db6000
[  174.510781] x7 : ffffff80096b7000 x6 : 0000000030127000
[  174.516082] x5 : 0000000030128000 x4 : 0000000000000000
[  174.521382] x3 : 00e8000000000713 x2 : 0000000000000f80
[  174.526682] x1 : ffffff80096b6000 x0 : 0000000030127000
[  174.531982]
[  174.533461] Process cp (pid: 2059, stack limit = 0xffffffc0f34bc020)

[  174.848448] [<ffffff800835e080>] __arch_copy_to_user+0x180/0x280
[  174.854448] [<ffffff8008245f34>] read_from_oldmem.part.4+0xb4/0xf4
[  174.860615] [<ffffff8008246074>] read_vmcore+0x100/0x22c
[  174.865919] [<ffffff8008239378>] proc_reg_read+0x64/0x90
[  174.871223] [<ffffff80081d7da8>] __vfs_read+0x28/0x108
[  174.876348] [<ffffff80081d8ae4>] vfs_read+0x84/0x144
[  174.881301] [<ffffff80081d9ecc>] SyS_read+0x44/0xa0
[  174.886167] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
[  174.891466] Code: 00000000 00000000 00000000 00000000 (a8c12027)
[  174.897562] ---[ end trace 00801b2e35b0cd1f ]---

When reading /proc/vmcore with cat/cp or or mmap()ing it with makedumpfile.

The fs/proc/vmcore.c code provides a hook to indicate whether oldmem pages
are ram or not. Use this to look for our earlier handiwork in memblock.

Signed-off-by: James Morse <james.morse@arm.com>
---

Hi Pratyush,

I couldn't get makedumpfile to build, or rather it depends on elfutils which
wouldn't build for autotools reasons. Does implementing this hook solve your
makedumpfile issue?

With this patch I can extract a usable vmcore file using read or mmap,
avoiding the earlier splat.

Akashi, if you agree this is the right thing to do, please consider folding
this into patch 5. (no need to keep the commit mesage or anything).

Thanks,

James

 arch/arm64/kernel/crash_dump.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 2dc54d129be1..76c71ab42994 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -12,10 +12,38 @@
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/uaccess.h>
 #include <asm/memory.h>
 
+#ifdef CONFIG_PROC_VMCORE
+static int oldmem_pfn_is_ram(unsigned long pfn)
+{
+	unsigned long addr = pfn << PAGE_SHIFT;
+
+	/*
+	 * We removed oldmem from memblock.memory, then re-added some regions
+	 * which are reserved by/for firmware as memory and nomap.
+	 * If an address exists as memory, but is marked nomap, return false.
+	 */
+	if (memblock_is_memory(addr) && !memblock_is_map_memory(addr))
+		return 0;
+
+	return 1;
+}
+
+static int __init do_register_oldmem_pfn_is_ram(void)
+{
+	return register_oldmem_pfn_is_ram(&oldmem_pfn_is_ram);
+}
+/*
+ * vmcore_init() is called via fs_initcall, ensure we register
+ * oldmem_pfn_is_ram() before then.
+ */
+arch_initcall(do_register_oldmem_pfn_is_ram);
+#endif
+
 /**
  * copy_oldmem_page() - copy one page from old kernel memory
  * @pfn: page frame number to be copied
-- 
2.8.0.rc3
