From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Oct 2015 12:37:24 -0500
Subject: [PATCH] [v2] arm64: efi: make sure vmlinux load address aligned on 2MB
Message-ID: <1446053844-27281-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vmlinux image load address must be aligned to 2MB, as documented
in Documentation/arm64/booting.txt. Otherwise, __create_page_tables
in head.S will create incorrect page table entries.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 arch/arm64/kernel/efi-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120e..37118f4 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -42,7 +42,8 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 		 * Mustang), we can still place the kernel at the address
 		 * 'dram_base + TEXT_OFFSET'.
 		 */
-		*image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
+		*image_addr = *reserve_addr =
+			round_up(dram_base, SZ_2M) + TEXT_OFFSET;
 		nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
 			   EFI_PAGE_SIZE;
 		status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
