From: lkp@intel.com (kbuild test robot)
Date: Wed, 21 Feb 2018 22:48:22 +0800
Subject: [PATCH v2 05/10] drm/sun4i: Add Allwinner A31 MIPI-DSI
 controller support
In-Reply-To: <60ecb81e876f2c41584e5ccc55005cf12da5dc94.1519204731.git-series.maxime.ripard@bootlin.com>
References: <60ecb81e876f2c41584e5ccc55005cf12da5dc94.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <201802212257.bepJa57u%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Allwinner-MIPI-DSI-support/20180221-203150
base:    
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_tcon.c: In function 'sun4i_tcon_mode_set':
>> drivers/gpu/drm/sun4i/sun4i_tcon.c:606:30: warning: passing argument 1 of 'encoder_to_sun6i_dsi' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      dsi = encoder_to_sun6i_dsi(encoder);
                                 ^~~~~~~
   In file included from drivers/gpu/drm/sun4i/sun4i_tcon.c:37:0:
   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h:54:33: note: expected 'struct drm_encoder *' but argument is of type 'const struct drm_encoder *'
    static inline struct sun6i_dsi *encoder_to_sun6i_dsi(struct drm_encoder *encoder)
                                    ^~~~~~~~~~~~~~~~~~~~

vim +606 drivers/gpu/drm/sun4i/sun4i_tcon.c

   593	
   594	void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
   595				 const struct drm_encoder *encoder,
   596				 const struct drm_display_mode *mode)
   597	{
   598		struct sun6i_dsi *dsi;
   599	
   600		switch (encoder->encoder_type) {
   601		case DRM_MODE_ENCODER_DSI:
   602			/*
   603			 * This is not really elegant, but it's the "cleaner"
   604			 * way I could think of...
   605			 */
 > 606			dsi = encoder_to_sun6i_dsi(encoder);
   607			sun4i_tcon0_mode_set_cpu(tcon, dsi->device, mode);
   608			break;
   609		case DRM_MODE_ENCODER_LVDS:
   610			sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
   611			break;
   612		case DRM_MODE_ENCODER_NONE:
   613			sun4i_tcon0_mode_set_rgb(tcon, mode);
   614			sun4i_tcon_set_mux(tcon, 0, encoder);
   615			break;
   616		case DRM_MODE_ENCODER_TVDAC:
   617		case DRM_MODE_ENCODER_TMDS:
   618			sun4i_tcon1_mode_set(tcon, mode);
   619			sun4i_tcon_set_mux(tcon, 1, encoder);
   620			break;
   621		default:
   622			DRM_DEBUG_DRIVER("Unknown encoder type, doing nothing...\n");
   623		}
   624	}
   625	EXPORT_SYMBOL(sun4i_tcon_mode_set);
   626	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/30132f03/attachment-0001.gz>
