From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 17 Apr 2014 13:14:12 -0700
Subject: [PATCH] ARM: fix big endian __pv_phys_pfn_offset size related issue
Message-ID: <1397765652-21623-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix e26a9e00afc482b971afcaef1db8c9034d4d6d7c 'ARM: Better
virt_to_page() handling' replaced __pv_phys_offset with
__pv_phys_pfn_offset. Also note that size of __pv_phys_offset
was quad but size of __pv_phys_pfn_offset is word. Instruction
that used to update __pv_phys_offset which address is in r6
had to update low word of __pv_phys_offset so it used #LOW_OFFSET
macro for store offset. Now when size of __pv_phys_pfn_offset is
word, no difference between little endian and big endian should
exist - i.e no offset should be used when __pv_phys_pfn_offset
is stored.

Note that for little endian image proposed change is noop,
since in little endian case #LOW_OFFSET is defined 0 anyway.

Reported-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8c0883..591d6e4 100644
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
1.8.1.4
