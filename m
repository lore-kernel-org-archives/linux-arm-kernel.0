From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Apr 2016 18:08:37 -0500
Subject: [Patch v2 0/8] Qualcomm SCM Rework
Message-ID: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following set of patches does a bit of rework on the existing
Qualcomm SCM firmware.  The first couple of patches deals with turning
the current SCM into a platform driver.  The next couple are cleanups
that make adding the 64 support a little easier.

I took Kumar's 64 bit support patch and modified it to use the arm_smccc
calls.  This simplified things quite a bit.

Lastly, there are a few DT patches to add the firmware node for a couple of the
supported platforms.

Change from v1:
  * Changed binding to reflect proper firmware node usage
  * Added arch_initcall to populate the firmware device, if present
  * Fixed various review comments
  * Removed extraneous includes from SCM 64 file.

Andy Gross (7):
  dt/bindings: firmware: Add Qualcomm SCM binding
  firmware: qcom: scm: Convert SCM to platform driver
  firmware: qcom: scm: Generalize shared error map
  firmware: qcom: scm: Add memory allocation API
  firmware: qcom: scm: Use atomic SCM for cold boot
  dts: qcom: apq8084: Add SCM firmware node
  arm64: dts: msm8916: Add SCM firmware node

Kumar Gala (1):
  firmware: qcom: scm: Add support for ARM64 SoCs

 .../devicetree/bindings/firmware/qcom,scm.txt      |  28 +++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   8 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   8 +
 drivers/firmware/qcom_scm-32.c                     |  68 +++-----
 drivers/firmware/qcom_scm-64.c                     | 187 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.c                        | 181 +++++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  25 +++
 8 files changed, 448 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt

-- 
1.9.1
