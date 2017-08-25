From: florent.revest@arm.com (Florent Revest)
Date: Fri, 25 Aug 2017 09:31:35 +0100
Subject: [RFC 05/11] KVM: Expose VM/VCPU creation functions
In-Reply-To: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
References: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
Message-ID: <1503649901-5834-6-git-send-email-florent.revest@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that KVM is capable of creating internal virtual machines, the rest of
the kernel needs an API to access this capability.

This patch exposes two functions for VMs and VCPUs creation in kvm_host.h:
 - kvm_create_internal_vm: ensures that kvm->mm is kept NULL at VM creation
 - kvm_vm_create_vcpu: simple alias of kvm_vm_ioctl_create_vcpu for clarity

Signed-off-by: Florent Revest <florent.revest@arm.com>
---
 include/linux/kvm_host.h |  3 +++
 virt/kvm/kvm_main.c      | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 21a6fd6..dd10d3b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -565,6 +565,9 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
                  struct module *module);
 void kvm_exit(void);

+struct kvm *kvm_create_internal_vm(unsigned long type);
+int kvm_vm_create_vcpu(struct kvm *kvm, u32 id);
+
 void kvm_get_kvm(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2e7af1a..c1c8bb6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -733,6 +733,11 @@ static struct kvm *kvm_create_vm(unsigned long type, struct mm_struct *mm)
        return ERR_PTR(r);
 }

+struct kvm *kvm_create_internal_vm(unsigned long type)
+{
+       return kvm_create_vm(type, NULL);
+}
+
 static void kvm_destroy_devices(struct kvm *kvm)
 {
        struct kvm_device *dev, *tmp;
@@ -2549,6 +2554,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
        return r;
 }

+int kvm_vm_create_vcpu(struct kvm *kvm, u32 id)
+{
+       return kvm_vm_ioctl_create_vcpu(kvm, id);
+}
+
 static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 {
        if (sigset) {
--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
