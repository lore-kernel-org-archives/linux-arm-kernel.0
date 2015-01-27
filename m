From: agross@codeaurora.org (Andy Gross)
Date: Tue, 27 Jan 2015 16:10:38 -0600
Subject: [PATCH 0/6] GSBI CRCI Autoconfiguration Support
Message-ID: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for automatic configuration of GSBI DMA CRCI values.

DMA operations require that the ADM CRCI mux values be properly configured in
the TCSR (Top Control and Status Register) block.  During probing of a GSBI
device, the client mode must be declared and this can be used to lookup the
correct TCSR ADM CRCI MUX settings and then program them so that they are
correct before any clients are populated.

These patches add the TCSR as a syscon device and that allows the GSBI to
access and manipulate the ADM CRCI MUX registers to correctly configure the
values based on the GSBI port configuration.

Andy Gross (6):
  soc: qcom: gsbi: Add support for ADM CRCI muxing
  mfd: qcom,tcsr: Add device tree binding for TCSR
  ARM: DT: apq8064: Add TCSR support
  ARM: DT: ipq8064: Add TCSR support
  ARM: DT: msm8660: Add TCSR support
  ARM: DT: msm8960: Add TCSR support

 .../devicetree/bindings/mfd/qcom,tcsr.txt          |   22 +++
 .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     |   17 ++-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   20 ++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   20 ++-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |   10 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi                |   10 +-
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/qcom_gsbi.c                       |  148 +++++++++++++++++++-
 8 files changed, 232 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
