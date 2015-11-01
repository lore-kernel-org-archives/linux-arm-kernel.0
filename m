From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun,  1 Nov 2015 07:46:16 +0000
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu area
 setup
In-Reply-To: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no room to adjust 'atom_size' now when a generic percpu area
is used. It would be redundant to write down an architecture-specific
setup_per_cpu_areas() in order to only change the 'atom_size'. Thus,
this patch adds a new definition, PERCPU_ATOM_SIZE, which is PAGE_SIZE
by default. The value could be updated if needed by architecture.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 include/linux/percpu.h | 4 ++++
 mm/percpu.c            | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 4bc6daf..57a2f16 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -18,6 +18,10 @@
 #define PERCPU_MODULE_RESERVE		0
 #endif
 
+#ifndef PERCPU_ATOM_SIZE
+#define PERCPU_ATOM_SIZE		PAGE_SIZE
+#endif
+
 /* minimum unit size, also is the maximum supported allocation size */
 #define PCPU_MIN_UNIT_SIZE		PFN_ALIGN(32 << 10)
 
diff --git a/mm/percpu.c b/mm/percpu.c
index a63b4d8..cd1e0ec 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2201,8 +2201,8 @@ void __init setup_per_cpu_areas(void)
 	 * what the legacy allocator did.
 	 */
 	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE, NULL,
-				    pcpu_dfl_fc_alloc, pcpu_dfl_fc_free);
+				    PERCPU_DYNAMIC_RESERVE, PERCPU_ATOM_SIZE,
+				    NULL, pcpu_dfl_fc_alloc, pcpu_dfl_fc_free);
 	if (rc < 0)
 		panic("Failed to initialize percpu areas.");
 
@@ -2231,7 +2231,7 @@ void __init setup_per_cpu_areas(void)
 
 	ai = pcpu_alloc_alloc_info(1, 1);
 	fc = memblock_virt_alloc_from_nopanic(unit_size,
-					      PAGE_SIZE,
+					      PERCPU_ATOM_SIZE,
 					      __pa(MAX_DMA_ADDRESS));
 	if (!ai || !fc)
 		panic("Failed to allocate memory for percpu areas.");
-- 
2.5.0
