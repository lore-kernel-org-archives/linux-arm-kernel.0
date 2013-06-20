From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:23 +0100
Subject: [PATCH v2 09/12] ARM: kvm: use inner-shareable barriers after TLB
 flushing
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When flushing the TLB at PL2 in response to remapping at stage-2 or VMID
rollover, we have a dsb instruction to ensure completion of the command
before continuing.

Since we only care about other processors for TLB invalidation, use the
inner-shareable variant of the dsb instruction instead.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kvm/init.S       | 2 +-
 arch/arm/kvm/interrupts.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index f048338..1b9844d 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -142,7 +142,7 @@ target:	@ We're now in the trampoline code, switch page tables
 
 	@ Invalidate the old TLBs
 	mcr	p15, 4, r0, c8, c7, 0	@ TLBIALLH
-	dsb
+	dsb	ish
 
 	eret
 
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index f7793df..dfb5dcc 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -54,7 +54,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
 	isb
 	mcr     p15, 0, r0, c8, c3, 0	@ TLBIALLIS (rt ignored)
-	dsb
+	dsb	ish
 	isb
 	mov	r2, #0
 	mov	r3, #0
@@ -78,7 +78,7 @@ ENTRY(__kvm_flush_vm_context)
 	mcr     p15, 4, r0, c8, c3, 4
 	/* Invalidate instruction caches Inner Shareable (ICIALLUIS) */
 	mcr     p15, 0, r0, c7, c1, 0
-	dsb
+	dsb	ish
 	isb				@ Not necessary if followed by eret
 
 	bx	lr
-- 
1.8.2.2
