From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:41 +0100
Subject: [KVMTOOL][PATCH v2 2/9] kvm__arch_init: Don't pass hugetlbfs_path and
 ram_size in parameter
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-3-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure KVM already contains a pointer to the configuration. Both
hugetlbfs_path and ram_size are part of the configuration, so is it not
necessary to path them again in parameter.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arm/kvm.c         | 7 +++++--
 include/kvm/kvm.h | 2 +-
 kvm.c             | 2 +-
 mips/kvm.c        | 5 ++++-
 powerpc/kvm.c     | 5 ++++-
 x86/kvm.c         | 5 ++++-
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arm/kvm.c b/arm/kvm.c
index 5b1f73c..5a68c9a 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -57,10 +57,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 {
 }
 
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	unsigned long alignment;
 
+	/* Convenience aliases */
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
 	 * correlate with the maximum guest page size for virtio-mmio.
@@ -73,7 +76,7 @@ void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 		alignment = SZ_32M;
 	else
 		alignment = SZ_2M;
-	kvm->ram_size = min(ram_size, (u64)ARM_MAX_MEMORY(kvm));
+	kvm->ram_size = min(kvm->cfg.ram_size, (u64)ARM_MAX_MEMORY(kvm));
 	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
 	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 1edacfd..2d58ff4 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -136,7 +136,7 @@ int kvm__enumerate_instances(int (*callback)(const char *name, int pid));
 void kvm__remove_socket(const char *name);
 
 void kvm__arch_set_cmdline(char *cmdline, bool video);
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size);
+void kvm__arch_init(struct kvm *kvm);
 void kvm__arch_delete_ram(struct kvm *kvm);
 int kvm__arch_setup_firmware(struct kvm *kvm);
 int kvm__arch_free_firmware(struct kvm *kvm);
diff --git a/kvm.c b/kvm.c
index 7de825a..9769e85 100644
--- a/kvm.c
+++ b/kvm.c
@@ -386,7 +386,7 @@ int kvm__init(struct kvm *kvm)
 		goto err_vm_fd;
 	}
 
-	kvm__arch_init(kvm, kvm->cfg.hugetlbfs_path, kvm->cfg.ram_size);
+	kvm__arch_init(kvm);
 
 	INIT_LIST_HEAD(&kvm->mem_banks);
 	kvm__init_ram(kvm);
diff --git a/mips/kvm.c b/mips/kvm.c
index 211770d..e2a0c63 100644
--- a/mips/kvm.c
+++ b/mips/kvm.c
@@ -57,9 +57,12 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	int ret;
+	/* Convenience aliases */
+	u64 ram_size = kvm->cfg.ram_size;
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 
 	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
 	kvm->ram_size = ram_size;
diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index 702d67d..034bc46 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -88,10 +88,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	int cap_ppc_rma;
 	unsigned long hpt;
+	/* Convenience aliases */
+	u64 ram_size = kvm->cfg.ram_size;
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 
 	kvm->ram_size		= ram_size;
 
diff --git a/x86/kvm.c b/x86/kvm.c
index 3e0f0b7..5abb41e 100644
--- a/x86/kvm.c
+++ b/x86/kvm.c
@@ -130,10 +130,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 }
 
 /* Architecture-specific KVM init */
-void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+void kvm__arch_init(struct kvm *kvm)
 {
 	struct kvm_pit_config pit_config = { .flags = 0, };
 	int ret;
+	/* Convenience aliases */
+	u64 ram_size = kvm->cfg.ram_size;
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 
 	ret = ioctl(kvm->vm_fd, KVM_SET_TSS_ADDR, 0xfffbd000);
 	if (ret < 0)
-- 
2.11.0
