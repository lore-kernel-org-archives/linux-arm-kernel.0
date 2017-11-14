From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Nov 2017 22:41:06 +0100
Subject: [PATCH 0/8] arm/arm64: mediatek: Fix mmsys device probing
Message-ID: <20171114214114.15793-1-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch set introduces a new mfd device, which binds against the mmsys
compatible and takes care of probing the needed devices. It was tested on the
bananapi-r2 and the Acer R13 Chromebook.

Matthias Brugger (8):
  drm/mediatek: Use regmap for register access
  mfd: mtk-mmsys: Add mmsys driver
  drm/mediatek: mt2701: switch to mfd probing.
  clk: mediatek: mt2701-mm: switch to mfd device
  mfd: mtk-mmsys: Add mt8173 nodes
  drm/mediatek: Add mfd support for mt8173
  clk: mediatek: mt8173-mm: switch to mfd device
  MAINTAINERS: update Mediatek Soc entry

 MAINTAINERS                             |   2 +
 drivers/clk/mediatek/clk-mt2701-mm.c    |  13 ++--
 drivers/clk/mediatek/clk-mt8173.c       |  21 ++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  |  30 +++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  35 ++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
 drivers/mfd/Kconfig                     |   9 +++
 drivers/mfd/Makefile                    |   2 +
 drivers/mfd/mtk-mmsys.c                 | 105 ++++++++++++++++++++++++++++++++
 include/linux/mfd/mmsys.h               |  18 ++++++
 12 files changed, 200 insertions(+), 45 deletions(-)
 create mode 100644 drivers/mfd/mtk-mmsys.c
 create mode 100644 include/linux/mfd/mmsys.h

-- 
2.14.2
