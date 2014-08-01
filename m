From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri,  1 Aug 2014 17:30:47 +0300
Subject: [PATCH v4 0/3] Support for Qualcomm QPNP PMIC's
Message-ID: <1406903450-27283-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Changes since v3:
 - rename the driver to qcom-spmi-pmic - suggested by David Collins
 - spmi regmap config now initialize .fast_io to true
 - added generalized comptatible string in DT binding document and driver
 - I dropped the pm8921 rename patch for now, it will be subject of another
   patchset later on.

regards,
Stan

--------------------------------------------------------------------------------

Changes since v2:
 - 1/4 - added new line, signed-off-by / acked-by and module_authors.
 - 3/4 - the subject has been changed.

The previous v2 can be found at [1].

I'm still waiting Acks for:
 - 4/4 from Qualcomm folks.
 - 2/4 and 3/4 from DT folks.

The patchset is ready to merge version and also it can be treated as an
intermediate step until we find a solution for non-translatable peripheral
addresses.

[1] https://lkml.org/lkml/2014/7/17/877

--------------------------------------------------------------------------------

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

[1] https://lkml.org/lkml/2014/7/8/428

--------------------------------------------------------------------------------

Josh Cartwright (1):
  mfd: add support for Qualcomm SPMI PMICs

Stanimir Varbanov (2):
  mfd: document DT bindings for Qualcomm SPMI PMICs
  ARM: dts: qcom: add pm8941 and pm8841 PMICs device nodes

 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |   64 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   37 +++++++++++
 drivers/mfd/Kconfig                                |   15 +++++
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/qcom-spmi-pmic.c                       |   67 ++++++++++++++++++++
 5 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
 create mode 100644 drivers/mfd/qcom-spmi-pmic.c
