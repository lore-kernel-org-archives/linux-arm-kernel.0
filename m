From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 12:32:32 +0100
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access ESRT
 table in memory
In-Reply-To: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455535953-5056-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM and arm64, ioremap() and memremap() are not interchangeable like
on x86, and the use of ioremap() on ordinary RAM is typically flagged
as an error if the memory region being mapped is also covered by the
linear mapping, since that would lead to aliases with conflicting
cacheability attributes.

Since what we are dealing with is not an I/O region with side effects,
using ioremap() here is arguably incorrect anyway, so let's replace
it with memremap instead. Also add a missing unmap on the success path,
and drop a memblock_remove() call which does not belong here, this far
into the boot sequence.

Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/esrt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 22c5285f7705..f096a0a26dbd 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
@@ -385,15 +386,15 @@ static void cleanup_entry_list(void)
 static int __init esrt_sysfs_init(void)
 {
 	int error;
-	struct efi_system_resource_table __iomem *ioesrt;
+	struct efi_system_resource_table *memesrt;
 
 	pr_debug("esrt-sysfs: loading.\n");
 	if (!esrt_data || !esrt_data_size)
 		return -ENOSYS;
 
-	ioesrt = ioremap(esrt_data, esrt_data_size);
-	if (!ioesrt) {
-		pr_err("ioremap(%pa, %zu) failed.\n", &esrt_data,
+	memesrt = memremap(esrt_data, esrt_data_size, MEMREMAP_WB);
+	if (!memesrt) {
+		pr_err("memremap(%pa, %zu, MEMREMAP_WB) failed.\n", &esrt_data,
 		       esrt_data_size);
 		return -ENOMEM;
 	}
@@ -401,11 +402,12 @@ static int __init esrt_sysfs_init(void)
 	esrt = kmalloc(esrt_data_size, GFP_KERNEL);
 	if (!esrt) {
 		pr_err("kmalloc failed. (wanted %zu bytes)\n", esrt_data_size);
-		iounmap(ioesrt);
+		memunmap(memesrt);
 		return -ENOMEM;
 	}
 
-	memcpy_fromio(esrt, ioesrt, esrt_data_size);
+	memcpy(esrt, memesrt, esrt_data_size);
+	memunmap(memesrt);
 
 	esrt_kobj = kobject_create_and_add("esrt", efi_kobj);
 	if (!esrt_kobj) {
@@ -432,8 +434,6 @@ static int __init esrt_sysfs_init(void)
 	if (error)
 		goto err_cleanup_list;
 
-	memblock_remove(esrt_data, esrt_data_size);
-
 	pr_debug("esrt-sysfs: loaded.\n");
 
 	return 0;
-- 
2.5.0
