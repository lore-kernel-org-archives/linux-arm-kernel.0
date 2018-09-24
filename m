From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 14:11:28 +0200
Subject: [REVIEW][PATCH 4/4] signal/arm/kvm: Use send_sig_mceerr
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
Message-ID: <20180924121128.5983-4-ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the code making it clearer what is going on, and
making the siginfo generation easier to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 virt/kvm/arm/mmu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 91aaf73b00df..39c0405f2021 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1450,20 +1450,14 @@ static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
 static void kvm_send_hwpoison_signal(unsigned long address,
 				     struct vm_area_struct *vma)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo   = SIGBUS;
-	info.si_errno   = 0;
-	info.si_code    = BUS_MCEERR_AR;
-	info.si_addr    = (void __user *)address;
+	short lsb;
 
 	if (is_vm_hugetlb_page(vma))
-		info.si_addr_lsb = huge_page_shift(hstate_vma(vma));
+		lsb = huge_page_shift(hstate_vma(vma));
 	else
-		info.si_addr_lsb = PAGE_SHIFT;
+		lsb = PAGE_SHIFT;
 
-	send_sig_info(SIGBUS, &info, current);
+	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-- 
2.17.1
