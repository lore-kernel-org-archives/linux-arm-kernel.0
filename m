From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Sat, 23 Jun 2018 11:20:47 +0900
Subject: [PATCH v10 03/14] powerpc,
 kexec_file: factor out memblock-based arch_kexec_walk_mem()
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Message-ID: <20180623022058.10935-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memblock list is another source for usable system memory layout.
A merged new arch_kexec_walk_mem() will walk through either io resource
list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
arm64, in addition to powerpc, will be able to utilize this generic
function for kexec_file.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 53 ---------------------
 kernel/kexec_file.c                         | 52 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 0bd23dc789a4..3d4be91786ce 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -46,59 +46,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-/**
- * arch_kexec_walk_mem - call func(data) for each unreserved memory block
- * @kbuf:	Context info for the search. Also passed to @func.
- * @func:	Function to call for each memory block.
- *
- * This function is used by kexec_add_buffer and kexec_locate_mem_hole
- * to find unreserved memory to load kexec segments into.
- *
- * Return: The memory walk will stop when func returns a non-zero value
- * and that value will be returned. If all free regions are visited without
- * func returning non-zero, then zero will be returned.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	int ret = 0;
-	u64 i;
-	phys_addr_t mstart, mend;
-	struct resource res = { };
-
-	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
-						&mstart, &mend, NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	}
-
-	return ret;
-}
-
 /**
  * setup_purgatory - initialize the purgatory's global variables
  * @image:		kexec image.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..563acd1c9a61 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	u64 i;
+	phys_addr_t mstart, mend;
+	struct resource res = { };
+	int ret = 0;
+
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
+	/*
+	 * In memblock, end points to the first byte after the
+	 * range while in kexec, end points to the last byte
+	 * in the range.
+	 */
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+					&mstart, &mend, NULL) {
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0,
+					&mstart, &mend, NULL) {
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+#else
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	return 0;
+}
+#endif
+
 /**
  * arch_kexec_walk_mem - call func(data) on free memory regions
  * @kbuf:	Context info for the search. Also passed to @func.
@@ -513,6 +561,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(struct resource *, void *))
 {
+	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
+			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		return kexec_walk_memblock(kbuf, func);
+
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-- 
2.17.0
