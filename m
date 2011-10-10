From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 23:45:28 +0530
Subject: [PATCH v6 00/10] Add device tree support for PL330 dma controller
	driver
Message-ID: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
- Added alias clocks for pdma clocks on Exynos4.
- Modified platform data for s5p64x0, s5pc100 and s5pv210.
- Rebased on the tip of for-next branch of linux-samsung kernel and tested.

Changes since v4:
- Rebased with Samsung maintainer's for-next branch which is at linux-3.1-rc7
  - Modified Patch 6/6 to apply cleanly.

Changes since v3:
- In Patch 4/6, a recommendation is added in the pl330 binding documentation
  for the name of the property which specifies the dma channel in the client
  device node.
- In Patch 6/6, dropped #ifdef around of_have_populated_dt.

Changes since v2:
- Only the sixth patch is changed, to make dma platform data conditionally
  selectable.
- Tested with v8 version of pl330 dma driver update patches from Boojin Kim.

Changes since v1:
- Removed "arm,pl330-pdma" and "arm,pl330-mdma" compatible values.
- Removed "arm,primecell-periphid" and "arm,pl330-peri-reqs"
  property requirements.

This patchset adds device tree support for PL330 driver and uses it to add
device tree support for Samsung platforms, specifically Exynos4.

Patch 1 moves the pl330_filter function from Samsung specific wrappers to pl330
dma driver and also adds a check to ensure that the filter function proceeds
only if it the dma channel being investigated belongs to pl330 dma controller
instance.

Patch 2 adds support to infer the direction of the dma transfer using the
direction specified with the transfer request instead of including this
information in the platform data. This simlifies the addition of device tree
support. Patch 3 simplifies the platform data for Exynos4 pl330 dma controllers.

Patch 4 adds device tree support for pl330 dma controller driver. A dma channel
is represented using a phandle of the dma controller node and the channel id
within that controller. Client driver request a dma channel using the phandle
and channel id pair. Correspondingly, the pl330 filter function has been
modified to lookup a channel based on this value.

Patch 5 adds device tree support for Samsung's DMA engine wrappers. Client
drivers retrive the channel property from their device node and pass it to the
wrappers. The wrapper functions use the property value as the filter function
parameter. Patch 6 restricts the usage of pl330 device and platform data
instances to non-dt platforms.

Patch 7 adds clock alias for both the pdma clocks. When pdma controllers are
instantiated from device tree, the amba device registration process enables
clock to the controllers to read the peripheral id of the PDMA amba device. In
case of Exynos4, the clocks to the PDMA controllers are named as 'dma' but
amba_device_register() looks up the clock using the name 'apb_pclk'. Hence,
alias clocks with name 'apb_pclk' clock are created for clocks with name 'dma'.

Patch 8 to 10 simplifies the pdma platform data for s5p64x0, s5pc100 and
s5pv210.

This patchset is based on the following tree:
https://github.com/kgene/linux-samsung.git   branch: for-next

and tested tested for both device-tree and non-device-tree kernel on smdkv310.

This patchset has dependency on the following patchset.
[PATCH V2 0/2] Add a common macro for creating struct clk_lookup entries.


Thomas Abraham (10):
  DMA: PL330: move filter function into driver
  DMA: PL330: Infer transfer direction from transfer request instead of platform data
  ARM: EXYNOS4: Modify platform data for pl330 driver
  DMA: PL330: Add device tree support
  ARM: SAMSUNG: Add device tree support for pl330 dma engine wrappers
  ARM: EXYNOS4: Limit usage of pl330 device instance to non-dt build
  ARM: Exynos4: Add a alias for pdma clocks
  ARM: S5P64x0: Modify platform data for pl330 driver
  ARM: S5PC100: Modify platform data for pl330 driver
  ARM: S5PV210: Modify platform data for pl330 driver

 .../devicetree/bindings/dma/arm-pl330.txt          |   30 +++
 arch/arm/mach-exynos4/Kconfig                      |   10 +
 arch/arm/mach-exynos4/Makefile                     |    3 +-
 arch/arm/mach-exynos4/clock.c                      |   35 ++-
 arch/arm/mach-exynos4/dma.c                        |  227 ++++++-------------
 arch/arm/mach-s5p64x0/dma.c                        |  227 +++++-------------
 arch/arm/mach-s5pc100/dma.c                        |  247 ++++++--------------
 arch/arm/mach-s5pv210/dma.c                        |  241 ++++++--------------
 arch/arm/plat-samsung/dma-ops.c                    |   15 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |    3 +-
 drivers/dma/pl330.c                                |   99 +++++----
 include/linux/amba/pl330.h                         |   15 +-
 13 files changed, 405 insertions(+), 748 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
