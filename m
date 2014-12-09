From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:01 +0100
Subject: [GIT PULL 2/9] arm/arm64: kvm: drop inappropriate use of
 kvm_is_mmio_pfn()
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Instead of using kvm_is_mmio_pfn() to decide whether a host region
should be stage 2 mapped with device attributes, add a new static
function kvm_is_device_pfn() that disregards RAM pages with the
reserved bit set, as those should usually not be mapped as device
memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 57a403a..b007438 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -834,6 +834,11 @@ static bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_dabt_iswrite(vcpu);
 }
 
+static bool kvm_is_device_pfn(unsigned long pfn)
+{
+	return !pfn_valid(pfn);
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -904,7 +909,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (is_error_pfn(pfn))
 		return -EFAULT;
 
-	if (kvm_is_mmio_pfn(pfn))
+	if (kvm_is_device_pfn(pfn))
 		mem_type = PAGE_S2_DEVICE;
 
 	spin_lock(&kvm->mmu_lock);
-- 
2.1.2.330.g565301e.dirty
