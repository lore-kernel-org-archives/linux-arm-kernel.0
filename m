From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Nov 2018 19:45:51 +0100
Subject: [PATCH 1/2] efi: arm: revert deferred unmap of early memmap mapping
In-Reply-To: <20181108184552.14366-1-ard.biesheuvel@linaro.org>
References: <20181108184552.14366-1-ard.biesheuvel@linaro.org>
Message-ID: <20181108184552.14366-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory
map longer for BGRT") deferred the unmap of the early mapping of the
UEFI to accommodate the ACPI BGRT code, which looks up the memory
type that backs the BGRT table to validate it against the requirements
of the UEFI spec.

Unfortunately, this causes problems on ARM, which does not permit
early mappings to persist after paging_init() is called, resulting
in a WARN() splat. Since we don't support the BGRT table on ARM anway,
let's revert ARM to the old behaviour, which is to take down the
early mapping at the end of efi_init().

Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c    | 4 ++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 drivers/firmware/efi/memmap.c      | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 388a929baf95..1a6a77df8a5e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,10 @@ void __init efi_init(void)
 				    (params.mmap & ~PAGE_MASK)));
 
 	init_screen_info();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_memmap_unmap();
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
 
-	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
+	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index fa2904fb841f..38b686c67b17 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -118,6 +118,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 
 void __init efi_memmap_unmap(void)
 {
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (!efi.memmap.late) {
 		unsigned long size;
 
-- 
2.19.1
