From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Fri, 16 Nov 2018 03:17:49 +0530
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
Message-ID: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86_64 kernel uses 'page_offset_base' variable to point to the
start of direct mapping of all physical memory. This variable
is also updated for KASLR boot cases, so this can be exported
via vmcoreinfo as a standard ABI between kernel and user-space,
to allow user-space utilities to use the same for calculating
the start of direct mapping of all physical memory.

'arch/x86/kernel/head64.c' sets the same as:
   unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;

and also uses the same to indicate the base of KASLR regions on x86_64:
   static __initdata struct kaslr_memory_region {
	    unsigned long *base;
	        unsigned long size_tb;
   } kaslr_regions[] = {
	    { &page_offset_base, 0 },
   .. snip ..

Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
live-debugging of a running kernel via user-space utilities
like makedumpfile (see [1]).

Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
details), whose live debugging feature is broken with newer kernels
(I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
added to kcore, thus leading to an additional sections in the same, and
makedumpfile is not longer able to determine the start of direct
mapping of all physical memory, as it relies on traversing the PT_LOAD
segments inside kcore and using the last PT_LOAD segment
to determine the start of direct mapping.

Such user-space issues can be resolved if the user-space code instead
uses a standard ABI to read the kernel exposed machine specific
variables. With the kernel commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"]), it is
now possible to use the vmcoreinfo present inside kcore as the standard
ABI which can be used by the user-space utilities for reading
the machine specific information (and hence for debugging a
live kernel).

User-space utilities like makedumpfile, kexec-tools and crash
are either already using this ABI or are discussing patches
which look to add the same feature. This helps in simplifying the
overall code and also in reducing code-rewrite across the
user-space utilities for getting values of these kernel
symbols/variables.

Accordingly this patch allows appending 'page_offset_base' for
x86_64 platforms to vmcoreinfo, so that user-space tools can use the
same as a standard interface to determine the start of direct mapping
of all physical memory.

Testing:
-------
 - I tested this patch (rebased on 'linux-next') on a x86_64 machine
   using the modified 'makedumpfile' user-space code (see [3] for my
   github tree which contains the same) for determining how many pages
   are dumpable when different dump_level is specified (which is
   one use-case of live-debugging via 'makedumpfile').
 - I tested both the KASLR and non-KASLR boot cases with this patch.
 - Here is one sample log (for KASLR boot case) on my x86_64 machine:

   < snip..>
   The kernel doesn't support mmap(),read() will be used instead.

   TYPE		PAGES			EXCLUDABLE	DESCRIPTION
   ----------------------------------------------------------------------
   ZERO		21299           	yes		Pages filled
   with zero
   NON_PRI_CACHE	91785           	yes		Cache
   pages without private flag
   PRI_CACHE	1               	yes		Cache pages with
   private flag
   USER		14057           	yes		User process
   pages
   FREE		740346          	yes		Free pages
   KERN_DATA	58152           	no		Dumpable kernel
   data

   page size:		4096
   Total pages on system:	925640
   Total size on system:	3791421440       Byte

[1]. MAN pages -> MAKEDUMPFILE(8) and CRASH(8)
[2]. makedumpfile issue with latest kernels -> http://lists.infradead.org/pipermail/kexec/2018-October/021769.html
[3]. https://github.com/bhupesh-sharma/makedumpfile/tree/add-page-offset-base-to-vmcore-v1

Cc: Boris Petkov <bp@alien8.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Dave Anderson <anderson@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: x86 at kernel.org
Cc: kexec at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - Fixed the build issue reported by build bot and tested this version
   with 'make allmodconfig'.
 - Reworded most of the commit log to explain the intent behind the
   patch.

 arch/x86/kernel/machine_kexec_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..6161d77c5bfb 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+#ifdef CONFIG_RANDOMIZE_BASE
+	VMCOREINFO_NUMBER(page_offset_base);
+#endif
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.7.4
