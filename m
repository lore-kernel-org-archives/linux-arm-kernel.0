From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 31 Jul 2018 14:08:55 +0100
Subject: [PATCH v6 0/3] Support Common Not Private translations
Message-ID: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common Not Private (CNP) translations is a feature of ARMv8.2
extension which allows translation table entries to be shared between
different PEs in the same inner shareable domain, so the hardware can
use this fact to optimise the caching of such entries in the TLB.

This patch set is an attempt to bring CNP support into Linux. It was
tested on a v8.2 Fast Model with exploring traces and checking that
TTBRx_ELy and VTTBR_EL2 have CnP bit set where appropriate.

Changelog:

	 v5 -> v6
	    - fix CONFIG_ARM64_PA_BITS_52 (per Catalin)
	    - is_kdump_kernel() instead of elfcorehdr_size (per Suzuki)
	    - rebased on 4.18-rc6

	 v4 -> v5
	    - cleanups and comment/commit improvements (per James)
	    - VTTBR_CNP_BIT instead of a hard-coded value (per Catalin)
	    - rebased on 4.18-rc1

	 v3 -> v4
	    - rebased on 4.17-rc4 for real

	 v2 -> v3
	    - do not enable CNP if we are crush kernel (per James)
	    - default to "no"
	    - rebased on 4.17-rc4

  	 v1 -> v2
            - handle cpuilde case (per James)
	    - use lm_allias with swapper_pg_dir (per James)
            - rule out ARM64_SW_TTBR0_PAN case (per Catalin)
	    - s/BUG_ON/WARN_ON/ (per Catalin)
	    - comment and commit message updates (per Catalin)
	    - TTBR_CNP_BIT moved to asm/pgtable-hwdef.h (per Catalin)
	    - has_useable_cnp() simplified (per Julien)

	RFC -> v1
            - dropped RFC tag
            - rebased on 4.14-rc4

Thanks!

Vladimir Murzin (3):
  arm64: mm: Support Common Not Private translations
  arm64: KVM: Enable Common Not Private translations
  arm64: Introduce command line parameter to disable CNP

 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 arch/arm/include/asm/kvm_arm.h                  |  1 +
 arch/arm/include/asm/kvm_mmu.h                  |  5 +++
 arch/arm64/Kconfig                              | 13 ++++++++
 arch/arm64/include/asm/cpucaps.h                |  3 +-
 arch/arm64/include/asm/cpufeature.h             |  6 ++++
 arch/arm64/include/asm/kvm_arm.h                |  1 +
 arch/arm64/include/asm/kvm_mmu.h                |  5 +++
 arch/arm64/include/asm/mmu_context.h            | 17 ++++++++--
 arch/arm64/include/asm/pgtable-hwdef.h          |  2 ++
 arch/arm64/kernel/cpufeature.c                  | 43 +++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c                     |  4 +++
 arch/arm64/kvm/hyp-init.S                       |  3 ++
 arch/arm64/mm/context.c                         |  3 ++
 arch/arm64/mm/proc.S                            | 11 +++++--
 virt/kvm/arm/arm.c                              |  4 +--
 16 files changed, 117 insertions(+), 8 deletions(-)

-- 
2.0.0
