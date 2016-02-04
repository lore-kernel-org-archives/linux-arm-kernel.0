From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  4 Feb 2016 16:50:27 +0100
Subject: [PATCH v2 4/7] efi: arm-init: use read-only early mappings
In-Reply-To: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454601030-9093-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early mappings of the EFI system table contents and the UEFI memory
map are read-only from the OS point of view. So map them read-only to
protect them from inadvertent modification.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 9e15d571b53c..aa1f743152a2 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -61,8 +61,8 @@ static int __init uefi_init(void)
 	char vendor[100] = "unknown";
 	int i, retval;
 
-	efi.systab = early_memremap(efi_system_table,
-				    sizeof(efi_system_table_t));
+	efi.systab = early_memremap_ro(efi_system_table,
+				       sizeof(efi_system_table_t));
 	if (efi.systab == NULL) {
 		pr_warn("Unable to map EFI system table.\n");
 		return -ENOMEM;
@@ -86,8 +86,8 @@ static int __init uefi_init(void)
 			efi.systab->hdr.revision & 0xffff);
 
 	/* Show what we know for posterity */
-	c16 = early_memremap(efi_to_phys(efi.systab->fw_vendor),
-			     sizeof(vendor) * sizeof(efi_char16_t));
+	c16 = early_memremap_ro(efi_to_phys(efi.systab->fw_vendor),
+				sizeof(vendor) * sizeof(efi_char16_t));
 	if (c16) {
 		for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i)
 			vendor[i] = c16[i];
@@ -100,8 +100,8 @@ static int __init uefi_init(void)
 		efi.systab->hdr.revision & 0xffff, vendor);
 
 	table_size = sizeof(efi_config_table_64_t) * efi.systab->nr_tables;
-	config_tables = early_memremap(efi_to_phys(efi.systab->tables),
-				       table_size);
+	config_tables = early_memremap_ro(efi_to_phys(efi.systab->tables),
+					  table_size);
 	if (config_tables == NULL) {
 		pr_warn("Unable to map EFI config table array.\n");
 		retval = -ENOMEM;
@@ -185,7 +185,7 @@ void __init efi_init(void)
 	efi_system_table = params.system_table;
 
 	memmap.phys_map = params.mmap;
-	memmap.map = early_memremap(params.mmap, params.mmap_size);
+	memmap.map = early_memremap_ro(params.mmap, params.mmap_size);
 	if (memmap.map == NULL) {
 		/*
 		* If we are booting via UEFI, the UEFI memory map is the only
-- 
2.5.0
