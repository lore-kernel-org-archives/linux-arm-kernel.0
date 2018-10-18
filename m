From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:43 +0100
Subject: [KVMTOOL][PATCH v2 4/9] Fold kvm__init_ram call in kvm__arch_init
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-5-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The split between kvm__init_ram and kvm__arch_init for setting up the
RAM can be quite subttle. By moving the former call in the later, it
will be possible to make the RAM initialization easier on Arm with multi
RAM banks support.

Note that it is necessary to move the call to kvm__arch_init after the
initialization of the list kvm->mem_banks because kvm__init_ram is
relying on it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arm/kvm.c         | 4 +++-
 include/kvm/kvm.h | 1 -
 kvm.c             | 4 +---
 mips/kvm.c        | 4 +++-
 powerpc/kvm.c     | 4 +++-
 x86/kvm.c         | 4 +++-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arm/kvm.c b/arm/kvm.c
index 5a68c9a..b6ff2e2 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -24,7 +24,7 @@ bool kvm__arch_cpu_supports_vm(void)
 	return true;
 }
 
-void kvm__init_ram(struct kvm *kvm)
+static void kvm__init_ram(struct kvm *kvm)
 {
 	int err;
 	u64 phys_start, phys_size;
@@ -97,6 +97,8 @@ void kvm__arch_init(struct kvm *kvm)
 	/* Create the virtual GIC. */
 	if (gic__create(kvm, kvm->cfg.arch.irqchip))
 		die("Failed to create virtual GIC");
+
+	kvm__init_ram(kvm);
 }
 
 #define FDT_ALIGN	SZ_2M
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 2d58ff4..ee2c5ab 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -90,7 +90,6 @@ int kvm__init(struct kvm *kvm);
 struct kvm *kvm__new(void);
 int kvm__recommended_cpus(struct kvm *kvm);
 int kvm__max_cpus(struct kvm *kvm);
-void kvm__init_ram(struct kvm *kvm);
 int kvm__exit(struct kvm *kvm);
 bool kvm__load_firmware(struct kvm *kvm, const char *firmware_filename);
 bool kvm__load_kernel(struct kvm *kvm, const char *kernel_filename,
diff --git a/kvm.c b/kvm.c
index 9769e85..81e8a70 100644
--- a/kvm.c
+++ b/kvm.c
@@ -386,10 +386,8 @@ int kvm__init(struct kvm *kvm)
 		goto err_vm_fd;
 	}
 
-	kvm__arch_init(kvm);
-
 	INIT_LIST_HEAD(&kvm->mem_banks);
-	kvm__init_ram(kvm);
+	kvm__arch_init(kvm);
 
 	if (!kvm->cfg.firmware_filename) {
 		if (!kvm__load_kernel(kvm, kvm->cfg.kernel_filename,
diff --git a/mips/kvm.c b/mips/kvm.c
index e2a0c63..2ccefe8 100644
--- a/mips/kvm.c
+++ b/mips/kvm.c
@@ -17,7 +17,7 @@ void kvm__arch_read_term(struct kvm *kvm)
 	virtio_console__inject_interrupt(kvm);
 }
 
-void kvm__init_ram(struct kvm *kvm)
+static void kvm__init_ram(struct kvm *kvm)
 {
 	u64	phys_start, phys_size;
 	void	*host_mem;
@@ -75,6 +75,8 @@ void kvm__arch_init(struct kvm *kvm)
 	ret = ioctl(kvm->vm_fd, KVM_CREATE_IRQCHIP);
 	if (ret < 0)
 		die_perror("KVM_CREATE_IRQCHIP ioctl");
+
+	kvm__init_ram(kvm);
 }
 
 void kvm__irq_line(struct kvm *kvm, int irq, int level)
diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index 034bc46..be99598 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -60,7 +60,7 @@ bool kvm__arch_cpu_supports_vm(void)
 	return true;
 }
 
-void kvm__init_ram(struct kvm *kvm)
+static void kvm__init_ram(struct kvm *kvm)
 {
 	u64	phys_start, phys_size;
 	void	*host_mem;
@@ -139,6 +139,8 @@ void kvm__arch_init(struct kvm *kvm)
 			 SPAPR_PCI_MEM_WIN_SIZE,
 			 SPAPR_PCI_IO_WIN_ADDR,
 			 SPAPR_PCI_IO_WIN_SIZE);
+
+	kvm__init_ram(kvm);
 }
 
 void kvm__arch_delete_ram(struct kvm *kvm)
diff --git a/x86/kvm.c b/x86/kvm.c
index 5abb41e..a22fa65 100644
--- a/x86/kvm.c
+++ b/x86/kvm.c
@@ -86,7 +86,7 @@ bool kvm__arch_cpu_supports_vm(void)
  * a gap between 0xe0000000 and 0x100000000 in the guest virtual mem space.
  */
 
-void kvm__init_ram(struct kvm *kvm)
+static void kvm__init_ram(struct kvm *kvm)
 {
 	u64	phys_start, phys_size;
 	void	*host_mem;
@@ -167,6 +167,8 @@ void kvm__arch_init(struct kvm *kvm)
 	ret = ioctl(kvm->vm_fd, KVM_CREATE_IRQCHIP);
 	if (ret < 0)
 		die_perror("KVM_CREATE_IRQCHIP ioctl");
+
+	kvm__init_ram(kvm);
 }
 
 void kvm__arch_delete_ram(struct kvm *kvm)
-- 
2.11.0
