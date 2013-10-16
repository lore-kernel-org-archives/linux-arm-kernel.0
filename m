From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 18:13:20 -0700
Subject: [PATCH] KVM: ARM: Update comments for kvm_handle_wfi
In-Reply-To: <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
References: <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <1381886000-11140-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update comments to reflect what is really going on and add the TWE bit
to the comments in kvm_arm.h.

Also renames the function to kvm_handle_wfx like is done on arm64 for
consistency and uber-correctness.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_arm.h |    1 +
 arch/arm/kvm/handle_exit.c     |   14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index fe395b7..1d3153c 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -57,6 +57,7 @@
  * TSC:		Trap SMC
  * TSW:		Trap cache operations by set/way
  * TWI:		Trap WFI
+ * TWE:		Trap WFE
  * TIDCP:	Trap L2CTLR/L2ECTLR
  * BSU_IS:	Upgrade barriers to the inner shareable domain
  * FB:		Force broadcast of all maintainance operations
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index c4c496f..a920790 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -73,15 +73,17 @@ static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 }
 
 /**
- * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
+ * kvm_handle_wfx - handle a WFI or WFE instructions trapped in guests
  * @vcpu:	the vcpu pointer
  * @run:	the kvm_run structure pointer
  *
- * Simply sets the wait_for_interrupts flag on the vcpu structure, which will
- * halt execution of world-switches and schedule other host processes until
- * there is an incoming IRQ or FIQ to the VM.
+ * WFE: Yield the CPU and come back to this vcpu when the scheduler
+ * decides to.
+ * WFI: Simply call kvm_vcpu_block(), which will halt execution of
+ * world-switches and schedule other host processes until there is an
+ * incoming IRQ or FIQ to the VM.
  */
-static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
+static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	trace_kvm_wfi(*vcpu_pc(vcpu));
 	if (kvm_vcpu_get_hsr(vcpu) & HSR_WFI_IS_WFE)
@@ -93,7 +95,7 @@ static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 }
 
 static exit_handle_fn arm_exit_handlers[] = {
-	[HSR_EC_WFI]		= kvm_handle_wfi,
+	[HSR_EC_WFI]		= kvm_handle_wfx,
 	[HSR_EC_CP15_32]	= kvm_handle_cp15_32,
 	[HSR_EC_CP15_64]	= kvm_handle_cp15_64,
 	[HSR_EC_CP14_MR]	= kvm_handle_cp14_access,
-- 
1.7.10.4
