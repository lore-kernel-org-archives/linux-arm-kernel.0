From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  1 Apr 2016 18:05:34 +0200
Subject: [PATCH v3 8/9] efi/arm*: wire up struct screen_info to
 efi-framebuffer platform device
In-Reply-To: <1459526735-24936-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459526735-24936-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459526735-24936-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds code to the ARM and arm64 EFI init routines to expose a platform
device of type 'efi-framebuffer' if struct screen_info has been populated
appropriately from the GOP protocol by the stub. Since the framebuffer may
potentially be located in system RAM, make sure that the region is reserved
and marked MEMBLOCK_NOMAP.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 34bbad23da86..7c5a38c60037 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/platform_device.h>
 #include <linux/screen_info.h>
 
 #include <asm/efi.h>
@@ -80,6 +81,10 @@ static void __init init_screen_info(void)
 		screen_info.orig_video_cols = 80;
 		screen_info.orig_video_lines = 25;
 	}
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    memblock_is_map_memory(screen_info.lfb_base))
+		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
 }
 
 static int __init uefi_init(void)
@@ -241,3 +246,16 @@ void __init efi_init(void)
 
 	init_screen_info();
 }
+
+static int __init register_gop_device(void)
+{
+	void *pd;
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return 0;
+
+	pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
+					   &screen_info, sizeof(screen_info));
+	return PTR_ERR_OR_ZERO(pd);
+}
+subsys_initcall(register_gop_device);
-- 
2.5.0
