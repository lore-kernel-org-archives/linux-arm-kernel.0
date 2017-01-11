From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 11 Jan 2017 16:31:56 -0600
Subject: [Patch v3 0/2] Support ARM SMCC SoC vendor quirks
Message-ID: <1484173918-25090-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least one SoC vendor (Qualcomm) requires additional processing done
during ARM SMCCC calls.  As such, an additional parameter to the
arm_smccc_smc is required to be able to handle SoC specific quirks.

The Qualcomm quirk is necessary due to the fact that the scm call can
be interrupted on Qualcomm ARM64 platforms.  When this occurs, the
call must be restarted using information that was passed back during
the original smc call.

The first patch in this series adds a quirk structure and also adds a
quirk parameter to arm_smccc_smc calls.  I added macros to allow users
to choose the API they need.  This keeps all of the current users who
do not need quirks from having to change anything.

The second patch adds the Qualcomm quirk and also implements the
Qualcomm firmware changes required to handle the restarting of the
interrupted SMC call.

The original patch set for the SMCCC session ID is located at:
https://lkml.org/lkml/2016/8/20/7

Changes from v2:
  - Use variadic macros

Changes from v1:
  - Add macros to handle both use cases per review comments

Andy Gross (2):
  arm: kernel: Add SMC structure parameter
  firmware: qcom: scm: Fix interrupted SCM calls

 arch/arm/kernel/armksyms.c      |  2 +-
 arch/arm/kernel/smccc-call.S    |  7 ++++---
 arch/arm64/kernel/arm64ksyms.c  |  2 +-
 arch/arm64/kernel/asm-offsets.c |  7 +++++--
 arch/arm64/kernel/smccc-call.S  | 16 ++++++++++++----
 drivers/firmware/qcom_scm-64.c  | 13 ++++++++++---
 include/linux/arm-smccc.h       | 37 ++++++++++++++++++++++++++++++-------
 7 files changed, 63 insertions(+), 21 deletions(-)

-- 
1.9.1
