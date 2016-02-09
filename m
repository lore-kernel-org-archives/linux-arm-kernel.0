From: rrichter@caviumnetworks.com (Robert Richter)
Date: Tue, 9 Feb 2016 14:53:46 +0100
Subject: [PATCH v4 6/6] arm64/efi: ignore DT memreserve entries instead of
 removing them
In-Reply-To: <1455026026-11571-1-git-send-email-rrichter@caviumnetworks.com>
References: <1455026026-11571-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <1455026026-11571-7-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Now that the reservation of the FDT image itself is split off from
the processing of memory reservations described by the device tree,
we can make the DT scanning of memreserves conditional on whether
we booted via UEFI and have its memory map available. This allows
us to drop deletion of these memreserves in the stub. It also fixes
the issue where the /reserved-memory node (which offers another
way of reserving memory ranges) was not being ignored under UEFI.

Note that this reverts 0ceac9e094b0 ("efi/arm64: Fix fdt-related
memory reservation").

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-Id: <1442881288-13962-7-git-send-email-ard.biesheuvel@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/mm/init.c               |  3 ++-
 drivers/firmware/efi/libstub/fdt.c | 11 +----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index eda226e85c71..ee061658866f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -171,7 +171,8 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
 #endif
 
-	early_init_fdt_scan_reserved_mem();
+	if (!efi_enabled(EFI_MEMMAP))
+		early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 9df1560d57bc..12cb2a30a63f 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -24,8 +24,7 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 			unsigned long map_size, unsigned long desc_size,
 			u32 desc_ver)
 {
-	int node, num_rsv;
-	int status;
+	int node, status;
 	u32 fdt_val32;
 	u64 fdt_val64;
 
@@ -53,14 +52,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 	if (status != 0)
 		goto fdt_set_fail;
 
-	/*
-	 * Delete all memory reserve map entries. When booting via UEFI,
-	 * kernel will use the UEFI memory map to find reserved regions.
-	 */
-	num_rsv = fdt_num_mem_rsv(fdt);
-	while (num_rsv-- > 0)
-		fdt_del_mem_rsv(fdt, num_rsv);
-
 	node = fdt_subnode_offset(fdt, 0, "chosen");
 	if (node < 0) {
 		node = fdt_add_subnode(fdt, 0, "chosen");
-- 
2.7.0.rc3
