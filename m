From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:45:13 +0100
Subject: [PATCH 57/58] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-58-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

Once we enable ARCH_SUPPORTS_MEMORY_FAILURE on arm64, notifications for
broken memory can call memory_failure() in mm/memory-failure.c to offline
pages of memory, possibly signalling user space processes and notifying all
the in-kernel users.

memory_failure() has two modes, early and late. Early is used by
machine-managers like Qemu to receive a notification when a memory error is
notified to the host. These can then be relayed to the guest before the
affected page is accessed. To enable this, the process must set
PR_MCE_KILL_EARLY in PR_MCE_KILL_SET using the prctl() syscall.

Once the early notification has been handled, nothing stops the
machine-manager or guest from accessing the affected page. If the
machine-manager does this the page will fail to be mapped and SIGBUS will
be sent. This patch adds the equivalent path for when the guest accesses
the page, sending SIGBUS to the machine-manager.

These two signals can be distinguished by the machine-manager using their
si_code: BUS_MCEERR_AO for 'action optional' early notifications, and
BUS_MCEERR_AR for 'action required' synchronous/late notifications.

Do as x86 does, and deliver the SIGBUS when we discover pfn ==
KVM_PFN_ERR_HWPOISON. Use the hugepage size as si_addr_lsb if this vma was
allocated as a hugepage. Transparent hugepages will be split by
memory_failure() before we see them here.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e2e5effba2a9..f2d5b6cf06ae 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -20,6 +20,7 @@
 #include <linux/kvm_host.h>
 #include <linux/io.h>
 #include <linux/hugetlb.h>
+#include <linux/sched/signal.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
@@ -1261,6 +1262,24 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
 	__coherent_cache_guest_page(vcpu, pfn, size);
 }
 
+static void kvm_send_hwpoison_signal(unsigned long address,
+				     struct vm_area_struct *vma)
+{
+	siginfo_t info;
+
+	info.si_signo   = SIGBUS;
+	info.si_errno   = 0;
+	info.si_code    = BUS_MCEERR_AR;
+	info.si_addr    = (void __user *)address;
+
+	if (is_vm_hugetlb_page(vma))
+		info.si_addr_lsb = huge_page_shift(hstate_vma(vma));
+	else
+		info.si_addr_lsb = PAGE_SHIFT;
+
+	send_sig_info(SIGBUS, &info, current);
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1330,6 +1349,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	smp_rmb();
 
 	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
+	if (pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_send_hwpoison_signal(hva, vma);
+		return 0;
+	}
 	if (is_error_noslot_pfn(pfn))
 		return -EFAULT;
 
-- 
2.11.0
