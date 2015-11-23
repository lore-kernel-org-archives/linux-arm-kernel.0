From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Nov 2015 08:43:24 +0100
Subject: [PATCH 2/2] arm64: efi: fix initcall return values
In-Reply-To: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1448264604-19411-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though initcall return values are typically ignored, the
prototype is to return 0 on success or a negative errno value on
error. So fix the arm_enable_runtime_services() implementation to
return 0 on conditions that are not in fact errors, and return a
meaningful error code otherwise.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 186b9e119d4a..3aeb576965c0 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -285,12 +285,12 @@ static int __init arm64_enable_runtime_services(void)
 
 	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
-		return -1;
+		return 0;
 	}
 
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
-		return -1;
+		return 0;
 	}
 
 	pr_info("Remapping and enabling EFI services.\n");
@@ -300,7 +300,7 @@ static int __init arm64_enable_runtime_services(void)
 						   mapsize);
 	if (!memmap.map) {
 		pr_err("Failed to remap EFI memory map\n");
-		return -1;
+		return -ENOMEM;
 	}
 	memmap.map_end = memmap.map + mapsize;
 	efi.memmap = &memmap;
@@ -309,13 +309,13 @@ static int __init arm64_enable_runtime_services(void)
 						   sizeof(efi_system_table_t));
 	if (!efi.systab) {
 		pr_err("Failed to remap EFI System Table\n");
-		return -1;
+		return -ENOMEM;
 	}
 	set_bit(EFI_SYSTEM_TABLES, &efi.flags);
 
 	if (!efi_virtmap_init()) {
 		pr_err("No UEFI virtual mapping was installed -- runtime services will not be available\n");
-		return -1;
+		return -ENOMEM;
 	}
 
 	/* Set up runtime services function pointers */
-- 
1.9.1
