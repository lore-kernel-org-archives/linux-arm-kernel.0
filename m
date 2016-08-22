From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Aug 2016 09:01:17 +0100
Subject: [PATCH v2] arm: KVM: Fix idmap overlap detection when the kernel is
 idmap'ed
Message-ID: <1471852877-17197-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're trying hard to detect when the HYP idmap overlaps with the
HYP va, as it makes the teardown of a cpu dangerous. But there is
one case where an overlap is completely safe, which is when the
whole of the kernel is idmap'ed, which is likely to happen on 32bit
when RAM is at 0x8000000 and we're using a 2G/2G VA split.

In that case, we can proceed safely.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
v2: Fixed integer/pointer comparaison warning

 arch/arm/kvm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index bda27b6..49149b9 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1714,7 +1714,8 @@ int kvm_mmu_init(void)
 		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
 
 	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
-	    hyp_idmap_start <  kern_hyp_va(~0UL)) {
+	    hyp_idmap_start <  kern_hyp_va(~0UL) &&
+	    hyp_idmap_start != (unsigned long)__hyp_idmap_text_start) {
 		/*
 		 * The idmap page is intersecting with the VA space,
 		 * it is not safe to continue further.
-- 
2.1.4
