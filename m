From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Sep 2011 23:59:19 +0530
Subject: [PATCH v3 0/6] Add device tree support for PL330 dma controller driver
Message-ID: <1315852165-32402-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Only the sixth patch is changed, to make dma platform data conditionally
  selectable.
- Tested with v8 version of pl330 dma driver update patches from Boojin Kim.

Changes since v1:
- Removed "arm,pl330-pdma" and "arm,pl330-mdma" compatible values.
- Removed "arm,primecell-periphid" and "arm,pl330-peri-reqs"
  property requirements.

This patchset adds device tree support for PL330 driver and uses it
to add device tree support for Samsung platforms, specifically Exynos4.

First patch moves the pl330_filter function from Samsung specific wrappers
to pl330 dma driver and also adds a check to ensure that the filter function
proceeds only if it the dma channel being investigated belongs to pl330
dma controller instance.

Second patch adds support to infer the direction of the dma transfer
using the direction specified with the transfer request instead of
including this information in the platform data. This simlifies the
addition of device tree support. Third patch simplifies the platform
data for Exynos4 pl330 dma controllers. Similar patches simplifying
the platform data for other Samsung platforms is under development.

Fourth patch adds device tree support for pl330 dma controller driver.
A dma channel is represented using a phandle of the dma controller
node and the channel id within that controller. Client driver request
a dma channel using the phandle and channel id pair. Correspondingly,
the pl330 filter function has been modified to lookup a channel based
on this value.

Fifth patch adds device tree support for Samsung's DMA engine wrappers.
Client drivers retrive the channel property from their device node and
pass it to the wrappers. The wrapper functions use the property value
as the filter function parameter. Sixth patch restricts the usage of
pl330 device and platform data instances to non-dt platforms.

This patchset is based on Linux 3.1-rc4 with the following patch sets.

* To use DMA generic APIs for Samsung DMA - v8 - (16 patches)
* ARM: Samsung: use dma-pl330 device name for clock (3 patches)
* ARM: S5P64X0: Add the devname for DMA clock.
* ARM: SAMSUNG: register the second instance of PL330 DMAC (3 patches)

Thomas Abraham (6):
  DMA: PL330: move filter function into driver
  DMA: PL330: Infer transfer direction from transfer request instead of platform data
  ARM: EXYNOS4: Modify platform data for pl330 driver
  DMA: PL330: Add device tree support
  ARM: SAMSUNG: Add device tree support for pl330 dma engine wrappers
  ARM: EXYNOS4: Limit usage of pl330 device instance to non-dt build

 .../devicetree/bindings/dma/arm-pl330.txt          |   29 +++
 arch/arm/mach-exynos4/Kconfig                      |   10 +
 arch/arm/mach-exynos4/Makefile                     |    3 +-
 arch/arm/mach-exynos4/dma.c                        |  229 ++++++--------------
 arch/arm/plat-samsung/dma-ops.c                    |   15 +-
 arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 +
 arch/arm/plat-samsung/include/plat/dma-pl330.h     |    3 +-
 drivers/dma/pl330.c                                |   99 +++++----
 include/linux/amba/pl330.h                         |   15 +-
 9 files changed, 178 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
