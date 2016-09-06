From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:16 +0100
Subject: [PATCH 18/19] arm/arm64: KVM: Remove external abort test from MMIO
 handling
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we know handle external aborts pretty early, we can get rid of
its handling in the MMIO code (which was a bit odd to begin with...).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
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
2.1.4
