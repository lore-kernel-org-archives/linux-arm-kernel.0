From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Tue, 2 Oct 2018 16:10:30 +0800
Subject: [PATCH v4 00/11] drm/mediatek: support hdmi output for mt2701 and
 mt7623
Message-ID: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support HDMI on mt2701,
we have to make some modifications.
1) Add the HDMI driver.
2) Add the DPI driver.
3) Add a mechanism that config output component by dts.

Change since v3:
 - Remove drm/mediatek: config component output by device node port
   patch, we will push another patches to flexibly config the component output.
 - fixup the return value
 - replace dpi->power_ctl and power_sta with reference count mechanism.
 - move the common function to mtk_hdmi_phy.c/h

Changes since v2:
 - Fix the typo in commit message.
 - Remove const of reg_h_fre_con in the mtk_dpi_conf struct
 - Remove unused error log
 - Use lower casee for hex number
 - Use common API which defined in mtk_hdmi_phy.c to reduce code size
 - Implemet the enable/disable of phy_pll_ops the same as 8173
 - Move the common header to mtk_hdmi_phy.h
 - Remove the including of debugfs.h
NOTE:
 - add description about thecoponent output in the binding document in v4.

Changes since v1:
 - Separate some patches to independent patch.
 - add DISP_REG_CONFIG_DSI_SEL and DISP_REG_CONFIG_DPI_SEL
   configuration in the condition of BLS&DPI0 connection.

Changes since v0:
 - Correct some typos in commit message.
 - Fixup the build warning (tmp variable didn't be initialized)

Bibby Hsieh (2):
  drm/mediatek: implement connection from BLS to DPI0
  drm/mediatek: add a error return value when clock driver has been
    prepared

chunhui dai (9):
  drm/mediatek: add refcount for DPI power on/off
  drm/mediatek: move hardware register to node data
  drm/mediatek: adjust EDGE to match clock and data
  drm/mediatek: add clock factor for different IC
  drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
  drm/mediatek: add dpi driver for mt2701 and mt7623
  drm/mediatek: separate hdmi phy to different file
  drm/mediatek: add support for SPDIF audio in HDMI
  drm/mediatek: add hdmi driver for MT2701 and MT7623

 drivers/gpu/drm/mediatek/Makefile              |   5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 131 ++++++++------
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c         |  14 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c         |   2 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  15 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 235 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  60 +++++++
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 212 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 226 +-----------------------
 12 files changed, 627 insertions(+), 279 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

-- 
2.12.5.2.gbdf23ab
