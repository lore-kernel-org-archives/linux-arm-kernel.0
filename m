From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 15:07:25 +0100
Subject: [PATCH] arm64/efi: do not assume DRAM base is aligned to 2 MB
Message-ID: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current arm64 Image relocation code in the UEFI stub assumes that
the dram_base argument it receives is always a multiple of 2 MB. In
reality, it is simply the lowest start address of all RAM entries in
the UEFI memory map, which means it could be any multiple of 4 KB.

Since the arm64 kernel Image needs to reside TEXT_OFFSET bytes beyond
a 2 MB aligned base, or it will fail to boot, make sure we round dram_base
to 2 MB before using it to calculate the relocation address.

Reported-by: Timur Tabi <timur@codeaurora.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

If deemed acceptable, could we either get this into v4.3 or tag it for
stable (v4.3 only) please?

 arch/arm64/kernel/efi-stub.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120ece6bc..78dfbd34b6bf 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -25,10 +25,20 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 	unsigned long kernel_size, kernel_memsize = 0;
 	unsigned long nr_pages;
 	void *old_image_addr = (void *)*image_addr;
+	unsigned long preferred_offset;
+
+	/*
+	 * The preferred offset of the kernel Image is TEXT_OFFSET bytes beyond
+	 * a 2 MB aligned base, which itself may be lower than dram_base, as
+	 * long as the resulting offset equals or exceeds it.
+	 */
+	preferred_offset = round_down(dram_base, SZ_2M) + TEXT_OFFSET;
+	if (preferred_offset < dram_base)
+		preferred_offset += SZ_2M;
 
 	/* Relocate the image, if required. */
 	kernel_size = _edata - _text;
-	if (*image_addr != (dram_base + TEXT_OFFSET)) {
+	if (*image_addr != preferred_offset) {
 		kernel_memsize = kernel_size + (_end - _edata);
 
 		/*
@@ -42,7 +52,7 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 		 * Mustang), we can still place the kernel@the address
 		 * 'dram_base + TEXT_OFFSET'.
 		 */
-		*image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
+		*image_addr = *reserve_addr = preferred_offset;
 		nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
 			   EFI_PAGE_SIZE;
 		status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
-- 
2.1.4
