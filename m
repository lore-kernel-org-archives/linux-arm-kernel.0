From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Jul 2017 17:50:05 +0800
Subject: [PATCH 10/18] drm/sun4i: tcon: Move out the tcon0 common setup
In-Reply-To: <45529eeddc5d5eab9bcfa74982343eeb36fe11f6.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <201707141731.HN0XJ5q3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test ERROR on next-20170710]
[cannot apply to mripard/sunxi/for-next robh/for-next regmap/for-next v4.12 v4.12-rc7 v4.12-rc6 v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Allwinner-MIPI-DSI-support/20170714-123103
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_tcon.c: In function 'sun4i_tcon0_mode_set_common':
>> drivers/gpu/drm/sun4i/sun4i_tcon.c:132:2: error: implicit declaration of function 'clk_set_rate_protect' [-Werror=implicit-function-declaration]
     clk_set_rate_protect(tcon->dclk, mode->crtc_clock * 1000);
     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/clk_set_rate_protect +132 drivers/gpu/drm/sun4i/sun4i_tcon.c

   127	
   128	static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
   129						struct drm_display_mode *mode)
   130	{
   131		/* Configure the dot clock */
 > 132		clk_set_rate_protect(tcon->dclk, mode->crtc_clock * 1000);
   133	
   134		/* Set the resolution */
   135		regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
   136			     SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
   137			     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
   138	}
   139	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170714/0829acf9/attachment-0001.gz>
