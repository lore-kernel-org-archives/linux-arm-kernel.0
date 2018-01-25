From: ckadabi@codeaurora.org (Channagoud Kadabi)
Date: Thu, 25 Jan 2018 15:55:11 -0800
Subject: [PATCH 0/2] SDM845 System Cache Driver
Message-ID: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements system cache or LLCC(Last Level Cache Controller) driver
for SDM845 SOC. The purpose of the driver is to partition the system cache and
program the settings such as priortiy, lines to probe while doing a look up
in the system cache, low power related settings etc. The partitions are called
cache slices. Each cache slice is associated with size and SCID (System Cache ID)
The driver also provides API for clients to query the cache slice details,
activate and deactivate them.

System cache has other blocks for memory error detection and
AMON (Activity Monitor) for lock up detection.

Since the hardware block has multiple functional units the driver is implemented
to use syscon/regmap interface. The driver can be broadly classified into:

- Core driver: llcc-core.c: This driver initializes the syscon, does common
settings required to enable interrupts and error handling features.

- SOC specific driver: llcc-sdm845.c: Cache partitioning and cache slice
properties for usecases on sdm845 that need to use system cache.

- API : llcc-slice.c: Exports APIs to clients to query cache slice details,
activate and deactivate cache slices.

Channagoud Kadabi (2):
  dt-bindings: Documentation for qcom,llcc
  drivers: soc: Add LLCC driver

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  93 +++++
 drivers/soc/qcom/Kconfig                           |  16 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/llcc-core.c                       | 120 ++++++
 drivers/soc/qcom/llcc-sdm845.c                     | 102 +++++
 drivers/soc/qcom/llcc-slice.c                      | 456 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 | 152 +++++++
 7 files changed, 941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/soc/qcom/llcc-core.c
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
