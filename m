From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 26 Sep 2018 17:32:55 +0100
Subject: [kvmtool PATCH v6 19/18] kvmtool: Allow backends to run checks on the
 KVM device fd
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
Message-ID: <20180926163258.20218-20-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow architectures to perform initialisation based on the
KVM device fd ioctls, even before the VM is created.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/kvm/kvm.h | 4 ++++
 kvm.c             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 1edacfd..dc3f0dd 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -135,6 +135,10 @@ int kvm__get_sock_by_instance(const char *name);
 int kvm__enumerate_instances(int (*callback)(const char *name, int pid));
 void kvm__remove_socket(const char *name);
 
+#ifndef kvm__arch_init_hyp
+static inline void kvm__arch_init_hyp(struct kvm *kvm) {}
+#endif
+
 void kvm__arch_set_cmdline(char *cmdline, bool video);
 void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size);
 void kvm__arch_delete_ram(struct kvm *kvm);
diff --git a/kvm.c b/kvm.c
index 7de825a..0894778 100644
--- a/kvm.c
+++ b/kvm.c
@@ -373,6 +373,8 @@ int kvm__init(struct kvm *kvm)
 		goto err_sys_fd;
 	}
 
+	kvm__arch_init_hyp(kvm);
+
 	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
 	if (kvm->vm_fd < 0) {
 		pr_err("KVM_CREATE_VM ioctl");
-- 
2.19.0
