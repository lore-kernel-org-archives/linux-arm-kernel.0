From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:42 +0200
Subject: [PULL 34/50] arm/arm64: KVM: Remove external abort test from MMIO
 handling
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-35-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we know handle external aborts pretty early, we can get rid of
its handling in the MMIO code (which was a bit odd to begin with...).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 10f80a6..b6e715f 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -126,12 +126,6 @@ static int decode_hsr(struct kvm_vcpu *vcpu, bool *is_write, int *len)
 	int access_size;
 	bool sign_extend;
 
-	if (kvm_vcpu_dabt_isextabt(vcpu)) {
-		/* cache operation on I/O addr, tell guest unsupported */
-		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
-		return 1;
-	}
-
 	if (kvm_vcpu_dabt_iss1tw(vcpu)) {
 		/* page table accesses IO mem: tell guest to fix its TTBR */
 		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
-- 
2.9.0
