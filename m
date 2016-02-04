From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 4 Feb 2016 21:57:48 +0800
Subject: [PATCH v3 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver
 for mt2701
In-Reply-To: <56B356CA.1010200@gmail.com>
References: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
 <1451286546-5920-5-git-send-email-biao.huang@mediatek.com>
 <1451290066.11129.4.camel@mtksdaap41> <56B356CA.1010200@gmail.com>
Message-ID: <1454594268.15541.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-04 at 14:48 +0100, Matthias Brugger wrote:
> 
> On 28/12/15 09:07, Yingjoe Chen wrote:
> > On Mon, 2015-12-28 at 15:09 +0800, Biao Huang wrote:
> >> Add mt2701 support using mediatek common pinctrl driver.
> >> MT2701 have some special pins need an extra setting register
> >> than other ICs, so adding this support to common code.
> >>
> >> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> >> Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > <...>
> >> +
> >> +static struct platform_driver mtk_pinctrl_driver = {
> >> +	.probe = mt2701_pinctrl_probe,
> >> +	.driver = {
> >> +		.name = "mediatek-mt2701-pinctrl",
> >> +		.owner = THIS_MODULE,
> >> +		.of_match_table = mt2701_pctrl_match,
> >> +	},
> >> +};
> >> +
> >> +static int __init mtk_pinctrl_init(void)
> >> +{
> >> +	return platform_driver_register(&mtk_pinctrl_driver);
> >> +}
> >> +
> >> +arch_initcall(mtk_pinctrl_init);
> >
> >
> > As discussed in
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003350.html
> > we should use subsys_initcall() instead.
> >
> >
> >> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> >> index f307f1d..76279f0 100644
> >> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> >> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > <...>
> >> @@ -347,6 +352,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
> >>   		ret = mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
> >>   		break;
> >>   	case PIN_CONFIG_INPUT_ENABLE:
> >> +		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
> >>   		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
> >>   		break;
> >>   	case PIN_CONFIG_OUTPUT:
> >> @@ -354,6 +360,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
> >>   		ret = mtk_pmx_gpio_set_direction(pctldev, NULL, pin, false);
> >>   		break;
> >>   	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> >> +		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
> >>   		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
> >>   		break;
> >>   	case PIN_CONFIG_DRIVE_STRENGTH:
> >
> > This change is not directly related to adding mt2710 support and change
> > behavior for all MTK pinctrl drivers, please create a separate patch for
> > this.
> >
> 
> Hi Biao,
> 
> This patch didn't make it into v4.5-rc1. Are you thinking of sending a 
> new version addressing the comments from Yingjoe?

He already did,
http://lists.infradead.org/pipermail/linux-mediatek/2016-February/003980.html

The issue now is whether this change match the property.

Joe.C
