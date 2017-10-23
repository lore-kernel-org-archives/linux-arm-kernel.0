From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Oct 2017 17:11:20 +0100
Subject: [PATCH v3 7/9] KVM: arm/arm64: Only clean the dcache on translation
 fault
In-Reply-To: <20171023161122.15291-1-marc.zyngier@arm.com>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
Message-ID: <20171023161122.15291-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only case where we actually need to perform a dcache maintenance
is when we map the page for the first time, and subsequent permission
faults do not require cache maintenance. Let's make it conditional
on not being a permission fault (and thus a translation fault).

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 0417c8e2a81c..f956efbd933d 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1400,7 +1400,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
 			kvm_set_pfn_dirty(pfn);
 		}
-		clean_dcache_guest_page(vcpu, pfn, PMD_SIZE);
+
+		if (fault_status != FSC_PERM)
+			clean_dcache_guest_page(vcpu, pfn, PMD_SIZE);
 
 		if (exec_fault) {
 			new_pmd = kvm_s2pmd_mkexec(new_pmd);
@@ -1416,7 +1418,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_pfn_dirty(pfn);
 			mark_page_dirty(kvm, gfn);
 		}
-		clean_dcache_guest_page(vcpu, pfn, PAGE_SIZE);
+
+		if (fault_status != FSC_PERM)
+			clean_dcache_guest_page(vcpu, pfn, PAGE_SIZE);
 
 		if (exec_fault) {
 			new_pte = kvm_s2pte_mkexec(new_pte);
-- 
2.11.0
