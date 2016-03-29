From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:36:56 -0700
Subject: [PATCH v2 0/9] Qualcomm WCNSS remoteproc
Message-ID: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces the remoteproc driver for controlling the Qualcomm
Wireless Connectivity Subsystem (WCNSS). The WCNSS is a builtin ARM9 inside the
Qualcomm SoC with an externally connected RF module (iris).

Supports booting and shutting down wcnss on 8064, 8974 and 8016. The driver
will call the crash handler in remoteproc, but further work is needed in the
framework for this not to bring down the kernel.

Changes since v1:
- Split iris definition into separate driver/dt-node
- Move constants from DT to code
- Make stop-state and some of interrupts optional to properly work on 8064
- Cleaned up and made mdt loader support relocation, which is needed on 8016.
- Add dts patches

Bjorn Andersson (9):
  dt-binding: remoteproc: Introduce Qualcomm WCNSS loader binding
  remoteproc: core: Make the loaded resource table optional
  remoteproc: Add additional crash reasons
  remoteproc: Introduce Qualcomm WCNSS firmware loader
  ARM: dts: qcom: msm8974: Introduce the wcnss remoteproc node
  ARM: dts: qcom: apq8064: Add syscon for sic-non-secure
  ARM: dts: qcom: apq8064: Add complete smsm node
  ARM: dts: qcom: apq8064: Add smd node and all edges
  ARM: dts: qcom: apq8064: Introduce wcnss remoteproc

 .../bindings/remoteproc/qcom,wcnss-pil.txt         | 117 +++++
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |   4 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 151 ++++++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  32 ++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  36 +-
 drivers/remoteproc/Kconfig                         |  12 +
 drivers/remoteproc/Makefile                        |   2 +
 drivers/remoteproc/qcom_mdt_loader.c               | 172 ++++++
 drivers/remoteproc/qcom_mdt_loader.h               |   7 +
 drivers/remoteproc/qcom_wcnss.c                    | 579 +++++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.h                    |  22 +
 drivers/remoteproc/qcom_wcnss_iris.c               | 185 +++++++
 drivers/remoteproc/remoteproc_core.c               |  10 +-
 include/linux/remoteproc.h                         |   4 +
 14 files changed, 1326 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 drivers/remoteproc/qcom_mdt_loader.c
 create mode 100644 drivers/remoteproc/qcom_mdt_loader.h
 create mode 100644 drivers/remoteproc/qcom_wcnss.c
 create mode 100644 drivers/remoteproc/qcom_wcnss.h
 create mode 100644 drivers/remoteproc/qcom_wcnss_iris.c

-- 
2.5.0
