From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:41 +0530
Subject: [PATCH V9 00/14] drm/exynos: few patches to enhance bridge chip
 support
Message-ID: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v3.19-rc5 tag of Linux-next tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Changes since V2:
	-- Address comments from Jingoo Han for ps8622 driver
	-- Address comments from Daniel, Rob and Thierry regarding
	   bridge chaining
	-- Address comments from Thierry regarding the names for
	   new drm_panel functions

Changes since V3:
	-- Remove hotplug based initialization of exynos_dp
	-- Make exynos_dp work directly with drm_panel, remove
	   dependency on panel_binder
	-- Minor cleanups in panel_binder and panel_lvds driver

Changes since V4:
	-- Use gpiod interface for panel-lvds and ps8622 drivers.
	-- Address comments from Javier.
	-- Fix compilation issues when PANEL_BINDER is selected as module.
	-- Split Documentation patches from driver patches.
	-- Rebase on top of the tree.

Changes since V5:
	-- Modify bridge drivers to support driver model.
	-- Drop the concept of bridge chain(sincle there are no 2 real bridges)
	   Hence drop bridge-panel_binder layer.
	-- Drop panel-lvds driver and accomadate the required changes in
	   panel-simple driver.
	-- Use gpiod interface in ptn3460 driver.
	-- Address all comments by Thierry Reding for V5 series.
	-- Address comments from Sean Paul for exynos_dp_commit issue.

Changes since V6:
	-- Panel patches were separated and they are merged already.
	-- Fix few issues with ptn3460, before modifying the bridge core.
	-- Modify drm_bridge as per Thierry's comments for V6 series.
	-- Add drm_bridge changes minimally without breaking existing code.
	-- Add new features for ptn3460, step-by-step.
	-- Address comments from Thierry and Andreas for ptn3460 and ps8622.
	-- Split documentation patches from driver patches.

Changes since V7:
	-- Address comments from Tomi and Laurent:
		-- Use videoports and endpoints to represent the connection between
		   encoder, bridge and the panel, instead of using phandles.
	-- Address comments from Daniel:
		-- Make the patch description more descriptive.
		-- remove device pointer from drm_bridge, and just use
		   device_node instead.
		-- don't pass encoder pointer to bridge_attach.
	-- Address comments from Sean Paul:
		-- Remove bridge from mode_config, and pull out drm_bridge
		   functions from drm_crtc.c to drm_bridge.c

Changes since V8:
	-- Rebase on top of linux-next v3.19-rc5.
	-- Add Acked-by and Tested-by tags.

Ajay Kumar (13):
  [PATCH V9 1/14] drm/bridge: ptn3460: Few trivial cleanups
  [PATCH V9 2/14] drm/bridge: do not pass drm_bridge_funcs to drm_bridge_init
  [PATCH V9 3/14] drm/bridge: make bridge registration independent of drm flow
  [PATCH V9 4/14] drm/bridge: ptn3460: Convert to i2c driver model
  [PATCH V9 5/14] drm/exynos: dp: support drm_bridge
  [PATCH V9 6/14] drm/bridge: ptn3460: support drm_panel
  [PATCH V9 7/14] drm/bridge: ptn3460: probe connector at the end of bridge attach
  [PATCH V9 8/14] drm/bridge: ptn3460: use gpiod interface
  [PATCH V9 9/14] Documentation: drm: bridge: move to video/bridge
  [PATCH V9 10/14] Documentation: devicetree: Add vendor prefix for parade
  [PATCH V9 11/14] Documentation: bridge: Add documentation for ps8622 DT properties
  [PATCH V9 13/14] ARM: dts: snow: represent the connection between bridge and panel
    using videoport and endpoints
  [PATCH V9 14/14] ARM: dts: peach-pit: represent the connection between bridge and
    panel using videoport and endpoints

Vincent Palatin (1):
  [PATCH V9 12/14] drm/bridge: Add i2c based driver for ps8622/ps8625 bridge

 .../devicetree/bindings/drm/bridge/ptn3460.txt     |   27 -
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 .../devicetree/bindings/video/bridge/ps8622.txt    |   31 +
 .../devicetree/bindings/video/bridge/ptn3460.txt   |   39 ++
 .../devicetree/bindings/video/exynos_dp.txt        |   12 +
 arch/arm/boot/dts/exynos5250-snow.dts              |   30 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   31 +-
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   12 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ps8622.c                    |  684 ++++++++++++++++++++
 drivers/gpu/drm/bridge/ptn3460.c                   |  310 +++++----
 drivers/gpu/drm/drm_bridge.c                       |   91 +++
 drivers/gpu/drm/drm_crtc.c                         |   70 --
 drivers/gpu/drm/exynos/exynos_dp_core.c            |   53 +-
 drivers/gpu/drm/exynos/exynos_dp_core.h            |    1 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |    1 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |    7 +-
 drivers/gpu/drm/sti/sti_hda.c                      |   11 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |   11 +-
 include/drm/bridge/ptn3460.h                       |    8 +
 include/drm/drm_crtc.h                             |   27 +-
 23 files changed, 1181 insertions(+), 283 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
 create mode 100644 Documentation/devicetree/bindings/video/bridge/ps8622.txt
 create mode 100644 Documentation/devicetree/bindings/video/bridge/ptn3460.txt
 create mode 100644 drivers/gpu/drm/bridge/ps8622.c
 create mode 100644 drivers/gpu/drm/drm_bridge.c

-- 
1.7.9.5
