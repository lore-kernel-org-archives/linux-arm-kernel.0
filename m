From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Apr 2013 16:36:43 +0100
Subject: [PATCH v2 7/7] ARM: KVM: perform HYP initilization for hotplugged CPUs
In-Reply-To: <1365435403-29265-1-git-send-email-marc.zyngier@arm.com>
References: <1365435403-29265-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365435403-29265-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have the necessary infrastructure to boot a hotplugged CPU
at any point in time, wire a CPU notifier that will perform the HYP
init for the incoming CPU.

Note that this depends on the platform code and/or firmware to boot the
incoming CPU with HYP mode enabled and return to the kernel by following
the normal boot path (HYP stub installed).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9010a12..8bee0bb 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,6 +16,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -794,7 +795,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *vector)
+static void cpu_init_hyp_mode(void *dummy)
 {
 	unsigned long long boot_pgd_ptr;
 	unsigned long long pgd_ptr;
@@ -814,12 +815,28 @@ static void cpu_init_hyp_mode(void *vector)
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
+static int hyp_init_cpu_notify(struct notifier_block *self,
+			       unsigned long action, void *cpu)
+{
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		cpu_init_hyp_mode(NULL);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hyp_init_cpu_nb = {
+	.notifier_call = hyp_init_cpu_notify,
+};
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
 static int init_hyp_mode(void)
 {
-	phys_addr_t init_phys_addr;
 	int cpu;
 	int err = 0;
 
@@ -852,19 +869,6 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
-	 *
-	 * Note: The stack is not mapped yet, so don't do anything else than
-	 * initializing the hypervisor mode on each CPU using a local stack
-	 * space for temporary storage.
-	 */
-	init_phys_addr = virt_to_phys(__kvm_hyp_init);
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, cpu_init_hyp_mode,
-					 (void *)(long)init_phys_addr, 1);
-	}
-
-	/*
 	 * Map the Hyp-code called directly from the host
 	 */
 	err = create_hyp_mappings(__kvm_hyp_code_start, __kvm_hyp_code_end);
@@ -909,6 +913,11 @@ static int init_hyp_mode(void)
 	}
 
 	/*
+	 * Execute the init code on each CPU.
+	 */
+	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
+
+	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
@@ -964,6 +973,12 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_err;
 
+	err = register_cpu_notifier(&hyp_init_cpu_nb);
+	if (err) {
+		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
+		goto out_err;
+	}
+
 	kvm_coproc_table_init();
 	return 0;
 out_err:
-- 
1.8.1.4
