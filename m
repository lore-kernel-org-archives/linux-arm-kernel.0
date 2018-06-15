From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Fri, 15 Jun 2018 22:43:41 +0300
Subject: [PATCH 0/3] ARM: imx: Make DRM_MXSFB and FB_MXS coexist
Message-ID: <cover.1529091248.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some imx boards have new drm-style bindings for lcdif devices but using
them requires rebuilding the kernel with FB_MXS=n DRM_MXSFB=y.

It is relatively easy to allow both drivers to coexist by renaming
drm/mxsfb to "mxsfb-drm" and making the old fbdev driver return -ENODEV
instead of -ENOENT when it fails to find the display node.

This makes display on imx6sx-sdb "just work" with both styles of
bindings. In order to test the old bindings I locally reverted commit
7caa59e0d40c ("ARM: dts: imx6sx-sdb: Convert from fbdev to drm bindings")

Leonard Crestez (3):
  drm: mxsfb: Change driver.name to mxsfb-drm
  fbdev: mxsfb: Return ENODEV on missing display node
  ARM: imx_v6_v7_defconfig: Enable DRM_MXSFB

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c    | 2 +-
 drivers/video/fbdev/mxsfb.c          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1
