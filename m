From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 14:20:04 +0100
Subject: [PATCH 3/5] ARM: KVM: make sure maintainance operation complete
 before world switch
In-Reply-To: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371648006-8036-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We may have preempted the guest while it was performing a maintainance
operation (TLB invalidation, for example). Make sure it completes
before we do anything else by adding the necessary barriers.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index afa6c04..3124e0f 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -149,6 +149,15 @@ __kvm_vcpu_return:
 	 * r0: vcpu pointer
 	 * r1: exception code
 	 */
+
+	/*
+	 * We may have preempted the guest while it was performing a
+	 * maintainance operation (TLB invalidation, for example). Make
+	 * sure it completes before we do anything else.
+	 */
+	dsb
+	isb
+
 	save_guest_regs
 
 	@ Set VMID == 0
-- 
1.8.2.3
