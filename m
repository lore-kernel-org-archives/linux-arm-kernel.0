From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 12:50:16 -0500
Subject: [PATCH v2 0/8] Make deferring probe forever optional
Message-ID: <20180524175024.19874-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series came out of a discussion on the ARM boot-architecture
list[1] about DT forwards and backwards compatibility issues. There are
issues with newer DTs breaking on older, stable kernels. Some of these
are difficult to solve, but cases of optional devices not having
kernel support should be solvable.

I tested this on a RPi3 B with the pinctrl driver forced off. With this
change, the MMC/SD and UART drivers can function without the pinctrl
driver.

v2:
 - Add a DT property for pinctrl to flag using defaults
 - Add a debug timeout to stop deferring some number of seconds after
   initcalls are done (giving modules a chance to load)
 - Split pinctrl support to its own patch
 - WARN when we stop deferring probe for a device
 - Add IOMMU support
 - Add PM domain support

Rob

[1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html


Rob Herring (8):
  driver core: make deferring probe after init optional
  driver core: add a deferred probe timeout
  dt-bindings: pinctrl: add a 'pinctrl-use-default' property
  arm: dts: bcm283x: mark the UART pin muxing nodes with
    pinctrl-use-default
  pinctrl: optionally stop deferring probe at end of initcalls
  iommu: Stop deferring probe at end of initcalls
  iommu: Remove IOMMU_OF_DECLARE
  PM / Domains: Stop deferring probe at the end of initcall

 .../admin-guide/kernel-parameters.txt         |  7 +++
 .../bindings/pinctrl/pinctrl-bindings.txt     |  6 +++
 arch/arm/boot/dts/bcm283x.dtsi                |  2 +
 drivers/base/dd.c                             | 43 +++++++++++++++++++
 drivers/base/power/domain.c                   |  2 +-
 drivers/iommu/arm-smmu-v3.c                   |  2 -
 drivers/iommu/arm-smmu.c                      |  7 ---
 drivers/iommu/exynos-iommu.c                  |  2 -
 drivers/iommu/ipmmu-vmsa.c                    |  3 --
 drivers/iommu/msm_iommu.c                     |  2 -
 drivers/iommu/of_iommu.c                      | 21 +--------
 drivers/iommu/qcom_iommu.c                    |  2 -
 drivers/iommu/rockchip-iommu.c                |  2 -
 drivers/pinctrl/devicetree.c                  | 14 ++++--
 include/linux/device.h                        |  2 +
 include/linux/of_iommu.h                      |  4 --
 16 files changed, 73 insertions(+), 48 deletions(-)

--
2.17.0
