From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Thu, 20 Sep 2018 09:36:18 +0530
Subject: [PATCH V2 0/3] Emulate MRS instructions by parsing ESR_ELx.ISS
Message-ID: <1537416381-13674-1-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armv8.4-A extension enables MRS instruction encodings inside ESR_ELx.ISS
during exception class ESR_ELx_EC_SYS64 (0x18). This encoding can be used
to emulate MRS instructions which can avoid fetch/decode from user space
thus improving performance. The patch series here enables this new method
of emulating MRS instruction. For this purpose we factorizes the existing
emulate_mrs() function and while here, add new macro ESR_ELx_SYS64_ISS_RT.

Changes in V2:

- Replaced the argument 'dst' as 'rt' in second patch per Suzuki
- Added review tags from Suzuki

Anshuman Khandual (3):
  arm64/cpufeatures: Introduce ESR_ELx_SYS64_ISS_RT()
  arm64/cpufeatures: Factorize emulate_mrs()
  arm64/cpufeatures: Emulate MRS instructions by parsing ESR_ELx.ISS

 arch/arm64/include/asm/cpufeature.h  |  1 +
 arch/arm64/include/asm/esr.h         | 14 ++++++++++++++
 arch/arm64/include/asm/kvm_emulate.h |  2 +-
 arch/arm64/kernel/cpufeature.c       | 25 +++++++++++++++----------
 arch/arm64/kernel/traps.c            | 25 +++++++++++++++++++++----
 5 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.7.4
