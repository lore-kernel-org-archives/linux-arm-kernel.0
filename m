From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 18 Jul 2018 16:57:46 +0200
Subject: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
 platform device probing (fwd)
In-Reply-To: <alpine.DEB.2.20.1807181651360.3113@hadrien>
References: <alpine.DEB.2.20.1807181651360.3113@hadrien>
Message-ID: <4a62b859-7d57-4901-d13f-5c5a9de8588c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/07/18 16:53, Julia Lawall wrote:
> Hello,
> 
> Please check on whether the kfree in the remove function is still needed.
> Also the platform_driver structure has two probe fields.

Fair enough, kfree(private) is not needed, because it is allocated with
devm_kzalloc.

I'll fix both errors. Thanks for noting.
Matthias

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 18 Jul 2018 22:31:13 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild at 01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
>     platform device probing
> 
> In-Reply-To: <20180717220328.792-4-matthias.bgg@kernel.org>
> References: <20180717220328.792-4-matthias.bgg@kernel.org>
> TO: matthias.bgg at kernel.org
> 
> Hi Matthias,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on sof-driver-fuweitax/master]
> [also build test WARNING on v4.18-rc5 next-20180718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180718-191916
> base:   https://github.com/fuweitax/linux master
> :::::: branch date: 3 hours ago
> :::::: commit date: 3 hours ago
> 
>>> drivers/clk/mediatek/clk-mt8173.c:1195:1-6: WARNING: invalid free of devm_ allocated data
> --
>>> drivers/clk/mediatek/clk-mt8173.c:1200:48-49: probe: first occurrence line 1201, second occurrence line 1202
> 
> # https://github.com/0day-ci/linux/commit/112857d0f58413a87875dfc9e1b43fdfde3b55eb
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 112857d0f58413a87875dfc9e1b43fdfde3b55eb
> vim +1195 drivers/clk/mediatek/clk-mt8173.c
> 
> 112857d0 Matthias Brugger 2018-07-18  1189
> 112857d0 Matthias Brugger 2018-07-18  1190  static int mtk_mmsys_remove(struct platform_device *pdev)
> 112857d0 Matthias Brugger 2018-07-18  1191  {
> 112857d0 Matthias Brugger 2018-07-18  1192  	struct mtk_mmsys_priv *private = platform_get_drvdata(pdev);
> 112857d0 Matthias Brugger 2018-07-18  1193
> 112857d0 Matthias Brugger 2018-07-18  1194  	kfree(private->clk_data);
> 112857d0 Matthias Brugger 2018-07-18 @1195  	kfree(private);
> 112857d0 Matthias Brugger 2018-07-18  1196
> 112857d0 Matthias Brugger 2018-07-18  1197  	return 0;
> 29859d93 James Liao       2015-05-20  1198  }
> 112857d0 Matthias Brugger 2018-07-18  1199
> 112857d0 Matthias Brugger 2018-07-18 @1200  static struct platform_driver clk_mt8173_mm_drv = {
> 112857d0 Matthias Brugger 2018-07-18 @1201  	.probe = mtk_mmsys_probe,
> 112857d0 Matthias Brugger 2018-07-18 @1202  	.probe = mtk_mmsys_remove,
> 112857d0 Matthias Brugger 2018-07-18  1203  	.driver = {
> 112857d0 Matthias Brugger 2018-07-18  1204  		.name = "clk-mt8173-mm",
> 112857d0 Matthias Brugger 2018-07-18  1205  	},
> 112857d0 Matthias Brugger 2018-07-18  1206  };
> 112857d0 Matthias Brugger 2018-07-18  1207  module_platform_driver(clk_mt8173_mm_drv);
> 29859d93 James Liao       2015-05-20  1208
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
