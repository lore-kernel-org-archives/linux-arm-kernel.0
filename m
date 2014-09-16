From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Mon, 15 Sep 2014 19:47:24 -0500
Subject: [PATCH 2/4] arm64/efi: efistub: don't abort if base of DRAM is
 occupied
In-Reply-To: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1410828446-28502-3-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

If we cannot relocate the kernel Image to its preferred offset of base of DRAM
plus TEXT_OFFSET, instead relocate it to the lowest available 2 MB boundary plus
TEXT_OFFSET. We may lose a bit of memory at the low end, but we can still
proceed normally otherwise.

Acked-by: Mark Salter <msalter@redhat.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/efi-stub.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 1317fef..d27dd98 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -28,20 +28,16 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	kernel_size = _edata - _text;
 	if (*image_addr != (dram_base + TEXT_OFFSET)) {
 		kernel_memsize = kernel_size + (_end - _edata);
-		status = efi_relocate_kernel(sys_table, image_addr,
-					     kernel_size, kernel_memsize,
-					     dram_base + TEXT_OFFSET,
-					     PAGE_SIZE);
+		status = efi_low_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
+				       SZ_2M, reserve_addr);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Failed to relocate kernel\n");
 			return status;
 		}
-		if (*image_addr != (dram_base + TEXT_OFFSET)) {
-			pr_efi_err(sys_table, "Failed to alloc kernel memory\n");
-			efi_free(sys_table, kernel_memsize, *image_addr);
-			return EFI_LOAD_ERROR;
-		}
-		*image_size = kernel_memsize;
+		memcpy((void *)*reserve_addr + TEXT_OFFSET, (void *)*image_addr,
+		       kernel_size);
+		*image_addr = *reserve_addr + TEXT_OFFSET;
+		*reserve_size = kernel_memsize + TEXT_OFFSET;
 	}
 
 
-- 
1.9.3
