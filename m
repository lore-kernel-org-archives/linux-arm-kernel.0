From: m.purski@samsung.com (Maciej Purski)
Date: Tue, 19 Jun 2018 10:19:21 +0200
Subject: [PATCH v3 0/9] Add TOSHIBA TC358764 DSI/LVDS bridge driver
References: <CGME20180619081956eucas1p1de0ce0c89abdbf021c9942a2af39fe52@eucas1p1.samsung.com>
Message-ID: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this patchset is a next attempt to add the tc358764 driver.
The previous one can be found here:

https://lists.freedesktop.org/archives/dri-devel/2014-February/053705.html

Back then, TC358764 was added as a panel driver.

The bridge is supposed to be a DSI peripheral. Currently exynos_dsi accepts only panels
as its peripherals. Therefore, some logic in exynos_dsi had to be ammended. That is implemented
in first 3 patches.

Apart from the driver this patchset adds support for BOE HV070WSA-100 panel, which is used by
TC358764 and dts nodes to exynos5250.dtsi and exynos5250-arndale.dtsi.

Best regards,

Maciej Purski

---

Changes in v3:
- call drm_bridge_enable() and drm_bridge_pre_enable() in exynos_drm_dsi_enable()
  and make the bridge invisible for the framework in order to prevent it from
  being enabled by the framework
- expand panel binding description
- fix tc358744 binding, make port 1 mandatory and port 0 optional
- get rid of useless select VIDEOMODE_HELPERS in bridge Kconfig
- add missing SPDX license to drm/bridge/tc358764.c
- use mipi_dsi_generic_read() and mipi_dsi_generic_write() helpers
  in toshiba driver's read, write functions
- fix commit messages

Changes in v2:
- fix commits authorship
- don't call pm_runtime_put_sync() in exyons_dsi_disable(), if pm_runtime_get_sync()
  has not been called
- squash dts commits
- merge some redundant regulators in tc358764 bindings and in DTS
- fix kbuild robot errors

Andrzej Hajda (6):
  dt-bindings: display: add DT bindings for BOE HV070WSA-100 panel
  drm/panel: add support for BOE HV070WSA-100 panel to simple-panel
  dt-bindings: tc358754: add DT bindings
  drm/bridge: tc358764: Add DSI to LVDS bridge driver
  ARM: dts: exynos5250: add DSI node
  ARM: dts: exynos5250-arndale: add DSI and panel nodes

Maciej Purski (3):
  drm/exynos: rename "bridge_node" to "mic_bridge_node"
  drm/exynos: move connector creation to attach callback
  drm/exynos: enable out_bridge in exynos_dsi_enable()

 .../bindings/display/bridge/toshiba,tc358764.txt   |  35 ++
 .../bindings/display/panel/boe,hv070wsa-100.txt    |  28 ++
 arch/arm/boot/dts/exynos5250-arndale.dts           |  61 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  21 +
 drivers/gpu/drm/bridge/Kconfig                     |   8 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/tc358764.c                  | 521 +++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  88 ++--
 drivers/gpu/drm/panel/panel-simple.c               |  25 +
 9 files changed, 755 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

-- 
2.7.4
