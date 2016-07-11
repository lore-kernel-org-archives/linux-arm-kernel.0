From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Jul 2016 21:00:45 +0200
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access ESRT
 table in memory
In-Reply-To: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1468263646-28184-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM and arm64, ioremap() and memremap() are not interchangeable like
on x86, and the use of ioremap() on ordinary RAM is typically flagged
as an error if the memory region being mapped is also covered by the
linear mapping, since that would lead to aliases with conflicting
cacheability attributes.

Since what we are dealing with is not an I/O region with side effects,
using ioremap() here is arguably incorrect anyway, so let's replace
it with memremap() instead.

Acked-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/esrt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index b93cd11f9bcc..14914074f716 100644
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
@@ -387,9 +388,9 @@ static int __init esrt_sysfs_init(void)
 	if (!esrt_data || !esrt_data_size)
 		return -ENOSYS;
 
-	esrt = ioremap(esrt_data, esrt_data_size);
+	esrt = memremap(esrt_data, esrt_data_size, MEMREMAP_WB);
 	if (!esrt) {
-		pr_err("ioremap(%pa, %zu) failed.\n", &esrt_data,
+		pr_err("memremap(%pa, %zu) failed.\n", &esrt_data,
 		       esrt_data_size);
 		return -ENOMEM;
 	}
-- 
1.9.1
