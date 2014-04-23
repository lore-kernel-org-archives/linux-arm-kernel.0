From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 16:04:08 +0100
Subject: [PATCH] ARM: head: fix virt/phys patching for big-endian systems
Message-ID: <1398265448-13541-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e26a9e00afc4 ("ARM: Better virt_to_page() handling") reworked the
dynamic virt/phys patching to store the physical offset of the start of
memory as a PFN (32-bit quantity) instead of a physical address (potentially
a 64-bit quantity). Unfortunately, some of the old code was left behind,
causing big-endian systems to store the calculated PFN to the next word
*after* __pv_phys_pfn_offset and causing the kernel to treat PHYS_OFFSET
as 0x0.

This patch fixes the patching code, so that we store the 32-bit PFN offset
to the correct address, regardless of endianness.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8c08839edf3..591d6e4a6492 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -587,7 +587,7 @@ __fixup_pv_table:
 	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
 	add	r7, r7, r3	@ adjust __pv_offset address
 	mov	r0, r8, lsr #12	@ convert to PFN
-	str	r0, [r6, #LOW_OFFSET]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
+	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
-- 
1.9.2
