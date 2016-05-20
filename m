From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:31 +0800
Subject: [RFC v2 0/5] MT2701 DRM support
Message-ID: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

This is MT2701 DRM support RFC, based on MT8173 DRM patch v16.
Most codes are the same, except some register changed.

For example:
 - DISP_OVL address offset changed, color format definition changed.
 - DISP_RDMA fifo size changed.
 - DISP_COLOR offset changed.

We add a new component DISP_BLS, and the connection settings are updated.
And we have shadow register support in MT2701.

Changes since v1:
- Removed BLS bindings and codes, which belong to pwm driver
- Moved mtk_disp_mutex_acquire() just before mtk_crtc_ddp_config()
- Split patch into smaller parts
- Added const keyword to constant structure
- Removed codes for special memory align

The RFC depends on MT2701 iommu/smi driver.
https://patchwork.kernel.org/patch/9043411/ ("dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and smi"),
https://patchwork.kernel.org/patch/9043391/ ("iommu/mediatek: move the common struct into header file"),
https://patchwork.kernel.org/patch/9043421/ ("memory/mediatek: add support for mt2701"),
https://patchwork.kernel.org/patch/9043451/ ("iommu/mediatek: add support for mtk iommu generation one HW"),
https://patchwork.kernel.org/patch/9043471/ ("ARM: dts: mt2701: add iommu/smi dtsi node for mt2701"),

Thanks,
yt.shen

YT Shen (5):
  drm/mediatek: rename macros, add chip suffix
  drm/mediatke: add support for Mediatek SoC MT2701
  drm/mediatek: add *driver_data for different hardware settings
  drm/mediatek: add shadow register support
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

 arch/arm/boot/dts/mt2701.dtsi               |  117 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   49 ++++++---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   36 +++++--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   75 ++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  151 ++++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h      |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   42 ++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   15 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   72 +++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    9 ++
 10 files changed, 462 insertions(+), 106 deletions(-)

-- 
1.7.9.5
