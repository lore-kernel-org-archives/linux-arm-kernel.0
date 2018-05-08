From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 May 2018 01:19:18 +0800
Subject: [PATCH 1/7] drm/mediatek: move dpi private data to device
In-Reply-To: <20180508022057.29379-2-bibby.hsieh@mediatek.com>
References: <20180508022057.29379-2-bibby.hsieh@mediatek.com>
Message-ID: <201805082346.IV7imPSc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi chunhui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.17-rc4 next-20180507]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bibby-Hsieh/drm-mediatek-support-hdmi-output-for-mt2701-and-mt7623/20180508-140924
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/gpu//drm/mediatek/mtk_dpi.c: In function 'mtk_dpi_power_on':
>> drivers/gpu//drm/mediatek/mtk_dpi.c:444:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return ret;
            ^~~

vim +/ret +444 drivers/gpu//drm/mediatek/mtk_dpi.c

9e629c17 Jie Qiu     2016-01-04  405  
9e629c17 Jie Qiu     2016-01-04  406  static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
9e629c17 Jie Qiu     2016-01-04  407  {
9e629c17 Jie Qiu     2016-01-04  408  	int ret;
9e629c17 Jie Qiu     2016-01-04  409  
51df75e5 chunhui dai 2018-05-08  410  	if (++dpi->refcount != 1)
51df75e5 chunhui dai 2018-05-08  411  		return 0;
51df75e5 chunhui dai 2018-05-08  412  
9e629c17 Jie Qiu     2016-01-04  413  	dpi->power_ctl |= pctl;
9e629c17 Jie Qiu     2016-01-04  414  
9e629c17 Jie Qiu     2016-01-04  415  	if (!(dpi->power_ctl & DPI_POWER_START) &&
9e629c17 Jie Qiu     2016-01-04  416  	    !(dpi->power_ctl & DPI_POWER_ENABLE))
51df75e5 chunhui dai 2018-05-08  417  		goto err_refcount;
9e629c17 Jie Qiu     2016-01-04  418  
9e629c17 Jie Qiu     2016-01-04  419  	if (dpi->power_sta)
51df75e5 chunhui dai 2018-05-08  420  		goto err_refcount;
9e629c17 Jie Qiu     2016-01-04  421  
9e629c17 Jie Qiu     2016-01-04  422  	ret = clk_prepare_enable(dpi->engine_clk);
9e629c17 Jie Qiu     2016-01-04  423  	if (ret) {
9e629c17 Jie Qiu     2016-01-04  424  		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
9e629c17 Jie Qiu     2016-01-04  425  		goto err_eng;
9e629c17 Jie Qiu     2016-01-04  426  	}
9e629c17 Jie Qiu     2016-01-04  427  
9e629c17 Jie Qiu     2016-01-04  428  	ret = clk_prepare_enable(dpi->pixel_clk);
9e629c17 Jie Qiu     2016-01-04  429  	if (ret) {
9e629c17 Jie Qiu     2016-01-04  430  		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
9e629c17 Jie Qiu     2016-01-04  431  		goto err_pixel;
9e629c17 Jie Qiu     2016-01-04  432  	}
9e629c17 Jie Qiu     2016-01-04  433  
9e629c17 Jie Qiu     2016-01-04  434  	mtk_dpi_enable(dpi);
9e629c17 Jie Qiu     2016-01-04  435  	dpi->power_sta = true;
9e629c17 Jie Qiu     2016-01-04  436  	return 0;
9e629c17 Jie Qiu     2016-01-04  437  
9e629c17 Jie Qiu     2016-01-04  438  err_pixel:
9e629c17 Jie Qiu     2016-01-04  439  	clk_disable_unprepare(dpi->engine_clk);
9e629c17 Jie Qiu     2016-01-04  440  err_eng:
9e629c17 Jie Qiu     2016-01-04  441  	dpi->power_ctl &= ~pctl;
51df75e5 chunhui dai 2018-05-08  442  err_refcount:
51df75e5 chunhui dai 2018-05-08  443  	dpi->refcount--;
9e629c17 Jie Qiu     2016-01-04 @444  	return ret;
9e629c17 Jie Qiu     2016-01-04  445  }
9e629c17 Jie Qiu     2016-01-04  446  

:::::: The code at line 444 was first introduced by commit
:::::: 9e629c17aa8d7a75b8c1d99ed42892cd8ba7cdc4 drm/mediatek: Add DPI sub driver

:::::: TO: Jie Qiu <jie.qiu@mediatek.com>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64520 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/9987323d/attachment-0001.gz>
