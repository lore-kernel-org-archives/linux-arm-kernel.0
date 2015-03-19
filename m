From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 19 Mar 2015 13:32:19 +0530
Subject: [PATCH v2 0/6] Add support for QCOM GDSCs
Message-ID: <1426752145-4365-1-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GDSCs (Global Distributed Switch Controllers) control switches
that supply power to an on-chip power domain and hence can be
programmed in SW to safely power collapse and restore power to the
respective PDs. They are part of a considerable number of recent QCOM
SoCs (This series adds support for msm8974, msm8916 and apq8084 devices)
and are part of the Clock control block.

The series implements support for GDSC using the genpd framework
modelling these as SW controllable power domains.

* Patch 3/6 has a dependency on 8916 GCC support series [1]
* Client drivers which plan to use GDSC can refer to
  Documentation/devicetree/bindings/power/power_domain.txt to know
  how to hook up the power domain for the device through DT
* Runtime PM specific documentation can be found in
  Documentation/power/runtime_pm.txt

Changes since v1:
* added err checks for regmap apis
* added gdsc_register() in gdsc.c

[1] https://lkml.org/lkml/2015/3/18/408

Rajendra Nayak (3):
  clk: qcom: gdsc: Prepare common clk probe to register gdscs
  clk: qcom: gdsc: Add GDSCs in msm8916 GCC
  clk: qcom: gdsc: Add GDSCs in apq8084 GCC

Stephen Boyd (3):
  clk: qcom: Add support for GDSCs
  clk: qcom: gdsc: Add GDSCs in msm8974 GCC
  clk: qcom: gdsc: Add GDSCs in msm8974 MMCC

 arch/arm/boot/dts/qcom-apq8084.dtsi           |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   2 +
 drivers/clk/qcom/Kconfig                      |   9 ++
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/common.c                     |  14 ++-
 drivers/clk/qcom/common.h                     |   2 +
 drivers/clk/qcom/gcc-apq8084.c                |  38 ++++++
 drivers/clk/qcom/gcc-msm8916.c                |  46 ++++++++
 drivers/clk/qcom/gcc-msm8974.c                |  14 +++
 drivers/clk/qcom/gdsc.c                       | 161 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h                       |  43 +++++++
 drivers/clk/qcom/mmcc-msm8974.c               |  54 +++++++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h  |   6 +
 include/dt-bindings/clock/qcom,gcc-msm8916.h  |   8 ++
 include/dt-bindings/clock/qcom,gcc-msm8974.h  |   3 +
 include/dt-bindings/clock/qcom,mmcc-msm8974.h |   8 ++
 16 files changed, 409 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/gdsc.c
 create mode 100644 drivers/clk/qcom/gdsc.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
