From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 23 Mar 2017 21:01:01 +0800
Subject: [PATCH] arm/arm64: KVM: send SIGBUS error to qemu
Message-ID: <1490274061-487-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when the pfn is KVM_PFN_ERR_HWPOISON, it indicates to send
SIGBUS signal from KVM's fault-handling code to qemu, qemu
can handle this signal according to the fault address.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm/kvm/mmu.c       | 20 ++++++++++++++++++++
 include/linux/kvm_host.h |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 962616fd4ddd..1307ec400de3 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1237,6 +1237,20 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
 	__coherent_cache_guest_page(vcpu, pfn, size);
 }
 
+static void kvm_send_hwpoison_signal(unsigned long address,
+					struct task_struct *tsk)
+{
+	siginfo_t info;
+
+	info.si_signo	= SIGBUS;
+	info.si_errno	= 0;
+	info.si_code	= BUS_MCEERR_AR;
+	info.si_addr	= (void __user *)address;
+	info.si_addr_lsb = PAGE_SHIFT;
+
+	send_sig_info(SIGBUS, &info, tsk);
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1309,6 +1323,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (is_error_noslot_pfn(pfn))
 		return -EFAULT;
 
+	if (is_error_hwpoison_pfn(pfn)) {
+		kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn),
+								current);
+		return -EFAULT;
+	}
+
 	if (kvm_is_device_pfn(pfn)) {
 		mem_type = PAGE_S2_DEVICE;
 		flags |= KVM_S2PTE_FLAG_IS_IOMAP;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2c14ad9809da..610ded9ebe9b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -91,6 +91,11 @@ static inline bool is_noslot_pfn(kvm_pfn_t pfn)
 {
 	return pfn == KVM_PFN_NOSLOT;
 }
+/* hwpoison pfn indicates that it needs to send SIGBUS */
+static inline bool is_error_hwpoison_pfn(kvm_pfn_t pfn)
+{
+	return pfn == KVM_PFN_ERR_HWPOISON;
+}
 
 /*
  * architectures with KVM_HVA_ERR_BAD other than PAGE_OFFSET (e.g. s390)
-- 
2.11.0
