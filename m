From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Jun 2017 00:43:58 +0800
Subject: [PATCH v3 1/6] drm/stm: ltdc: Add panel-bridge support
In-Reply-To: <1496414235-20098-2-git-send-email-philippe.cornu@st.com>
Message-ID: <201706040051.jlHl9W1R%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

[auto build test ERROR on drm/drm-next]
[also build test ERROR on next-20170602]
[cannot apply to v4.12-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Philippe-CORNU/STM32-DSI-HOST/20170603-231124
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/stm/ltdc.c: In function 'ltdc_load':
>> drivers/gpu/drm/stm/ltdc.c:953:12: error: implicit declaration of function 'drm_panel_bridge_add' [-Werror=implicit-function-declaration]
      bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
               ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/stm/ltdc.c:953:10: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
             ^
>> drivers/gpu/drm/stm/ltdc.c:993:2: error: implicit declaration of function 'drm_panel_bridge_remove' [-Werror=implicit-function-declaration]
     drm_panel_bridge_remove(bridge);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/drm_panel_bridge_add +953 drivers/gpu/drm/stm/ltdc.c

   947			return ret;
   948		}
   949	
   950		DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
   951	
   952		if (panel) {
 > 953			bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
   954			if (IS_ERR(bridge)) {
   955				DRM_ERROR("Failed to create panel-bridge\n");
   956				return PTR_ERR(bridge);
   957			}
   958		}
   959	
   960		ldev->bridge = bridge;
   961	
   962		ret = ltdc_encoder_init(ddev);
   963		if (ret) {
   964			DRM_ERROR("Failed to init encoder\n");
   965			goto err;
   966		}
   967	
   968		crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
   969		if (!crtc) {
   970			DRM_ERROR("Failed to allocate crtc\n");
   971			ret = -ENOMEM;
   972			goto err;
   973		}
   974	
   975		ret = ltdc_crtc_init(ddev, crtc);
   976		if (ret) {
   977			DRM_ERROR("Failed to init crtc\n");
   978			goto err;
   979		}
   980	
   981		ret = drm_vblank_init(ddev, NB_CRTC);
   982		if (ret) {
   983			DRM_ERROR("Failed calling drm_vblank_init()\n");
   984			goto err;
   985		}
   986	
   987		/* Allow usage of vblank without having to call drm_irq_install */
   988		ddev->irq_enabled = 1;
   989	
   990		return 0;
   991	
   992	err:
 > 993		drm_panel_bridge_remove(bridge);
   994	
   995		clk_disable_unprepare(ldev->pixel_clk);
   996	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22764 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170604/bc17004b/attachment-0001.gz>
