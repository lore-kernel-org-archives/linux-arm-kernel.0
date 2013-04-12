From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 19:12:07 +0100
Subject: [PATCH v4 7/7] ARM: KVM: perform HYP initilization for hotplugged CPUs
In-Reply-To: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1365790327-2138-8-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/include/asm/kvm_mmu.h |  1 +
 arch/arm/kvm/arm.c             | 49 +++++++++++++++++++++++++++++-------------
 arch/arm/kvm/mmu.c             | 35 ++++++++++++++++++++++++------
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 24b767a..472ac70 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -44,6 +44,7 @@
 
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
+void free_boot_hyp_pgd(void);
 void free_hyp_pgds(void);
 
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f8fbab3..fa177df 100644
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
@@ -926,6 +935,10 @@ static int init_hyp_mode(void)
 	if (err)
 		goto out_free_mappings;
 
+#ifndef CONFIG_HOTPLUG_CPU
+	free_boot_hyp_pgd();
+#endif
+
 	kvm_perf_init();
 
 	kvm_info("Hyp mode initialized successfully\n");
@@ -964,6 +977,12 @@ int kvm_arch_init(void *opaque)
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
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 4646c17..9657065 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -156,6 +156,31 @@ static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
 }
 
 /**
+ * free_boot_hyp_pgd - free HYP boot page tables
+ *
+ * Free the HYP boot page tables. The bounce page is also freed.
+ */
+void free_boot_hyp_pgd(void)
+{
+	mutex_lock(&kvm_hyp_pgd_mutex);
+
+	if (boot_hyp_pgd) {
+		unmap_range(boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
+		unmap_range(boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
+		kfree(boot_hyp_pgd);
+		boot_hyp_pgd = NULL;
+	}
+
+	if (hyp_pgd)
+		unmap_range(hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
+
+	kfree(init_bounce_page);
+	init_bounce_page = NULL;
+
+	mutex_unlock(&kvm_hyp_pgd_mutex);
+}
+
+/**
  * free_hyp_pgds - free Hyp-mode page tables
  *
  * Assumes hyp_pgd is a page table used strictly in Hyp-mode and
@@ -169,13 +194,9 @@ void free_hyp_pgds(void)
 {
 	unsigned long addr;
 
-	mutex_lock(&kvm_hyp_pgd_mutex);
+	free_boot_hyp_pgd();
 
-	if (boot_hyp_pgd) {
-		unmap_range(boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
-		unmap_range(boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
-		kfree(boot_hyp_pgd);
-	}
+	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	if (hyp_pgd) {
 		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
@@ -183,9 +204,9 @@ void free_hyp_pgds(void)
 		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
 			unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
 		kfree(hyp_pgd);
+		hyp_pgd = NULL;
 	}
 
-	kfree(init_bounce_page);
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
-- 
1.8.1.4
