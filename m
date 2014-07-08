From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  8 Jul 2014 14:50:03 +0200
Subject: [RFC PATCH 3/3] arm64/efi: efistub: get TEXT_OFFSET from the Image
 header at runtime
In-Reply-To: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1404823803-7317-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EFI stub for arm64 needs to behave like an ordinary bootloader in the sense
that it needs to inspect the Image header at runtime and not rely on the linker
or preprocessor to produce a value for TEXT_OFFSET.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/Makefile   |  2 --
 arch/arm64/kernel/efi-stub.c | 19 +++++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cdaedad3afe5..99b676eeeb0f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -4,8 +4,6 @@
 
 CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
-CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET) \
-			   -I$(src)/../../../scripts/dtc/libfdt
 
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 12456a7d3fa2..01581d332858 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -11,6 +11,7 @@
  */
 #include <linux/efi.h>
 #include <asm/efi.h>
+#include <asm/image_hdr.h>
 #include <asm/sections.h>
 
 
@@ -24,20 +25,30 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 {
 	efi_status_t status;
 	unsigned long kernel_size, kernel_memsize = 0;
+	struct image_hdr *hdr = (struct image_hdr *)*image_addr;
+	unsigned long image_base;
+
+	/* make sure image_addr points to an arm64 kernel Image */
+	if (!image_hdr_check(hdr)) {
+		pr_efi_err(sys_table, "Kernel Image header corrupt\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	/* put the image at the offset specified in the Image header */
+	image_base = dram_base + image_hdr_text_offset(hdr);
 
 	/* Relocate the image, if required. */
 	kernel_size = _edata - _text;
-	if (*image_addr != (dram_base + TEXT_OFFSET)) {
+	if (*image_addr != image_base) {
 		kernel_memsize = kernel_size + (_end - _edata);
 		status = efi_relocate_kernel(sys_table, image_addr,
 					     kernel_size, kernel_memsize,
-					     dram_base + TEXT_OFFSET,
-					     PAGE_SIZE);
+					     image_base, PAGE_SIZE);
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table, "Failed to relocate kernel\n");
 			return status;
 		}
-		if (*image_addr != (dram_base + TEXT_OFFSET)) {
+		if (*image_addr != image_base) {
 			pr_efi_err(sys_table, "Failed to alloc kernel memory\n");
 			efi_free(sys_table, kernel_memsize, *image_addr);
 			return EFI_LOAD_ERROR;
-- 
1.8.3.2
