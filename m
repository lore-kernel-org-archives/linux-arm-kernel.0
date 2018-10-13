From: lantianyu1986@gmail.com (lantianyu1986 at gmail.com)
Date: Sat, 13 Oct 2018 22:53:51 +0800
Subject: [PATCH V4 00/15] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
Message-ID: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

For nested memory virtualization, Hyper-v doesn't set write-protect
L1 hypervisor EPT page directory and page table node to track changes 
while it relies on guest to tell it changes via HvFlushGuestAddressLlist
hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
EPT page table with ranges which are specified by L1 hypervisor.

If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
and sync L1's EPT table when next EPT page fault is triggered.
HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
page fault and synchronization of shadow page table.


Change since v3:
	1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
	2) Remove directly tlb flush in the kvm_handle_hva_range()
	3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
	4) Combine Vitaly's "don't pass EPT configuration info to
vmx_hv_remote_flush_tlb()" fix

Change since v2:
       1) Fix comment in the kvm_flush_remote_tlbs_with_range()
       2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
	hyperv-tlfs.h.
       3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
       4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
	struct hv_guest_mapping_flush_list.

Change since v1:
       1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
          to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
       2) Add hyperv tlb range struct and replace kvm tlb range struct
          with new struct in order to avoid using kvm struct in the hyperv
	  code directly.



Lan Tianyu (15):
  KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
  KVM/MMU: Add tlb flush with range helper function
  KVM: Replace old tlb flush function with new one to flush a specified
    range.
  KVM: Make kvm_set_spte_hva() return int
  KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
    kvm_mmu_notifier_change_pte()
  KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
  KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
  KVM/MMU: Flush tlb directly in kvm_mmu_zap_collapsible_spte()
  KVM: Add flush_link and parent_pte in the struct kvm_mmu_page
  KVM: Add spte's point in the struct kvm_mmu_page
  KVM/MMU: Replace tlb flush function with range list flush function
  x86/hyper-v: Add HvFlushGuestAddressList hypercall support
  x86/Hyper-v: Add trace in the
    hyperv_nested_flush_guest_mapping_range()
  KVM/VMX: Change hv flush logic when ept tables are mismatched.
  KVM/VMX: Add hv tlb range flush support

 arch/arm/include/asm/kvm_host.h     |   2 +-
 arch/arm64/include/asm/kvm_host.h   |   2 +-
 arch/mips/include/asm/kvm_host.h    |   2 +-
 arch/mips/kvm/mmu.c                 |   3 +-
 arch/powerpc/include/asm/kvm_host.h |   2 +-
 arch/powerpc/kvm/book3s.c           |   3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |   3 +-
 arch/x86/hyperv/nested.c            |  85 ++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  32 +++++++++
 arch/x86/include/asm/kvm_host.h     |  12 +++-
 arch/x86/include/asm/mshyperv.h     |  16 +++++
 arch/x86/include/asm/trace/hyperv.h |  14 ++++
 arch/x86/kvm/mmu.c                  | 138 ++++++++++++++++++++++++++++++------
 arch/x86/kvm/paging_tmpl.h          |  10 ++-
 arch/x86/kvm/vmx.c                  |  70 +++++++++++++++---
 virt/kvm/arm/mmu.c                  |   6 +-
 virt/kvm/kvm_main.c                 |   5 +-
 17 files changed, 360 insertions(+), 45 deletions(-)

-- 
2.14.4
