From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Jan 2013 16:06:44 +0000
Subject: [PATCH v2 1/2] ARM: KVM: move one-time init to its own function
In-Reply-To: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1357834005-23843-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As more code "to be run only once per vcpu" is expected, move
the VGIC init code into a separate function.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h |  3 +++
 arch/arm/kvm/arm.c              | 33 +++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 334b81d..14a71bb 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -127,6 +127,9 @@ struct kvm_vcpu_arch {
 
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
+
+	/* Detect first run of a vcpu */
+	bool has_run_once;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dc67a3c..a28e49d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -643,6 +643,26 @@ static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	}
 }
 
+static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
+{
+	if (likely(vcpu->arch.has_run_once))
+		return 0;
+
+	vcpu->arch.has_run_once = true;
+
+	/*
+	 * Initialize the VGIC before running a vcpu the first time on
+	 * this VM.
+	 */
+	if (irqchip_in_kernel(vcpu->kvm) && !vgic_initialized(vcpu->kvm)) {
+		int ret = kvm_vgic_init(vcpu->kvm);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -663,16 +683,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(vcpu->arch.target < 0))
 		return -ENOEXEC;
 
-	/*
-	 * Initialize the VGIC before running a vcpu the first time on
-	 * this VM.
-	 */
-	if (irqchip_in_kernel(vcpu->kvm) &&
-	    unlikely(!vgic_initialized(vcpu->kvm))) {
-		ret = kvm_vgic_init(vcpu->kvm);
-		if (ret)
-			return ret;
-	}
+	ret = kvm_vcpu_first_run_init(vcpu);
+	if (ret)
+		return ret;
 
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
-- 
1.8.1
