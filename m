From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:01 +0800
Subject: [PATCH v11 00/12] MT2701 DRM support
Message-ID: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT2701 DRM support PATCH v10, based on 4.10-rc1.
We add DSI interrupt control, transfer function for MIPI DSI panel support.
Most codes are the same, except some register changed.

For example:
 - DISP_OVL address offset changed, color format definition changed.
 - DISP_RDMA fifo size changed.
 - DISP_COLOR offset changed.
 - MIPI_TX setting changed.

We add a new component DDP_COMPONENT_BLS, and the connections are updated.
OVL -> RDMA -> COLOR -> BLS -> DSI
RDMA -> DPI
And we have shadow register support in MT2701.

Changes since v10:
- Add binding descriptions for newly added bindings
- Remove color data pointer from generic mtk_ddp_comp
- Remove "drm/mediatek: add mipi_tx data rate check" from the patch series
- Remove "drm/mediatek: add dsi ulp mode control" from the patch series
- Update descriptions for "drm/mediatek: add non-continuous clock mode and EOT packet control"
- Fix DSI disable flow

Changes since v9:
- Split DSI patches into smaller parts
- Use a real linux errno for return value
- Add error handling in mtk_output_dsi_enable()
- Remove unused changes and redundant delays
- Add helpers and macros for configuration
- Combine "drm/mediatek: rename macros, add chip prefix" and "drm/mediatek: add *driver_data for different hardware setting"

Changes since v8:
- enable 3 DSI interrupts only
- move mtk_dsi_wait_for_irq_done() to the patch of irq control
- use the name BLS in DRM driver part
- move BLS declaration to a separate patch
- update mtk_dsi_switch_to_cmd_mode()
- update mtk_output_dsi_enable() and mtk_output_dsi_disable()

Changes since v7:
- Remove redundant codes
- Move the definition of DDP_COMPONENT_BLS to patch of "drm/mediatek: update display module connections"
- Move _dsi_irq_wait_queue into platform driver data
- Move mtk_dsi_irq_data_clear() to patch of "drm/mediatek: add dsi interrupt control"
- Add more descriptions in the commit messages

Changes since v6:
- Change data type of irq_data to u32
- Rewrite mtk_dsi_host_transfer() for simplify
- Move some MIPI_TX config to patch of "drm/mediatek: add *driver_data for different hardware settings".
- Remove device tree from this patch series

Changes since v5:
- Remove DPI device tree and compatible string
- Use one wait queue to handle interrupt status
- Update the interrupt check flow and DSI_INT_ALL_BITS
- Use same function for host read/write command
- various fixes

Changes since v4:
- Add messages when timeout in mtk_disp_mutex_acquire()
- Add descriptions for DISP_REG_MUTEX registers
- Move connection settings for display modules to a separate patch
- Remove 'mt2701-disp-wdma' because it is unused
- Move cleaning up and renaming to a separate patch
- Use wait_event_interruptible_timeout() to replace polling
- Remove irq_num from mtk_dsi structure
- Remove redundant and debug codes

Changes since v3:
- Add DSI support for MIPI DSI panels
- Update BLS binding to PWM nodes
- Remove ufoe device nodes
- Remove redundant parentheses
- Remove global variable initialization

Changes since v2:
- Rename mtk_ddp_mux_sel to mtk_ddp_sout_sel
- Update mt2701_mtk_ddp_ext components
- Changed to prefix naming
- Reorder the patch series
- Use of_device_get_match_data() to get driver private data
- Use iopoll macros to implement mtk_disp_mutex_acquire()
- Removed empty device tree nodes

Changes since v1:
- Removed BLS bindings and codes, which belong to pwm driver
- Moved mtk_disp_mutex_acquire() just before mtk_crtc_ddp_config()
- Split patch into smaller parts
- Added const keyword to constant structure
- Removed codes for special memory align

Thanks,
yt.shen

YT Shen (10):
  dt-bindings: display: mediatek: update supported chips
  drm/mediatek: add helpers for coverting from the generic components
  drm/mediatek: add *driver_data for different hardware settings
  drm/mediatek: add shadow register support
  drm/mediatek: add BLS component
  drm/mediatek: update display module connections
  drm/mediatek: cleaning up and refine
  drm/mediatek: add non-continuous clock mode and EOT packet control
  drm/mediatek: update DSI sub driver flow for sending commands to panel
  drm/mediatek: add support for Mediatek SoC MT2701

shaoming chen (2):
  drm/mediatek: add dsi interrupt control
  drm/mediatek: add dsi transfer function

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +
 .../bindings/display/mediatek/mediatek,dsi.txt     |   2 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  64 +++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  39 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  75 ++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 138 +++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  69 +++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  54 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   9 +
 drivers/gpu/drm/mediatek/mtk_dsi.c                 | 414 ++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c             |  38 +-
 13 files changed, 750 insertions(+), 158 deletions(-)

-- 
1.9.1
