From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 May 2015 23:23:44 +0800
Subject: [RFC][PATCH 0/2] MT8173 DRM support
Message-ID: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 DRM include one master drm device and three sub device: dsi device,
crtc main device, and ddp device.

Master drm device control the drm sub device and memory management.
dsi device is a drm connector/encoder device which control MIPI/DSI hw block.
crtc main is a drm crtc device which control hw components in the display data
path.
ddp is a device which control display data path.

Display data path of crtc main is:
[OVL0] -> [COLOR0] -> [AAL] -> [OD] -> [UFOE] -> [RDMA0]

This patch depends on the other patches:
1. MT8173 IOMMU support
	http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
2. add IOMMU dma_ops
	cherry picked from git://linux-arm.org/linux-rm iommu/dma
		commit d76a1911b02185bdc5f8b5525f9228cf266725c5

CK Hu (2):
  dt-bindings: drm/mediatek: Add Mediatek DRM dts binding
  drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.

 .../bindings/drm/mediatek/mediatek,crtc-main.txt   |   38 +
 .../bindings/drm/mediatek/mediatek,ddp.txt         |   22 +
 .../bindings/drm/mediatek/mediatek,drm.txt         |   27 +
 .../bindings/drm/mediatek/mediatek,dsi.txt         |   20 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/mediatek/Kconfig                   |   28 +
 drivers/gpu/drm/mediatek/Makefile                  |   13 +
 drivers/gpu/drm/mediatek/mediatek_drm_crtc.c       |  246 ++++
 drivers/gpu/drm/mediatek/mediatek_drm_crtc.h       |   80 ++
 drivers/gpu/drm/mediatek/mediatek_drm_crtc_main.c  |  420 ++++++
 drivers/gpu/drm/mediatek/mediatek_drm_ddp.c        |  202 +++
 drivers/gpu/drm/mediatek/mediatek_drm_ddp.h        |   23 +
 drivers/gpu/drm/mediatek/mediatek_drm_ddp_comp.c   |  346 +++++
 drivers/gpu/drm/mediatek/mediatek_drm_ddp_comp.h   |   33 +
 drivers/gpu/drm/mediatek/mediatek_drm_drv.c        |  369 ++++++
 drivers/gpu/drm/mediatek/mediatek_drm_drv.h        |   37 +
 drivers/gpu/drm/mediatek/mediatek_drm_dsi.c        | 1333 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mediatek_drm_dsi.h        |   71 ++
 drivers/gpu/drm/mediatek/mediatek_drm_fb.c         |  339 +++++
 drivers/gpu/drm/mediatek/mediatek_drm_fb.h         |   43 +
 drivers/gpu/drm/mediatek/mediatek_drm_gem.c        |  315 +++++
 drivers/gpu/drm/mediatek/mediatek_drm_gem.h        |   94 ++
 include/uapi/drm/mediatek_drm.h                    |   59 +
 24 files changed, 4161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
 create mode 100644 drivers/gpu/drm/mediatek/Kconfig
 create mode 100644 drivers/gpu/drm/mediatek/Makefile
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_crtc.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_crtc.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_crtc_main.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_ddp.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_ddp.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_ddp_comp.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_ddp_comp.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_drv.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_drv.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_dsi.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_dsi.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_fb.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_fb.h
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_gem.c
 create mode 100644 drivers/gpu/drm/mediatek/mediatek_drm_gem.h
 create mode 100644 include/uapi/drm/mediatek_drm.h

-- 
1.8.1.1.dirty
