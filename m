From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 14:20:03 +0100
Subject: [PATCH 2/5] ARM: KVM: add missing dsb before invalidating Stage-2 TLBs
In-Reply-To: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371648006-8036-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When performing a Stage-2 TLB invalidation, it is necessary to
make sure the write to the page tables is observable by all CPUs.

For this purpose, add a dsb instruction to __kvm_tlb_flush_vmid_ipa
before doing the TLB invalidation itself.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index d0a8fa3..afa6c04 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -49,6 +49,7 @@ __kvm_hyp_code_start:
 ENTRY(__kvm_tlb_flush_vmid_ipa)
 	push	{r2, r3}
 
+	dsb
 	add	r0, r0, #KVM_VTTBR
 	ldrd	r2, r3, [r0]
 	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
-- 
1.8.2.3
