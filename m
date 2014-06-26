From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Jun 2014 16:23:33 +0200
Subject: [PATCH v2 1/5] efi/arm64: avoid EFI_ERROR as a generic return code
In-Reply-To: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1403792617-25792-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As EFI_ERROR is not a UEFI result code but a local invention only intended to
allow get_dram_base() to signal failure, we should not use it elsewhere.

Replace with EFI_LOAD_ERROR.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index e786e6cdc400..7aa7155a9740 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -69,7 +69,7 @@ static efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 		if (*image_addr != (dram_base + TEXT_OFFSET)) {
 			pr_efi_err(sys_table, "Failed to alloc kernel memory\n");
 			efi_free(sys_table, kernel_memsize, *image_addr);
-			return EFI_ERROR;
+			return EFI_LOAD_ERROR;
 		}
 		*image_size = kernel_memsize;
 	}
-- 
1.8.3.2
