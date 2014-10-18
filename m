From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:57:01 +0100
Subject: [PATCH 11/12] arm: kvm: STRICT_MM_TYPECHECKS fix for user_mem_abort
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>

Commit:
b886576 ARM: KVM: user_mem_abort: support stage 2 MMIO page mapping

introduced some code in user_mem_abort that failed to compile if
STRICT_MM_TYPECHECKS was enabled.

This patch fixes up the failing comparison.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Reviewed-by: Kim Phillips <kim.phillips@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 8c40829..57a403a 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -930,7 +930,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
-				     mem_type == PAGE_S2_DEVICE);
+			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
 	}
 
 
-- 
2.1.1
