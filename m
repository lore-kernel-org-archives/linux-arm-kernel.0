From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 10 Oct 2017 15:36:11 +0900
Subject: [PATCH v5 02/10] resource: add walk_system_ram_res_rev()
In-Reply-To: <20171010063619.6303-1-takahiro.akashi@linaro.org>
References: <20171010063619.6303-1-takahiro.akashi@linaro.org>
Message-ID: <20171010063619.6303-3-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file implementation on arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f5cf32e80041..62eb62b98118 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -273,6 +273,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(u64, u64, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(u64, u64, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(u64, u64, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f04404152..69c31454cb2e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -469,6 +471,61 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 	return ret;
 }
 
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(u64, u64, void *))
+{
+	struct resource res, *rams;
+	int rams_size = 16, i;
+	int ret = -1;
+
+	/* create a list */
+	rams = vmalloc(sizeof(struct resource) * rams_size);
+	if (!rams)
+		return ret;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	i = 0;
+	while ((res.start < res.end) &&
+		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
+		if (i >= rams_size) {
+			/* re-alloc */
+			struct resource *rams_new;
+			int rams_new_size;
+
+			rams_new_size = rams_size + 16;
+			rams_new = vmalloc(sizeof(struct resource)
+							* rams_new_size);
+			if (!rams_new)
+				goto out;
+
+			memcpy(rams_new, rams,
+					sizeof(struct resource) * rams_size);
+			vfree(rams);
+			rams = rams_new;
+			rams_size = rams_new_size;
+		}
+
+		rams[i].start = res.start;
+		rams[i++].end = res.end;
+
+		res.start = res.end + 1;
+		res.end = end;
+	}
+
+	/* go reverse */
+	for (i--; i >= 0; i--) {
+		ret = (*func)(rams[i].start, rams[i].end, arg);
+		if (ret)
+			break;
+	}
+
+out:
+	vfree(rams);
+	return ret;
+}
+
 #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
 
 /*
-- 
2.14.1
