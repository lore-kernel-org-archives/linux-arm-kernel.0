From: yt.shen@mediatek.com (YT Shen)
Date: Thu, 9 Jun 2016 00:03:40 +0800
Subject: [RFC v3 0/5] MT2701 DRM support
Message-ID: <1465401825-43642-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT2701 DRM support RFC v3, based on 4.7-rc1.
Most codes are the same, except some register changed.

For example:
 - DISP_OVL address offset changed, color format definition changed.
 - DISP_RDMA fifo size changed.
 - DISP_COLOR offset changed.

We add a new component DISP_BLS, and the connection settings are updated.
And we have shadow register support in MT2701.

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

The RFC depends on the following patch:
https://patchwork.kernel.org/patch/8832441/ ("dt-bindings: ARM: Mediatek: Document bindings for MT2701"),
https://patchwork.kernel.org/patch/9140487/ ("dt-bindings: pwm: Add MediaTek display PWM bindings"),
https://patchwork.kernel.org/patch/9137919/ ("dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and smi"),
https://patchwork.kernel.org/patch/9137923/ ("iommu/mediatek: move the common struct into header file"),
https://patchwork.kernel.org/patch/9137921/ ("memory/mediatek: add support for mt2701"),
https://patchwork.kernel.org/patch/9137927/ ("iommu/mediatek: add support for mtk iommu generation one HW"),
https://patchwork.kernel.org/patch/9137931/ ("ARM: dts: mt2701: add iommu/smi dtsi node for mt2701"),

Thanks,
yt.shen

YT Shen (5):
  drm/mediatek: rename macros, add chip prefix
  drm/mediatek: add *driver_data for different hardware settings
  drm/mediatek: add shadow register support
  drm/mediatek: add support for Mediatek SoC MT2701
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

 arch/arm/boot/dts/mt2701.dtsi               |  106 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   32 +++++--
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   17 +++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   75 +++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  135 ++++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h      |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   35 +++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   15 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   57 +++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    9 ++
 10 files changed, 395 insertions(+), 88 deletions(-)

-- 
1.7.9.5
