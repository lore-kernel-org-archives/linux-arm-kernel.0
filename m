From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 25 Apr 2017 15:39:28 +0100
Subject: [kvmtool PATCH v10 11/15] add kvm__supports_vm_extension()
In-Reply-To: <20170425143932.17235-1-andre.przywara@arm.com>
References: <20170425143932.17235-1-andre.przywara@arm.com>
Message-ID: <20170425143932.17235-12-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM capabilities can be per-VM, in this case the ioctl should be
issued on the VM file descriptor, not on the system fd.
Since this feature is guarded by a (system) capability itself, wrap
the call into a function of its own.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/kvm/kvm.h |  1 +
 kvm.c             | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 4a76ec2..a76a25d 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -129,6 +129,7 @@ static inline bool host_ptr_in_ram(struct kvm *kvm, void *p)
 }
 
 bool kvm__supports_extension(struct kvm *kvm, unsigned int extension);
+bool kvm__supports_vm_extension(struct kvm *kvm, unsigned int extension);
 
 static inline void kvm__set_thread_name(const char *name)
 {
diff --git a/kvm.c b/kvm.c
index 7fa76f7..665ed14 100644
--- a/kvm.c
+++ b/kvm.c
@@ -93,6 +93,34 @@ const char *kvm__get_dir(void)
 	return kvm_dir;
 }
 
+bool kvm__supports_vm_extension(struct kvm *kvm, unsigned int extension)
+{
+	static int supports_vm_ext_check = 0;
+	int ret;
+
+	switch (supports_vm_ext_check) {
+	case 0:
+		ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION,
+			    KVM_CAP_CHECK_EXTENSION_VM);
+		if (ret <= 0) {
+			supports_vm_ext_check = -1;
+			return false;
+		}
+		supports_vm_ext_check = 1;
+		/* fall through */
+	case 1:
+		break;
+	case -1:
+		return false;
+	}
+
+	ret = ioctl(kvm->vm_fd, KVM_CHECK_EXTENSION, extension);
+	if (ret < 0)
+		return false;
+
+	return ret;
+}
+
 bool kvm__supports_extension(struct kvm *kvm, unsigned int extension)
 {
 	int ret;
-- 
2.9.0
