From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 16:23:43 +0100
Subject: [RFC PATCH 3/3] arm64/efi: use relocated kernel
In-Reply-To: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426519423-28263-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PoC for relocated kernel code. This puts the kernel at the top of the
lowest naturally aligned 1 GB region of memory, and relocates the
kernel so that the relative alignment of physical and virtual memory
is at least 1 GB as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-entry.S | 4 +++-
 arch/arm64/kernel/efi-stub.c  | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index f78e6a1de825..89ba42191e59 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -11,6 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <linux/sizes.h>
 
 #include <asm/assembler.h>
 
@@ -110,7 +111,8 @@ ENTRY(efi_stub_entry)
 2:
 	/* Jump to kernel entry point */
 	mov	x0, x20
-	mov	x1, xzr
+	and	x1, x21, #~(SZ_2M - 1)
+	and	x1, x1, #(SZ_1G - 1)
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x21
diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 3b67ca4e2f2e..ba95d9d69884 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -38,8 +38,9 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
 	if (*image_addr != preferred_offset) {
 		const unsigned long alloc_size = kernel_memsize + TEXT_OFFSET;
 
-		status = efi_low_alloc(sys_table, alloc_size, SZ_2M,
-				       reserve_addr);
+		status = efi_high_alloc(sys_table, alloc_size, SZ_2M,
+				       reserve_addr,
+				       (dram_base | (SZ_1G - 1)) + 1);
 
 		/*
 		 * Check whether the new allocation crosses a 512 MB alignment
-- 
1.8.3.2
