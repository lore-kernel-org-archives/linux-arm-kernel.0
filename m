From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Jun 2011 22:41:25 +0800
Subject: [PATCH v2 0/6] Some fixes and cleanup on imx-dma device registration
Message-ID: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set makes some small fixes on imx-dma device registration
code, and then cleans up the code by breaking the concentrated
imx-dma device registration into soc specific setup function.
This is basically what gpio-mxc device registration is doing.
In this way, we can avoid the churn of "#ifdef" and the cpu_is_mx
checking on such a long list of soc family, which makes no sense,
considering more soc supports need to be added and we need to
support single image for multiple socs in the long run.

Changes since v1:
 * Drop the patch #5 in v1 and add another one to pass firmware
   name as a string via platform data
 * Rebase it on Sascha's tree

Shawn Guo (6):
      ARM: mxc: imx-sdma device gets 16K iosize than 4K
      ARM: mxc: sdma on imx25 is a V2 block
      ARM: mxc: change imx-dma default to_version to 1
      ARM: mxc: imx-dma on imx25 has no other TO version but TO1
      ARM: mxc: clean up imx-dma device registration
      dmaengine: imx-sdma: pass sdma firmware name via platform data

 arch/arm/mach-imx/mm-imx21.c                    |    3 +
 arch/arm/mach-imx/mm-imx25.c                    |   25 +++
 arch/arm/mach-imx/mm-imx27.c                    |    3 +
 arch/arm/mach-imx/mm-imx31.c                    |   27 +++
 arch/arm/mach-imx/mm-imx35.c                    |   47 +++++
 arch/arm/mach-mx5/mm.c                          |   44 +++++
 arch/arm/plat-mxc/devices.c                     |   16 ++-
 arch/arm/plat-mxc/devices/platform-imx-dma.c    |  232 ++---------------------
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +
 arch/arm/plat-mxc/include/mach/sdma.h           |    6 +-
 drivers/dma/imx-sdma.c                          |    6 +-
 11 files changed, 188 insertions(+), 227 deletions(-)
