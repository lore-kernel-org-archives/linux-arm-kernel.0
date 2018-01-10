From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 10 Jan 2018 20:25:00 +0100
Subject: [PATCH v2 00/12] drm/sun4i: Add A83T HDMI support
Message-ID: <20180110192512.19684-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements support for A83T DW HDMI and PHY. Contrary to
v1 series, this one is based on latest linux-next, since all needed patches
were merged.

While exactly this combination of HDMI controller and PHY is not common in
Allwinner SoCs, this patch series nevertheless makes groundwork for other
SoCs, which have same DW HDMI IP block, but different PHYs, like H3 and H5.

Please take a look.

Best regards,
Jernej

Changes from v1:
- Collected ACKs
- Separated bindings for controller and PHY
- Split driver into two parts - controller and PHY
- HDMI PHY driver now uses regmap for writes
- added defines for PHY registers and bits
- updated DT entries to accomodate new bindings
- removed already merged clock patch
- reworked first clock patch according to comments
- added new clock patch which changes NKMP formula
- split TCON patch in two, one for quirk and one for new compatible
- reworked patch which exports DW HDMI PHY functions:
  - remove "gen2" from some function names
  - removed parameter from dw_hdmi_phy_reset()
  - added address parameter to dw_hdmi_phy_i2c_set_addr()
- updated most of commit messages

Jernej Skrabec (12):
  clk: sunxi-ng: Mask nkmp factors when setting register
  clk: sunxi-ng: Change formula for NKMP PLLs
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v1.32a
  drm/bridge/synopsys: dw-hdmi: Export some PHY related functions
  drm/bridge/synopsys: dw-hdmi: Add deinit callback
  dt-bindings: display: sun4i-drm: Add A83T HDMI pipeline
  drm/sun4i: Add has_channel_0 TCON quirk
  drm/sun4i: Add support for A83T second TCON
  drm/sun4i: Add support for A83T second DE2 mixer
  drm/sun4i: Implement A83T HDMI driver
  ARM: dts: sun8i: a83t: Add HDMI display pipeline
  ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3

 .../bindings/display/sunxi/sun4i-drm.txt           | 197 +++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  25 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 119 +++++++-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  27 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  55 ++--
 drivers/gpu/drm/sun4i/Kconfig                      |   9 +
 drivers/gpu/drm/sun4i/Makefile                     |   4 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  46 +++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              | 183 +++++++++++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |  51 ++++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             | 302 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  11 +
 include/drm/bridge/dw_hdmi.h                       |  12 +
 14 files changed, 993 insertions(+), 49 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c

-- 
2.15.1
