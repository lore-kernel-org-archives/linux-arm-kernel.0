From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Jan 2018 18:43:32 +0000
Subject: [PATCH v4 17/19] arm64: KVM: Dynamically compute the HYP VA mask
In-Reply-To: <20180104184334.16571-1-marc.zyngier@arm.com>
References: <20180104184334.16571-1-marc.zyngier@arm.com>
Message-ID: <20180104184334.16571-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're moving towards a much more dynamic way to compute our
HYP VA, let's express the mask in a slightly different way.

Instead of comparing the idmap position to the "low" VA mask,
we directly compute the mask by taking into account the idmap's
(VA_BIT-1) bit.

No functionnal change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/va_layout.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index aee758574e61..75bb1c6772b0 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -21,24 +21,19 @@
 #include <asm/insn.h>
 #include <asm/kvm_mmu.h>
 
-#define HYP_PAGE_OFFSET_HIGH_MASK	((UL(1) << VA_BITS) - 1)
-#define HYP_PAGE_OFFSET_LOW_MASK	((UL(1) << (VA_BITS - 1)) - 1)
-
 static u64 va_mask;
 
 static void compute_layout(void)
 {
 	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
-	unsigned long mask = HYP_PAGE_OFFSET_HIGH_MASK;
+	u64 region;
 
-	/*
-	 * Activate the lower HYP offset only if the idmap doesn't
-	 * clash with it,
-	 */
-	if (idmap_addr > HYP_PAGE_OFFSET_LOW_MASK)
-		mask = HYP_PAGE_OFFSET_HIGH_MASK;
+	/* Where is my RAM region? */
+	region  = idmap_addr & BIT(VA_BITS - 1);
+	region ^= BIT(VA_BITS - 1);
 
-	va_mask = mask;
+	va_mask  = BIT(VA_BITS - 1) - 1;
+	va_mask |= region;
 }
 
 static u32 compute_instruction(int n, u32 rd, u32 rn)
-- 
2.14.2
