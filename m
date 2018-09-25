From: dkos@cadence.com (Damian Kos)
Date: Tue, 25 Sep 2018 10:13:30 +0100
Subject: [PATCH v5 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Message-ID: <1537866837-4408-1-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
- MST support
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Changes in v4:
- Fixed Kconfig in drm/rockchip
- Fixed Signed-offs
- dp_link_status() is no longer public since it's used only in drm_dp_helper.c
- Replaced EXTRA_CFLAGS with ccflags-y in drm/rockchip Makefile

Changes in v5:
- Fixed Kconfig in drm/rockchip again
- Moved cdn-dp-reg.h (cdns-mhdp-common.h) to include/drm/bridge instead of
    drivers/gpu/drm/bridge/
- Updated the mhdp_validate_cr function


Damian Kos (1):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver

Quentin Schulz (4):
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: make dp_get_lane_status usable from outside of the core
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm: bridge: add support for Cadence MHDP DPI/DP bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1107 ++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1304 +++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c               |   39 +-
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   43 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 .../drm/bridge/cdns-mhdp-common.h             |  135 +-
 include/drm/drm_dp_helper.h                   |    2 +
 13 files changed, 2744 insertions(+), 1150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp-common.h (81%)

-- 
2.17.1
