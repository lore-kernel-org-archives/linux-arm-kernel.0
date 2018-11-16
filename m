From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:37 +0100
Subject: [PATCH v5 00/12] arm/arm64: mediatek: Fix mmsys device probing
Message-ID: <20181116125449.23581-1-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

This is version four of the series. The biggest change are the last
four patches which introduce how this should be handled in the future.
Instead of creating the platform device in the DRM driver the device
tree has in the mmsys memory range a child node to probe the clock
part. That breaks backwards compatibility, so I only introduce that for
SoCs which are not available to the general public (mt2712e) or only
have the mmsys clock driver part implemented (mt6797).


Changes since v4:
- fix missing regmap accessors in drm diver (patch 1)
- omit probe deffered warning on all drivers (patch 5)
- update drm and clk bindings (patch 6 and 7)
- put mmsys clock part in dts child node of mmsys. Only done
for HW where no dts backport compatible breakage is expected 
(either DRM driver not yet implemented or no HW available to
the public) (patch 9 to 12)

Changes since v3:
- use platform device to probe clock driver
- add Acked-by CK Hu for the probe deferred patch

Changes since v2:
- fix kconfig typo (shame on me)
- delete __initconst from mm_clocks as converted to a platform driver
  
Changes since v1:
- add binding documentation
- ddp: use regmap_update_bits
- ddp: ignore EPROBE_DEFER on clock probing
- mfd: delete mmsys_private
- add Reviewed-by and Acked-by tags
 
MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch uses a platform device registration in the DRM driver, which
will trigger the probe of the corresponding clock driver. It was tested on the
bananapi-r2 and the Acer R13 Chromebook.


Matthias Brugger (12):
  drm/mediatek: Use regmap for register access
  clk: mediatek: mt2701-mmsys: switch to platform device probing
  clk: mediatek: mt8173: switch mmsys to platform device probing
  drm/mediatek: Add support for mmsys through a pdev
  drm: mediatek: Omit warning on probe defers
  drm/mediatek: update dt-bindings
  dt-bindings: clock: mediatek: delete mmsys clocks
  dt-bindings: mediatek: Change the binding for mmsys clocks
  arm64: dts: mt2712e: Use the new mmsys clock compatible
  arm64: dts: mt6797: Use the new mmsys clock compatible
  clk: mediatek: mt2712e: Probe with new compatible
  clk: mediatek: mt6797: Probe with new compatible

 .../bindings/arm/mediatek/mediatek,mmsys.txt  | 24 +++++----
 .../display/mediatek/mediatek,disp.txt        | 34 +++++++-----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  8 ++-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |  8 ++-
 drivers/clk/mediatek/clk-mt2701-mm.c          | 42 ++++++++++-----
 drivers/clk/mediatek/clk-mt2712-mm.c          |  9 ++--
 drivers/clk/mediatek/clk-mt6797-mm.c          |  9 ++--
 drivers/clk/mediatek/clk-mt8173.c             | 51 +++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c        | 53 ++++++++-----------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h        |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 34 +++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  6 ++-
 17 files changed, 200 insertions(+), 102 deletions(-)

-- 
2.19.1
