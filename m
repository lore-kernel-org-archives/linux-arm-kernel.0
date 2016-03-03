From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 19:44:16 +0100
Subject: [PATCH v2 3/3] arm64: kaslr: increase randomization granularity
In-Reply-To: <1457030656-29584-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457030656-29584-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457030656-29584-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, our KASLR implementation randomizes the placement of the core
kernel at 2 MB granularity. This is based on the arm64 kernel boot
protocol, which mandates that the kernel is loaded TEXT_OFFSET bytes above
a 2 MB aligned base address. This requirement is a result of the fact that
the block size used by the early mapping code may be 2 MB at the most (for
a 4 KB granule kernel)

But we can do better than that: since a KASLR kernel needs to be relocated
in any case, we can tolerate a physical misalignment as long as the virtual
misalignment relative to this 2 MB block size is equal in size, and code to
deal with this is already in place.

Since we align the kernel segments to 64 KB, let's randomize the physical
offset at 64 KB granularity as well (unless CONFIG_DEBUG_ALIGN_RODATA is
enabled). This way, the mapping efficiency is not affected at all.

The higher granularity produces 5 bits of additional entropy.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index e0e6b74fef8f..a1dd4a1dad0b 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -61,15 +61,23 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
 		/*
+		 * Produce a displacement in the interval [0, MIN_KIMG_ALIGN)
+		 * that is a multiple of the minimal segment alignment (SZ_64K)
+		 */
+		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
+			     (phys_seed >> 32) & (MIN_KIMG_ALIGN - 1) &
+			     ~(SZ_64K - 1) : TEXT_OFFSET;
+
+		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		*reserve_size = kernel_memsize + TEXT_OFFSET;
+		*reserve_size = kernel_memsize + offset;
 		status = efi_random_alloc(sys_table_arg, *reserve_size,
 					  MIN_KIMG_ALIGN, reserve_addr,
-					  phys_seed);
+					  (u32)phys_seed);
 
-		*image_addr = *reserve_addr + TEXT_OFFSET;
+		*image_addr = *reserve_addr + offset;
 	} else {
 		/*
 		 * Else, try a straight allocation at the preferred offset.
-- 
2.5.0
