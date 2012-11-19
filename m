From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:53:51 +0000
Subject: [PATCH v4 06/14] KVM: ARM: Memory virtualization setup
In-Reply-To: <20121110154252.2836.8720.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154252.2836.8720.stgit@chazy-air>
Message-ID: <20121119145351.GY3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:42:52PM +0000, Christoffer Dall wrote:
> This commit introduces the framework for guest memory management
> through the use of 2nd stage translation. Each VM has a pointer
> to a level-1 table (the pgd field in struct kvm_arch) which is
> used for the 2nd stage translations. Entries are added when handling
> guest faults (later patch) and the table itself can be allocated and
> freed through the following functions implemented in
> arch/arm/kvm/arm_mmu.c:
>  - kvm_alloc_stage2_pgd(struct kvm *kvm);
>  - kvm_free_stage2_pgd(struct kvm *kvm);
> 
> Each entry in TLBs and caches are tagged with a VMID identifier in
> addition to ASIDs. The VMIDs are assigned consecutively to VMs in the
> order that VMs are executed, and caches and tlbs are invalidated when
> the VMID space has been used to allow for more than 255 simultaenously
> running guests.
> 
> The 2nd stage pgd is allocated in kvm_arch_init_vm(). The table is
> freed in kvm_arch_destroy_vm(). Both functions are called from the main
> KVM code.
> 
> We pre-allocate page table memory to be able to synchronize using a
> spinlock and be called under rcu_read_lock from the MMU notifiers.  We
> steal the mmu_memory_cache implementation from x86 and adapt for our
> specific usage.
> 
> We support MMU notifiers (thanks to Marc Zyngier) through
> kvm_unmap_hva and kvm_set_spte_hva.
> 
> Finally, define kvm_phys_addr_ioremap() to map a device at a guest IPA,
> which is used by VGIC support to map the virtual CPU interface registers
> to the guest. This support is added by Marc Zyngier.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

Modulo my other comments, this patch looks alright to me. I'll go through
with acks for the next series. In the meantime, I'll just skip over the
patches that look ok.

Cheers,

Will
