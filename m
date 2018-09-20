From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 20 Sep 2018 16:56:31 +0300
Subject: [PATCH v2 3/3] lib/test_kasan: Add tests for several string/memory
 API functions
In-Reply-To: <20180920135631.23833-1-aryabinin@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
Message-ID: <20180920135631.23833-3-aryabinin@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arch code may have asm implementation of string/memory API functions
instead of using generic one from lib/string.c. KASAN don't see
memory accesses in asm code, thus can miss many bugs.

E.g. on ARM64 KASAN don't see bugs in memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). Add tests for these functions to be sure
that we notice the problem on other architectures.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---

 No changes since v1.

 lib/test_kasan.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ec657105edbf..51b78405bf24 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -579,6 +579,73 @@ static noinline void __init kmem_cache_invalid_free(void)
 	kmem_cache_destroy(cache);
 }
 
+static noinline void __init kasan_memchr(void)
+{
+	char *ptr;
+	size_t size = 24;
+
+	pr_info("out-of-bounds in memchr\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	memchr(ptr, '1', size + 1);
+	kfree(ptr);
+}
+
+static noinline void __init kasan_memcmp(void)
+{
+	char *ptr;
+	size_t size = 24;
+	int arr[9];
+
+	pr_info("out-of-bounds in memcmp\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	memset(arr, 0, sizeof(arr));
+	memcmp(ptr, arr, size+1);
+	kfree(ptr);
+}
+
+static noinline void __init kasan_strings(void)
+{
+	char *ptr;
+	size_t size = 24;
+
+	pr_info("use-after-free in strchr\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	kfree(ptr);
+
+	/*
+	 * Try to cause only 1 invalid access (less spam in dmesg).
+	 * For that we need ptr to point to zeroed byte.
+	 * Skip metadata that could be stored in freed object so ptr
+	 * will likely point to zeroed byte.
+	 */
+	ptr += 16;
+	strchr(ptr, '1');
+
+	pr_info("use-after-free in strrchr\n");
+	strrchr(ptr, '1');
+
+	pr_info("use-after-free in strcmp\n");
+	strcmp(ptr, "2");
+
+	pr_info("use-after-free in strncmp\n");
+	strncmp(ptr, "2", 1);
+
+	pr_info("use-after-free in strlen\n");
+	strlen(ptr);
+
+	pr_info("use-after-free in strnlen\n");
+	strnlen(ptr, 1);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -618,6 +685,9 @@ static int __init kmalloc_tests_init(void)
 	use_after_scope_test();
 	kmem_cache_double_free();
 	kmem_cache_invalid_free();
+	kasan_memchr();
+	kasan_memcmp();
+	kasan_strings();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.16.4
