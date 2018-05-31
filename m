From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 18:32:19 +0100
Subject: [PATCHv2 0/4] arm64: SMCCC conduit cleanup
Message-ID: <20180531173223.9668-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the cpu errata code goes digging into PSCI internals to
discover the SMCCC conduit, using the (arguably misnamed) PSCI_CONDUIT_*
definitions. This lack of abstraction is somewhat unfortunate.

Further, the SDEI code has an almost identical set of CONDUIT_*
definitions, and the duplication is rather unfortunate.

Let's unify things behind a common set of SMCCC_CONDUIT_* definitions,
and expose the SMCCCv1.1 conduit via a new helper that hides the PSCI
driver internals.

Since v1 [1]:
* Rebase to the arm64 for-next/core branch, atop of SSBD patches
* Fold in acks

Mark.

[1] https://lkml.kernel.org/r/20180503170330.5591-1-mark.rutland at arm.com

Mark Rutland (4):
  arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()
  arm64: errata: use arm_smccc_get_conduit()
  firmware/psci: use common SMCCC_CONDUIT_*
  firmware: arm_sdei: use common SMCCC_CONDUIT_*

 arch/arm64/kernel/cpu_errata.c | 34 ++++++++++++----------------------
 arch/arm64/kernel/sdei.c       |  3 ++-
 drivers/firmware/arm_sdei.c    | 12 ++++++------
 drivers/firmware/psci.c        | 24 ++++++++++++++++--------
 include/linux/arm-smccc.h      | 16 ++++++++++++++++
 include/linux/arm_sdei.h       |  6 ------
 include/linux/psci.h           |  9 ++-------
 7 files changed, 54 insertions(+), 50 deletions(-)

-- 
2.11.0
