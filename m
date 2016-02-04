From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  4 Feb 2016 16:50:30 +0100
Subject: [PATCH v2 7/7] ARM/arm64: efistub: perform hardware compatibility
 check
In-Reply-To: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454601030-9093-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before proceeding with relocating the kernel and parsing the command line,
insert a call to check_platform_features() to allow an arch specific check
to be performed whether the current kernel can execute on the current
hardware.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 4 ++++
 drivers/firmware/efi/libstub/efistub.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 3397902e4040..6086a874fa3c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -190,6 +190,10 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 
 	pr_efi(sys_table, "Booting Linux Kernel...\n");
 
+	status = check_platform_features(sys_table);
+	if (status != EFI_SUCCESS)
+		goto fail;
+
 	/*
 	 * Get a handle to the loaded image protocol.  This is used to get
 	 * information about the running image, such as size and the command
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 275f395c886d..a25ac4c7955f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -53,4 +53,6 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
 		     int *count);
 
+efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
+
 #endif
-- 
2.5.0
