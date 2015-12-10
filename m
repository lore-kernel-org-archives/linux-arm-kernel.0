From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Dec 2015 14:47:08 -0800
Subject: next-20151210 build: 4 failures 43 warnings (next-20151210)
In-Reply-To: <20151210165513.GO5727@sirena.org.uk>
References: <E1a6wEp-0000hU-7o@optimist> <20151210165513.GO5727@sirena.org.uk>
Message-ID: <20151210144708.65b7111eb795ddabbfad1ed3@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Dec 2015 16:55:13 +0000 Mark Brown <broonie@kernel.org> wrote:

> Today's -next fails to build most arm64 configs with some rather
> spectacular errors below introduced by 02598e94ed5a78 (mm, printk:
> introduce new format string for flags) from Andrew's tree.  These in
> turn stem from the fact that we introduce an inclusion of
> linux/tracepoint.h into linux/mmdebug.h which through a chain of nested
> inclusions means that we end up attempting to use definitions from
> headers before they have finished including.

Thanks.

Further complexicating the include tree is something we don't need. 
I'll try moving the offending declarations into mm/internal.h, see how
that goes.

Including ../mm/internal.h into lib/vsprintf.c is a bit grubby, but I
guess it makes sense - vsprintf is poking about in mm internals, so it
gets to include mm's internal.h.

Vlastimil, the patch is rather bloaty - it adds 1.2k for something
which few people will use.  I wonder if it should be conditioned by
CONFIG_DEBUG_VM.



From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-printk-introduce-new-format-string-for-flags-fix-2

move declaration of trace_print_flags arrays into mm/internal.h

Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mmdebug.h |    6 ------
 lib/vsprintf.c          |    3 ++-
 mm/debug.c              |    2 ++
 mm/internal.h           |    7 +++++++
 4 files changed, 11 insertions(+), 7 deletions(-)

diff -puN include/linux/mmdebug.h~mm-printk-introduce-new-format-string-for-flags-fix-2 include/linux/mmdebug.h
--- a/include/linux/mmdebug.h~mm-printk-introduce-new-format-string-for-flags-fix-2
+++ a/include/linux/mmdebug.h
@@ -2,17 +2,11 @@
 #define LINUX_MM_DEBUG_H 1
 
 #include <linux/stringify.h>
-#include <linux/types.h>
-#include <linux/tracepoint.h>
 
 struct page;
 struct vm_area_struct;
 struct mm_struct;
 
-extern const struct trace_print_flags pageflag_names[];
-extern const struct trace_print_flags vmaflag_names[];
-extern const struct trace_print_flags gfpflag_names[];
-
 extern void dump_page(struct page *page, const char *reason);
 extern void dump_page_badflags(struct page *page, const char *reason,
 			       unsigned long badflags);
diff -puN lib/vsprintf.c~mm-printk-introduce-new-format-string-for-flags-fix-2 lib/vsprintf.c
--- a/lib/vsprintf.c~mm-printk-introduce-new-format-string-for-flags-fix-2
+++ a/lib/vsprintf.c
@@ -31,7 +31,8 @@
 #include <linux/dcache.h>
 #include <linux/cred.h>
 #include <net/addrconf.h>
-#include <linux/mmdebug.h>
+
+#include "../mm/internal.h"	/* For the trace_print_flags arrays */
 
 #include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/sections.h>	/* for dereference_function_descriptor() */
diff -puN mm/debug.c~mm-printk-introduce-new-format-string-for-flags-fix-2 mm/debug.c
--- a/mm/debug.c~mm-printk-introduce-new-format-string-for-flags-fix-2
+++ a/mm/debug.c
@@ -13,6 +13,8 @@
 #include <trace/events/gfpflags.h>
 #include <linux/page_owner.h>
 
+#include "internal.h"
+
 char *migrate_reason_names[MR_TYPES] = {
 	"compaction",
 	"memory_failure",
diff -puN mm/internal.h~mm-printk-introduce-new-format-string-for-flags-fix-2 mm/internal.h
--- a/mm/internal.h~mm-printk-introduce-new-format-string-for-flags-fix-2
+++ a/mm/internal.h
@@ -11,9 +11,11 @@
 #ifndef __MM_INTERNAL_H
 #define __MM_INTERNAL_H
 
+#include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/tracepoint.h>
 
 /*
  * The set of flags that only affect watermark checking and reclaim
@@ -441,4 +443,9 @@ static inline void try_to_unmap_flush_di
 }
 
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+
+extern const struct trace_print_flags pageflag_names[];
+extern const struct trace_print_flags vmaflag_names[];
+extern const struct trace_print_flags gfpflag_names[];
+
 #endif	/* __MM_INTERNAL_H */
_
