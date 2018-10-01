From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  1 Oct 2018 14:38:38 +0200
Subject: [PATCH v6 0/8] drm/rockchip: migrate to common dw-mipi-dsi bridge and
 dual-dsi
Message-ID: <20181001123845.11818-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip DSI driver was separate till now, not using the common
bridge driver that was introduced a bit later. So this series migrates
over to use that common bridge driver and then also adds support for
dual-dsi to both the bridge and Rockchip glue code.

The bridge-migration itself is based on Nickeys earlier v8
work, but adapted to current kernels and with a new split between probe
and bind, so that we do not create and drop the dsi-host on each deferred
bind attempt.

changes in v2:
- rebase against newer drm code (dsi-bridge+rockchip changes)
- add SPDX header to new glue driver
- expect regular interface lanes from panel (like 4) not the double number
  Similar to tegra
- keep links to both master and slave
changes in v3:
- don't defer in bridge_attach, instead add ability to check for finalized
  panel attachement, for example in bind
- address bridge-conversion comments from Andrzej:
  - include ordering
  - moved hwaccess from mode_set to enable callback
  - move pllref_clk enablement to bind (needed by bridge mode_set->lane_mbps)
- limited slave settings to dw_mipi_dsi_set_slave
- address dual-dsi comments from Philippe:
  - remove unneeded separate variables
  - remove unneeded second slave settings
  - disable slave before master
  - lane-sum calculation comments
changes in v4:
- rebase against some legacy rockchip-dsi changes
- add dsi-component only after panel has attached to dsi host
  This solves quite some concurrency problems that happen when trying
  to determine dsi-panel availability 
changes in v5:
- use driver-internal method to find second host
- drop of-graph based dsi method for it
changes in v6:
- patch7 don't add component on empty local dsi-bus, as some
  dsi bridges might live on an i2c bus or so and attach from there.
  Instead check for a slave in dsi-attach and add the slave-component
  from there if needed
- Go back to reading dsi-slave from dt, to prevent possible driver-
  probe races

Heiko Stuebner (4):
  drm/bridge/synopsys: dsi: move mipi_dsi_host_unregister to
    __dw_mipi_dsi_remove
  drm/bridge/synopsys: dsi: don't call __dw_mipi_dsi_probe from
    dw_mipi_dsi_bind
  drm/bridge/synopsys: dsi: add ability to have glue-specific attach and
    detach
  drm/rockchip: dsi: add dual mipi support

Nickey Yang (3):
  dt-bindings: display: rockchip: update DSI controller
  drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver
  drm/bridge/synopsys: dsi: add dual-dsi support

 .../display/rockchip/dw_mipi_dsi_rockchip.txt |   23 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  114 +-
 drivers/gpu/drm/rockchip/Kconfig              |    2 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 1075 +++++++++++++
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c        | 1349 -----------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |    3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |    4 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |    1 +
 include/drm/bridge/dw_mipi_dsi.h              |   14 +-
 12 files changed, 1213 insertions(+), 1379 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
 delete mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi.c

-- 
2.18.0
