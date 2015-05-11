From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 09:13:08 +0200
Subject: [PATCH 10/10] arm64/efi: adapt to relaxed kernel Image placement
 requirements
In-Reply-To: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1431328388-3051-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adapts the EFI stub kernel placement to the new relaxed
requirements, by placing the kernel Image at the highest available
2 MB offset in physical memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-stub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index f5374065ad53..60ae3324e26e 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -10,6 +10,7 @@
  *
  */
 #include <linux/efi.h>
+#include <asm/boot.h>
 #include <asm/efi.h>
 #include <asm/sections.h>
 
@@ -28,8 +29,8 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
 	kernel_size = _edata - _text;
 	if (*image_addr != (dram_base + TEXT_OFFSET)) {
 		kernel_memsize = kernel_size + (_end - _edata);
-		status = efi_low_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
-				       SZ_2M, reserve_addr);
+		status = efi_high_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
+				       MIN_KIMG_ALIGN, reserve_addr, ULONG_MAX);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Failed to relocate kernel\n");
 			return status;
-- 
1.9.1
