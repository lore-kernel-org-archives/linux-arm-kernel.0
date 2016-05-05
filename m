From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 May 2016 18:33:05 +0100
Subject: [PATCH] kvm: arm64: Enable hardware updates of the Access Flag
 for Stage 2 page tables
In-Reply-To: <1460566657-30221-1-git-send-email-catalin.marinas@arm.com>
References: <1460566657-30221-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <572B83D1.10600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 17:57, Catalin Marinas wrote:
> The ARMv8.1 architecture extensions introduce support for hardware
> updates of the access and dirty information in page table entries. With
> VTCR_EL2.HA enabled (bit 21), when the CPU accesses an IPA with the
> PTE_AF bit cleared in the stage 2 page table, instead of raising an
> Access Flag fault to EL2 the CPU sets the actual page table entry bit
> (10). To ensure that kernel modifications to the page table do not
> inadvertently revert a bit set by hardware updates, certain Stage 2
> software pte/pmd operations must be performed atomically.
> 
> The main user of the AF bit is the kvm_age_hva() mechanism. The
> kvm_age_hva_handler() function performs a "test and clear young" action
> on the pte/pmd. This needs to be atomic in respect of automatic hardware
> updates of the AF bit. Since the AF bit is in the same position for both
> Stage 1 and Stage 2, the patch reuses the existing
> ptep_test_and_clear_young() functionality if
> __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG is defined. Otherwise, the
> existing pte_young/pte_mkold mechanism is preserved.
> 
> The kvm_set_s2pte_readonly() (and the corresponding pmd equivalent) have
> to perform atomic modifications in order to avoid a race with updates of
> the AF bit. The arm64 implementation has been re-written using
> exclusives.
> 
> Currently, kvm_set_s2pte_writable() (and pmd equivalent) take a pointer
> argument and modify the pte/pmd in place. However, these functions are
> only used on local variables rather than actual page table entries, so
> it makes more sense to follow the pte_mkwrite() approach for stage 1
> attributes. The change to kvm_s2pte_mkwrite() makes it clear that these
> functions do not modify the actual page table entries.
> 
> The (pte|pmd)_mkyoung() uses on Stage 2 entries (setting the AF bit
> explicitly) do not need to be modified since hardware updates of the
> dirty status are not supported by KVM, so there is no possibility of
> losing such information.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Christoffer: assuming you're happy with that patch, could you queue it
for 4.7?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
