From: marek.majtyka@tieto.com (marek.majtyka)
Date: Wed, 16 Sep 2015 12:04:55 +0200
Subject: [PATCH] kvm: arm: LPAE: Incorrect device to IPA mapping
Message-ID: <1442397895-2124-1-git-send-email-marek.majtyka@tieto.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Majtyka <marek.majtyka@tieto.com>

A critical bug has been found in device memory stage1 translation for machines
with more then 4GB of RAM. Once vm_pgoff size is smaller then pa (which is true
for LPAE case, u32 and u64 respectively) some more significant bits of pa may
be lost as a shift operation is performed on u32 and later cast onto u64.

Example: vm_pgoff(u32)=0x00210030, PAGE_SHIFT=12
        expected pa(u64):   0x0000002010030000
        produced pa(u64):   0x0000000010030000

A suggested fix is changing the order of operations (casting first onto
phys_addr_t and then shifting), which works for both alternatives
(with and without LPAE).

A bug has been found, fixed and tested on kernel v3.19. However, it seems to be
valid for most, if not all, newer version starting from v3.18.

Signed-off-by: Marek Majtyka <marek.majtyka@tieto.com>
---
 arch/arm/kvm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1366625..602bc63 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1408,7 +1408,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (vma->vm_flags & VM_PFNMAP) {
 			gpa_t gpa = mem->guest_phys_addr +
 				    (vm_start - mem->userspace_addr);
-			phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) +
+			phys_addr_t pa =
+				((phys_addr_t) vma->vm_pgoff << PAGE_SHIFT) +
 					 vm_start - vma->vm_start;
 
 			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
-- 
1.9.1
