From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:41:00 +0100
Subject: [PATCH 5/5] arm/arm64: KVM: Turn off vcpus and flush stage-2 pgtables
 on sytem exit events
In-Reply-To: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417113660-23610-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a vcpu calls SYSTEM_OFF or SYSTEM_RESET with PSCI v0.2, the vcpus
should really be turned off for the VM adhering to the suggestions in
the PSCI spec, and it's the sane thing to do.

Also, to ensure a coherent icache/dcache/ram situation when restarting
with the guest MMU off, flush all stage-2 page table entries so we start
taking aborts when the guest reboots, and flush/invalidate the necessary
cache lines.

Clarify the behavior and expectations for arm/arm64 in the
KVM_EXIT_SYSTEM_EVENT case.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt |  4 ++++
 arch/arm/kvm/psci.c               | 18 ++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index fc12b4f..c67e4956 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2955,6 +2955,10 @@ HVC instruction based PSCI call from the vcpu. The 'type' field describes
 the system-level event type. The 'flags' field describes architecture
 specific flags for the system-level event.
 
+In the case of ARM/ARM64, all vcpus will be powered off when requesting shutdown
+or reset, and it is the responsibility of userspace to reinitialize the vcpus
+using KVM_ARM_VCPU_INIT.
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 09cf377..b4ab613 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -15,11 +15,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/preempt.h>
 #include <linux/kvm_host.h>
 #include <linux/wait.h>
 
 #include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
 
 /*
@@ -166,6 +168,22 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 
 static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 {
+	int i;
+	struct kvm_vcpu *tmp;
+
+	/* Stop all vcpus */
+	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
+		tmp->arch.pause = true;
+	preempt_disable();
+	force_vm_exit(cpu_all_mask);
+	preempt_enable();
+
+	/*
+	 * Ensure a rebooted VM will fault in RAM pages and detect if the
+	 * guest MMU is turned off and flush the caches as needed.
+	 */
+	stage2_unmap_vm(vcpu->kvm);
+
 	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
 	vcpu->run->system_event.type = type;
 	vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2012c4b..dbd3212 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -200,6 +200,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void force_vm_exit(const cpumask_t *mask);
 
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		int exception_index);
-- 
2.1.2.330.g565301e.dirty
