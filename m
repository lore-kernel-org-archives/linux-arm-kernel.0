From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Jun 2018 14:42:20 +0800
Subject: [PATCH] ARM:drm ivip Intel FPGA Video and Image Processing Suite
In-Reply-To: <1527745851-3339-4-git-send-email-hean.loong.ong@intel.com>
References: <1527745851-3339-4-git-send-email-hean.loong.ong@intel.com>
Message-ID: <201806011420.0hMyTcO4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.17-rc7 next-20180531]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hean-Loong-Ong/ARM-drm-ivip-Intel-FPGA-Video-and-Image-Processing-Suite/20180601-132429
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/cdev.h:8:0,
                    from include/drm/drmP.h:36,
                    from drivers/gpu//drm/ivip/intel_vip_core.c:24:
   drivers/gpu//drm/ivip/intel_vip_core.c: In function 'intelvipfb_enable':
>> drivers/gpu//drm/ivip/intel_vip_core.c:58:33: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
     dev_info(pipe->plane.dev->dev, "Address 0x%x\n", addr);
                                    ^
   include/linux/device.h:1382:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +58 drivers/gpu//drm/ivip/intel_vip_core.c

  > 24	#include <drm/drmP.h>
    25	#include <drm/drm_atomic.h>
    26	#include <drm/drm_atomic_helper.h>
    27	#include <drm/drm_crtc_helper.h>
    28	#include <drm/drm_fb_helper.h>
    29	#include <drm/drm_fb_cma_helper.h>
    30	#include <drm/drm_gem_cma_helper.h>
    31	#include <drm/drm_plane_helper.h>
    32	#include <drm/drm_simple_kms_helper.h>
    33	#include <drm/drm_gem_framebuffer_helper.h>
    34	
    35	#include <linux/init.h>
    36	#include <linux/kernel.h>
    37	#include <linux/module.h>
    38	
    39	#include "intel_vip_drv.h"
    40	
    41	static void intelvipfb_enable(struct drm_simple_display_pipe *pipe,
    42		       struct drm_crtc_state *crtc_state)
    43	{
    44		/*
    45		 * The frameinfo variable has to correspond to the size of the VIP Suite
    46		 * Frame Reader register 7 which will determine the maximum size used
    47		 * in this frameinfo
    48		 */
    49	
    50		u32 frameinfo;
    51		struct intelvipfb_priv *priv = pipe->plane.dev->dev_private;
    52		void __iomem *base = priv->base;
    53		struct drm_plane_state *state = pipe->plane.state;
    54		dma_addr_t addr;
    55	
    56		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
    57	
  > 58		dev_info(pipe->plane.dev->dev, "Address 0x%x\n", addr);
    59	
    60		frameinfo =
    61			readl(base + INTELVIPFB_FRAME_READER) & 0x00ffffff;
    62		writel(frameinfo, base + INTELVIPFB_FRAME_INFO);
    63		writel(addr, base + INTELVIPFB_FRAME_START);
    64		/* Finally set the control register to 1 to start streaming */
    65		writel(1, base + INTELVIPFB_CONTROL);
    66	}
    67	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53269 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180601/e8feddf3/attachment-0001.gz>
