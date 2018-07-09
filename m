From: robh@kernel.org (Rob Herring)
Date: Mon,  9 Jul 2018 09:41:47 -0600
Subject: [PATCH v4 0/6] Make deferring probe forever optional
Message-ID: <20180709154153.15742-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series came out of a discussion on the ARM boot-architecture
list[1] about DT forwards and backwards compatibility issues. There are
issues with newer DTs breaking on older, stable kernels. Some of these
are difficult to solve, but cases of optional devices not having
kernel support should be solvable.

I tested this on a RPi3 B with the pinctrl driver forced off. With this
change, the MMC/SD and UART drivers can function without the pinctrl
driver. I left the dts change out this time.

v2 and v3 of this series can be found here[2][3].

Rob

[1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=347413
[3] https://lore.kernel.org/patchwork/project/lkml/list/?series=357344

Rob Herring (6):
  driver core: allow stopping deferred probe after init
  dt-bindings: pinctrl: add a 'pinctrl-use-default' property
  pinctrl: Support stopping deferred probe after initcalls
  iommu: Stop deferring probe at end of initcalls
  iommu: Remove IOMMU_OF_DECLARE
  PM / Domains: Stop deferring probe at the end of initcall

 .../admin-guide/kernel-parameters.txt         |  9 +++
 .../bindings/pinctrl/pinctrl-bindings.txt     |  6 ++
 drivers/base/dd.c                             | 59 +++++++++++++++++++
 drivers/base/power/domain.c                   |  2 +-
 drivers/iommu/arm-smmu-v3.c                   |  2 -
 drivers/iommu/arm-smmu.c                      |  7 ---
 drivers/iommu/exynos-iommu.c                  |  2 -
 drivers/iommu/ipmmu-vmsa.c                    |  3 -
 drivers/iommu/msm_iommu.c                     |  2 -
 drivers/iommu/of_iommu.c                      | 21 +------
 drivers/iommu/qcom_iommu.c                    |  2 -
 drivers/iommu/rockchip-iommu.c                |  2 -
 drivers/pinctrl/devicetree.c                  | 15 +++--
 include/asm-generic/vmlinux.lds.h             |  2 -
 include/linux/device.h                        |  2 +
 include/linux/of_iommu.h                      |  4 --
 16 files changed, 90 insertions(+), 50 deletions(-)

--
2.17.1
