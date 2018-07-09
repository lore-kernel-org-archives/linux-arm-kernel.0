From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 10 Jul 2018 08:42:28 +0900
Subject: [PATCH v3.1 3/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
In-Reply-To: <20180709234229.20181-1-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
Message-ID: <20180709234229.20181-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under the current implementation, UEFI memory map will be mapped and made
available in virtual mappings only if runtime services are enabled.
But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
to create mappings of ACPI tables using memory attributes described in
UEFI memory map.
See the following commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

So, as a first step, arm_enter_runtime_services() is modified, alongside
Ard's patch[1], so that UEFI memory map will not be freed even if
efi=noruntime.

[1] https://marc.info/?l=linux-efi&m=152930773507524&w=2

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 59a8c0ec94d5..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -117,6 +117,13 @@ static int __init arm_enable_runtime_services(void)
 
 	efi_memmap_unmap();
 
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
@@ -129,13 +136,6 @@ static int __init arm_enable_runtime_services(void)
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
 		return -ENOMEM;
-- 
2.17.0
