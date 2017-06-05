From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Jun 2017 08:04:35 +0000
Subject: [PATCH] efi: arm: Don't mark ACPI reclaim memory as MEMBLOCK_NOMAP
Message-ID: <20170605080435.2498-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, regions of memory that are described by UEFI as having special
significance to the firmware itself are omitted from the linear mapping.
This is necessary since we cannot guarantee that alternate mappings of
the same physical region will use attributes that are compatible with
the ones we use for the linear mapping, and aliases with mismatched
attributes are prohibited by the architecture.

The above does not apply to ACPI reclaim regions: such regions have no
special significance to the firmware, and it is up to the OS to decide
whether or not to preserve them after it has consumed their contents,
and for how long, after which time the OS can use the memory in any way
it likes. In the Linux case, such regions are preserved indefinitely,
and are simply treated the same way as other 'reserved' memory types.

Punching holes into the linear mapping causes page table fragmentation,
which increases TLB pressure, and so we should avoid doing so if we can.
So add a special case for regions of type EFI_ACPI_RECLAIM_MEMORY, and
memblock_reserve() them instead of marking them MEMBLOCK_NOMAP.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 1027d7b44358..0aa4ce7b4fbb 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -159,6 +159,7 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	switch (md->type) {
 	case EFI_LOADER_CODE:
 	case EFI_LOADER_DATA:
+	case EFI_ACPI_RECLAIM_MEMORY:
 	case EFI_BOOT_SERVICES_CODE:
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
@@ -211,6 +212,10 @@ static __init void reserve_regions(void)
 
 			if (!is_usable_memory(md))
 				memblock_mark_nomap(paddr, size);
+
+			/* keep ACPI reclaim memory intact for kexec etc. */
+			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
+				memblock_reserve(paddr, size);
 		}
 	}
 }
-- 
2.9.3
