From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:55 +0200
Subject: [PATCH v3 11/11] arm64/efi: adapt to relaxed kernel Image placement
 requirements
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-12-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adapts the EFI stub kernel placement to the new relaxed
requirements, by placing the kernel Image at the highest available
2 MB offset in physical memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index f5374065ad53..c2141ed8a043 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -28,8 +28,8 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
 	kernel_size = _edata - _text;
 	if (*image_addr != (dram_base + TEXT_OFFSET)) {
 		kernel_memsize = kernel_size + (_end - _edata);
-		status = efi_low_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
-				       SZ_2M, reserve_addr);
+		status = efi_high_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
+				       SZ_2M, reserve_addr, ULONG_MAX);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Failed to relocate kernel\n");
 			return status;
-- 
1.8.3.2
