From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 17 Jul 2014 19:17:31 +0300
Subject: [PATCH v2 0/4] Support for Qualcomm QPNP PMIC's
Message-ID: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Here is the continuation of patch sets sent recently about Qualcomm
QPNP SPMI PMICs.

The previous version of the patch set can be found at [1].

Changes since v1:
 - removed completely custom *of* parser
 - renamed the mfd driver from qpnp-spmi to pm8xxx-spmi
 - now MFD_PM8XXX_SPMI Kconfig option depends on SPMI

Removing of the custom *of* parser leads to that that the *reg* devicetree
property cannot exist and therefore cannot be parsed to get PMIC peripheral
resources. I took this step aside because no one from mfd drivers does this
parsing. This will lead to inconvenience in the peripheral drivers to define
internally the SPMI base addresses depending on the compatible property
i.e. PMIC version. 

Comments are welcome!

regards,
Stan

[1] https://lkml.org/lkml/2014/7/8/428

Josh Cartwright (1):
  mfd: pm8xxx-spmi: add support for Qualcomm SPMI PMICs

Stanimir Varbanov (3):
  mfd: pm8xxx-spmi: document DT bindings for Qualcomm SPMI PMICs
  ARM: DT: qcom: add pm8941 and pm8841 device nodes
  mfd: pm8921: rename pm8921-core driver

 .../devicetree/bindings/mfd/qcom,pm8xxx-spmi.txt   |   49 +++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   37 ++++++++++++
 drivers/mfd/Kconfig                                |   30 +++++++--
 drivers/mfd/Makefile                               |    3 +-
 drivers/mfd/pm8xxx-spmi.c                          |   63 ++++++++++++++++++++
 drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c}       |   38 ++++++------
 6 files changed, 193 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8xxx-spmi.txt
 create mode 100644 drivers/mfd/pm8xxx-spmi.c
 rename drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} (92%)
