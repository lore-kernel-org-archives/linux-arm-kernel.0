From: florent.revest@arm.com (Florent Revest)
Date: Fri, 25 Aug 2017 09:31:37 +0100
Subject: [RFC 07/11] KVM: Allow initialization before the module target
In-Reply-To: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
References: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
Message-ID: <1503649901-5834-8-git-send-email-florent.revest@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kvm_init function has been designed to be executed during the
module_init target. It requires a struct module pointer to be used as
the owner of the /dev/* files and also tries to register /dev/kvm with a
function (misc_register) that can only be used late in the boot process.

This patch modifies kvm_init to execute this late initialization code
conditionally, only in the context of a module_init. It also offers a
kvm_set_module function to be used for /dev/kvm registration and device
files owning once the module target is reached.

As is, this patch does not change anything. However it could be used by
certain architectures to initialize the core of kvm earlier in the boot
(e.g: in a subsys_initcall) and then initialize the userspace facing files
in a module_init target. This can be useful to create internal VMs before
being able to offer the userspace APIs.

Signed-off-by: Florent Revest <florent.revest@arm.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dd10d3b..15a0a8d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -563,6 +563,7 @@ static inline void kvm_irqfd_exit(void)
 #endif
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
                  struct module *module);
+int kvm_set_module(struct module *module);
 void kvm_exit(void);

 struct kvm *kvm_create_internal_vm(unsigned long type);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c1c8bb6..3c9cb00 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4086,14 +4086,10 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
        if (r)
                goto out_free;

-       kvm_chardev_ops.owner = module;
-       kvm_vm_fops.owner = module;
-       kvm_vcpu_fops.owner = module;
-
-       r = misc_register(&kvm_dev);
-       if (r) {
-               pr_err("kvm: misc device register failed\n");
-               goto out_unreg;
+       if (module) {
+               r = kvm_set_module(module);
+               if (r)
+                       goto out_unreg;
        }

        register_syscore_ops(&kvm_syscore_ops);
@@ -4136,6 +4132,22 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 }
 EXPORT_SYMBOL_GPL(kvm_init);

+int kvm_set_module(struct module *module)
+{
+       int r;
+
+       kvm_chardev_ops.owner = module;
+       kvm_vm_fops.owner = module;
+       kvm_vcpu_fops.owner = module;
+
+       r = misc_register(&kvm_dev);
+       if (r)
+               pr_err("kvm: misc device register failed\n");
+
+       return r;
+}
+EXPORT_SYMBOL_GPL(kvm_set_module);
+
 void kvm_exit(void)
 {
        debugfs_remove_recursive(kvm_debugfs_dir);
--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
