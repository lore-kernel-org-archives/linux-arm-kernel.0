From: anders.berg@lsi.com (Anders Berg)
Date: Mon, 24 Mar 2014 22:02:12 +0100
Subject: [PATCH RFC] ARM: mm: Fix for highmem on machines with more than 14
 cores
In-Reply-To: <cover.1395692531.git.anders.berg@lsi.com>
References: <cover.1395692531.git.anders.berg@lsi.com>
Message-ID: <52661057074abf5bfe6174cb561bec5eea8892fb.1395692531.git.anders.berg@lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixmap area was hard coded to 224 pages which was only enough for 14 CPU:s.
Now the area adapts to the configured number of CPU:s (NR_CPUS). We still have
a hard limit of 30 CPU:s since we only have a single pte-chunk (512 pte:s).

Signed-off-by: Anders Berg <anders.berg@lsi.com>
Signed-off-by: Fredrik Markstr?m <fredrik.markstrom@gmail.com>
---
 arch/arm/include/asm/fixmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index bbae919..40f1f05 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -7,15 +7,15 @@
  * On ARM we already have well known fixed virtual addresses imposed by
  * the architecture such as the vector page which is located at 0xffff0000,
  * therefore a second level page table is already allocated covering
- * 0xfff00000 upwards.
+ * 0xffe00000 upwards.
  *
  * The cache flushing code in proc-xscale.S uses the virtual area between
  * 0xfffe0000 and 0xfffeffff.
  */
 
-#define FIXADDR_START		0xfff00000UL
+#define FIXADDR_SIZE		((KM_TYPE_NR * NR_CPUS) << PAGE_SHIFT)
 #define FIXADDR_TOP		0xfffe0000UL
-#define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
 
 #define FIX_KMAP_BEGIN		0
 #define FIX_KMAP_END		(FIXADDR_SIZE >> PAGE_SHIFT)
-- 
1.8.3.2
