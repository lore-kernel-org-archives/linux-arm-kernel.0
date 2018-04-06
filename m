From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Fri,  6 Apr 2018 16:39:38 +0200
Subject: [PATCH v5 2/3] ARM: ftrace/recordmcount: filter relocation types
In-Reply-To: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
References: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
Message-ID: <20180406143939.14642-3-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If code in arch/arm/kernel/ftrace.c would operate on mcount() pointer the
following may be generated:

00000230 <prealloc_fixed_plts>:
 230:   b5f8            push    {r3, r4, r5, r6, r7, lr}
 232:   b500            push    {lr}
 234:   f7ff fffe       bl      0 <__gnu_mcount_nc>
                        234: R_ARM_THM_CALL     __gnu_mcount_nc
 238:   f240 0600       movw    r6, #0
                        238: R_ARM_THM_MOVW_ABS_NC      __gnu_mcount_nc
 23c:   f8d0 1180       ldr.w   r1, [r0, #384]  ; 0x180

FTRACE currently is not able to deal with it:

WARNING: CPU: 0 PID: 0 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1ad/0x230()
...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.116-... #1
...
[<c0314e3d>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c051a7f1>] (dump_stack+0x81/0xa8)
[<c051a7f1>] (dump_stack) from [<c0321c5d>] (warn_slowpath_common+0x69/0x90)
[<c0321c5d>] (warn_slowpath_common) from [<c0321cf3>] (warn_slowpath_null+0x17/0x1c)
[<c0321cf3>] (warn_slowpath_null) from [<c038ee9d>] (ftrace_bug+0x1ad/0x230)
[<c038ee9d>] (ftrace_bug) from [<c038f1f9>] (ftrace_process_locs+0x27d/0x444)
[<c038f1f9>] (ftrace_process_locs) from [<c08915bd>] (ftrace_init+0x91/0xe8)
[<c08915bd>] (ftrace_init) from [<c0885a67>] (start_kernel+0x34b/0x358)
[<c0885a67>] (start_kernel) from [<00308095>] (0x308095)
---[ end trace cb88537fdc8fa200 ]---
ftrace failed to modify [<c031266c>] prealloc_fixed_plts+0x8/0x60
 actual: 44:f2:e1:36
ftrace record flags: 0
 (0)   expected tramp: c03143e9

Fix this by allowing only selected reloc types in __mcount_loc.
The list itself comes from the legacy recordmcount.pl script.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 scripts/recordmcount.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 16e086d..a4888e9 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -53,6 +53,10 @@
 #define R_AARCH64_ABS64	257
 #endif
 
+#define R_ARM_PC24		1
+#define R_ARM_THM_CALL		10
+#define R_ARM_CALL		28
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
@@ -428,6 +432,18 @@ is_mcounted_section_name(char const *const txtname)
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
 
+static int arm_is_fake_mcount(Elf32_Rel const *rp)
+{
+	switch (ELF32_R_TYPE(w(rp->r_info))) {
+	case R_ARM_THM_CALL:
+	case R_ARM_CALL:
+	case R_ARM_PC24:
+		return 0;
+	}
+
+	return 1;
+}
+
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
  * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
  * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
@@ -529,6 +545,7 @@ do_file(char const *const fname)
 			 altmcount = "__gnu_mcount_nc";
 			 make_nop = make_nop_arm;
 			 rel_type_nop = R_ARM_NONE;
+			 is_fake_mcount32 = arm_is_fake_mcount;
 			 break;
 	case EM_AARCH64:
 			reltype = R_AARCH64_ABS64;
-- 
2.4.6
