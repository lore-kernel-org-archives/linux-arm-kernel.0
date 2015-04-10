From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:49 +0200
Subject: [PATCH v3 05/11] arm64/efi: adapt to relaxed FDT placement
 requirements
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the relaxed FDT placement requirements in place, we can change
the allocation strategy used by the stub to put the FDT image higher
up in memory. At the same time, reduce the minimal alignment to 8 bytes,
and impose a 2 MB size limit, as per the new requirements.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/efi.h            |  8 +++-----
 drivers/firmware/efi/libstub/arm-stub.c |  5 ++---
 drivers/firmware/efi/libstub/efistub.h  |  1 -
 drivers/firmware/efi/libstub/fdt.c      | 23 +++++++++++++----------
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index ef572206f1c3..bd513dd663b9 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -39,12 +39,10 @@ extern void efi_init(void);
 /* arch specific definitions used by the stub code */
 
 /*
- * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
- * start of kernel and may not cross a 2MiB boundary. We set alignment to
- * 2MiB so we know it won't cross a 2MiB boundary.
+ * AArch64 requires the DTB to be 8-byte aligned and not exceed 2MiB in size.
  */
-#define EFI_FDT_ALIGN	SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
-#define MAX_FDT_OFFSET	SZ_512M
+#define EFI_FDT_ALIGN		8
+#define EFI_FDT_MAX_SIZE	SZ_2M
 
 #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index dcae482a9a17..f54c76a4fd32 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -269,9 +269,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 
 	new_fdt_addr = fdt_addr;
 	status = allocate_new_fdt_and_exit_boot(sys_table, handle,
-				&new_fdt_addr, dram_base + MAX_FDT_OFFSET,
-				initrd_addr, initrd_size, cmdline_ptr,
-				fdt_addr, fdt_size);
+				&new_fdt_addr, initrd_addr, initrd_size,
+				cmdline_ptr, fdt_addr, fdt_size);
 
 	/*
 	 * If all went well, we need to return the FDT address to the
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 47437b16b186..c8e096094ea9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -35,7 +35,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 91da56c4fd54..ace5ed70a88e 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -165,10 +165,6 @@ fdt_set_fail:
 	return EFI_LOAD_ERROR;
 }
 
-#ifndef EFI_FDT_ALIGN
-#define EFI_FDT_ALIGN EFI_PAGE_SIZE
-#endif
-
 /*
  * Allocate memory for a new FDT, then add EFI, commandline, and
  * initrd related fields to the FDT.  This routine increases the
@@ -186,7 +182,6 @@ fdt_set_fail:
 efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 					    void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -197,6 +192,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	unsigned long mmap_key;
 	efi_memory_desc_t *memory_map, *runtime_map;
 	unsigned long new_fdt_size;
+	void *fdt_alloc;
 	efi_status_t status;
 	int runtime_entry_count = 0;
 
@@ -221,14 +217,21 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	 * will allocate a bigger buffer if this ends up being too
 	 * small, so a rough guess is OK here.
 	 */
-	new_fdt_size = fdt_size + EFI_PAGE_SIZE;
+	new_fdt_size = fdt_size + EFI_PAGE_SIZE + EFI_FDT_ALIGN;
 	while (1) {
-		status = efi_high_alloc(sys_table, new_fdt_size, EFI_FDT_ALIGN,
-					new_fdt_addr, max_addr);
+		if (new_fdt_size > EFI_FDT_MAX_SIZE) {
+			pr_efi_err(sys_table, "FDT size exceeds EFI_FDT_MAX_SIZE.\n");
+			goto fail;
+		}
+		status = sys_table->boottime->allocate_pool(EFI_LOADER_DATA,
+							    new_fdt_size,
+							    &fdt_alloc);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Unable to allocate memory for new device tree.\n");
 			goto fail;
 		}
+		*new_fdt_addr = round_up((unsigned long)fdt_alloc,
+					 EFI_FDT_ALIGN);
 
 		/*
 		 * Now that we have done our final memory allocation (and free)
@@ -258,7 +261,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 			 * to get new one that reflects the free/alloc we do
 			 * on the device tree buffer.
 			 */
-			efi_free(sys_table, new_fdt_size, *new_fdt_addr);
+			sys_table->boottime->free_pool(&fdt_alloc);
 			sys_table->boottime->free_pool(memory_map);
 			new_fdt_size += EFI_PAGE_SIZE;
 		} else {
@@ -316,7 +319,7 @@ fail_free_mmap:
 	sys_table->boottime->free_pool(memory_map);
 
 fail_free_new_fdt:
-	efi_free(sys_table, new_fdt_size, *new_fdt_addr);
+	sys_table->boottime->free_pool(&fdt_alloc);
 
 fail:
 	sys_table->boottime->free_pool(runtime_map);
-- 
1.8.3.2
