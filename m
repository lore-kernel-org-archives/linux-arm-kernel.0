From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 20 Aug 2016 00:51:12 -0500
Subject: [PATCH 0/2] Qualcomm SMCCC Session ID Support
Message-ID: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fixes a problem with the recent adoption of the ARM
SMCCC in the Qualcomm SCM firmware.  Qualcomm actually uses the optional
Trusted OS Session ID parameter.  When SCM calls are interrupted, the
session ID field is populated with a value that must be used when the
SCM call is resumed.

The first patch extends the arm_smccc_res structure to contain the
additional a6 result field and modifies the SMCCC ASM macro to store
register 6 in the additional field.  The second patch modifies the
Qualcomm SCM code to use the new result field.

Andy Gross (2):
  arm64: kernel: Add SMC Session ID to results
  firmware: qcom: scm: Fix interrupted SCM calls

 arch/arm64/kernel/asm-offsets.c | 1 +
 arch/arm64/kernel/smccc-call.S  | 1 +
 drivers/firmware/qcom_scm-64.c  | 6 ++++--
 include/linux/arm-smccc.h       | 4 +++-
 4 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.9.1
