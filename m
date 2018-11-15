From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:43 +0900
Subject: [PATCH v16 04/16] powerpc,
 kexec_file: factor out memblock-based arch_kexec_walk_mem()
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memblock list is another source for usable system memory layout.
So move powerpc's arch_kexec_walk_mem() to common code so that other
memblock-based architectures, particularly arm64, can also utilise it.
A moved function is now renamed to kexec_walk_memblock() and integrated
into kexec_locate_mem_hole(), which will now be usable for all
architectures with no need for overriding arch_kexec_walk_mem().

With this change, arch_kexec_walk_mem() need no longer be a weak function,
and was now renamed to kexec_walk_resources().

Since powerpc doesn't support kdump in its kexec_file_load(), the current
kexec_walk_memblock() won't work for kdump either in this form, this will
be fixed in the next patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 54 ------------------
 include/linux/kexec.h                       |  2 -
 kernel/kexec_file.c                         | 61 +++++++++++++++++++--
 3 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index c77e95e9b384..0d20c7ad40fa 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -24,7 +24,6 @@
 
 #include <linux/slab.h>
 #include <linux/kexec.h>
-#include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <asm/ima.h>
@@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
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
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f378cb786f1b..d58d1f2fab10 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -192,8 +192,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
 					const Elf_Shdr *relsec,
 					const Elf_Shdr *symtab);
 
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9e6529da12ed..d03195a8cb6e 100644
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
@@ -499,8 +500,57 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#ifdef CONFIG_ARCH_DISCARD_MEMBLOCK
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	return 0;
+}
+#else
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+	u64 i;
+	phys_addr_t mstart, mend;
+	struct resource res = { };
+
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+						&mstart, &mend, NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
+					NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
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
+#endif
+
 /**
- * arch_kexec_walk_mem - call func(data) on free memory regions
+ * kexec_walk_resources - call func(data) on free memory regions
  * @kbuf:	Context info for the search. Also passed to @func.
  * @func:	Function to call for each memory region.
  *
@@ -508,8 +558,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
  * and that value will be returned. If all free regions are visited without
  * func returning non-zero, then zero will be returned.
  */
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *))
+static int kexec_walk_resources(struct kexec_buf *kbuf,
+				int (*func)(struct resource *, void *))
 {
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
@@ -536,7 +586,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+	if (IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
+	else
+		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.19.0
