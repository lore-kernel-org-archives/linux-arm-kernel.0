From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:05 +0530
Subject: [PATCH v2 00/10] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds Reset Controller (RMU) support for Actions Semi
Owl SoCs, S900 and S700. For the Owl SoCs, RMU's registers has been
integrated into the CMU memory map in hardware. Hence, in this patchset
the CMU driver has been converted to syscon so that the same memory map
can be resued by both CMU and RMU drivers. Finally, the support for RMU
in S700 and S900 SoCs are added.

This patch series depends on the recently posted S700 clk series:
"[PATCH v7 0/5] Add clock driver for Actions S700 SoC". For the S700 clk
series, driver and bindings patches are applied through the clk tree.
But the DTS patches are not yet picked up by the platform maintainer,
Andreas.

Hence, Andreas is expected to pick the DTS patches in this series once
reviewed by the maintainers along with S700 clk DTS patches.

Note: I have only tested the S900 part, S700 is only compile tested. But
there is no reason for it to fail.

Thanks,
Mani

Changes in v2:

* Converted the CMU and RMU drivers to syscon for a more cleaner
  approach
* Declared the owl_reset_map structs to const
* Used regmap_update_bits instead of a combined regmap_read and write
* Removed unused headers in RMU drivers
* Added MAINTAINERS entry for the RMU driver and bindings

Manivannan Sadhasivam (10):
  dt-bindings: clock: Add syscon support to Actions Semi Owl SoCs
  arm64: dts: actions: Convert Owl SoCs clock-controller nodes to syscon
  clk: actions: Add syscon support for Actions Semi Owl SoCs
  dt-bindings: reset: Add Actions Semi S900 SoC RMU support
  dt-bindings: reset: Add Actions Semi S700 SoC RMU support
  arm64: dts: actions: Add RMU node for Actions Semi S900 SoC
  arm64: dts: actions: Add RMU node for Actions Semi S700 SoC
  reset: Add Actions Semi S900 SoC Reset Management Unit support
  reset: Add Actions Semi S700 SoC Reset Management Unit support
  MAINTAINERS: Add entry for Actions Semi Owl SoCs Reset Management Unit

 .../bindings/clock/actions,owl-cmu.txt        |  21 +-
 .../bindings/reset/actions,owl-reset.txt      |  35 +++
 MAINTAINERS                                   |   4 +
 arch/arm64/boot/dts/actions/s700.dtsi         |  18 +-
 arch/arm64/boot/dts/actions/s900.dtsi         |  18 +-
 drivers/clk/actions/owl-common.c              |  20 +-
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-owl.c                     | 225 ++++++++++++++++++
 include/dt-bindings/reset/actions,s700-rmu.h  |  34 +++
 include/dt-bindings/reset/actions,s900-rmu.h  |  65 +++++
 11 files changed, 416 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/actions,owl-reset.txt
 create mode 100644 drivers/reset/reset-owl.c
 create mode 100644 include/dt-bindings/reset/actions,s700-rmu.h
 create mode 100644 include/dt-bindings/reset/actions,s900-rmu.h

-- 
2.17.1
