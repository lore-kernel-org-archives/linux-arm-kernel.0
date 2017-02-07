From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 21:11:56 +0800
Subject: [xlnx:master 238/266]
 drivers/gpu/drm/xilinx/xilinx_drm_crtc.c:503:33: warning: comparison of
 constant '-517' with boolean expression is always false
Message-ID: <201702072149.pIMzQZlj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7135a7a4b25b88a1582b27fd29593d94bb3d2974
commit: 2f092f96db5c42ac7b1e2ea50af05eeca40da3ad [238/266] drm: xilinx: crtc: pixel clock is optional
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 2f092f96db5c42ac7b1e2ea50af05eeca40da3ad
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/xilinx/xilinx_drm_crtc.c: In function 'xilinx_drm_crtc_create':
>> drivers/gpu/drm/xilinx/xilinx_drm_crtc.c:503:33: warning: comparison of constant '-517' with boolean expression is always false [-Wbool-compare]
      if (IS_ERR(crtc->pixel_clock) == -EPROBE_DEFER) {
                                    ^~
>> drivers/gpu/drm/xilinx/xilinx_drm_crtc.c:503:7: warning: ignoring return value of 'IS_ERR', declared with attribute warn_unused_result [-Wunused-result]
      if (IS_ERR(crtc->pixel_clock) == -EPROBE_DEFER) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~

vim +503 drivers/gpu/drm/xilinx/xilinx_drm_crtc.c

   487		}
   488	
   489		/* create a primary plane. there's only one crtc now */
   490		primary_plane = xilinx_drm_plane_create_primary(crtc->plane_manager,
   491								possible_crtcs);
   492		if (IS_ERR(primary_plane)) {
   493			DRM_ERROR("failed to create a primary plane for crtc\n");
   494			ret = PTR_ERR(primary_plane);
   495			goto err_plane;
   496		}
   497	
   498		/* create extra planes */
   499		xilinx_drm_plane_create_planes(crtc->plane_manager, possible_crtcs);
   500	
   501		crtc->pixel_clock = devm_clk_get(drm->dev, NULL);
   502		if (IS_ERR(crtc->pixel_clock)) {
 > 503			if (IS_ERR(crtc->pixel_clock) == -EPROBE_DEFER) {
   504				goto err_plane;
   505			} else {
   506				DRM_DEBUG_KMS("failed to get pixel clock\n");
   507				crtc->pixel_clock = NULL;
   508			}
   509	
   510		}
   511	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57127 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/2b961002/attachment-0001.gz>
