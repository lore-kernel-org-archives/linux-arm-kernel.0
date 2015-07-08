From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Jul 2015 14:01:48 +0900
Subject: [PATCH 1/7] pinctrl: UniPhier: add UniPhier pinctrl core support
In-Reply-To: <1436260472.20057.121.camel@tiscali.nl>
References: <1436185763-4308-1-git-send-email-yamada.masahiro@socionext.com>
 <1436185763-4308-2-git-send-email-yamada.masahiro@socionext.com>
 <1436260472.20057.121.camel@tiscali.nl>
Message-ID: <CAK7LNASnaN47cPHyyH-DTrF4pE4XqhgUdZLuOspuqHtKoDxmRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,


2015-07-07 18:14 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> (I only comment on 1/7, because it's not useful to repeat one remark
> seven times.)
>
> On ma, 2015-07-06 at 21:29 +0900, Masahiro Yamada wrote:
>> --- /dev/null
>> +++ b/drivers/pinctrl/uniphier/Kconfig
>
>> +config PINCTRL_UNIPHIER_CORE
>> +     bool
>> +     select PINMUX
>> +     select GENERIC_PINCONF
>
>> --- /dev/null
>> +++ b/drivers/pinctrl/uniphier/Makefile
>
>> +obj-$(CONFIG_PINCTRL_UNIPHIER_CORE)          += pinctrl-uniphier-core.o
>
>> --- /dev/null
>> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
>
>> +#include <linux/module.h>
>
>> +int uniphier_pinctrl_probe(struct platform_device *pdev,
>> +                        struct pinctrl_desc *desc,
>> +                        struct uniphier_pinctrl_socdata *socdata)
>> +{
>> +     [...]
>
>> +     desc->owner = THIS_MODULE;
>
>> +     [...]
>> +}
>
> This series adds a number of bool Kconfig symbols. So, as far as I can
> see, the code it adds can only be built-in.
>
> This series also uses a number of module specific constructs (ie,
> THIS_MODULE, MODULE_DEVICE_TABLE, module_exit, MODULE_AUTHOR,
> MODULE_DESCRIPTION, and MODULE_LICENSE). So I wonder whether it was
> intended to make these new Kconfig symbols tristate instead?
>

I think it could be tristate if
  -  all the "pinctrl-names" properties are ripped off from the
     mandatory devices in the device tree
  -  all the necessary pinmux settings have been done in the
     boot-loader or somewhere.

But, such a use-case is really limited, so either boolean or tristate
makes sense for pinctrl drivers, I think.

Actually, most of pinctrl drivers are boolean, but most of them
conventionally have MODULE_AUTHOR, THIS_MODULE, etc.

I do not think it looks so weird.  Thought?

$ git grep MODULE_AUTHOR -- drivers/pinctrl/

drivers/pinctrl/bcm/pinctrl-bcm281xx.c:MODULE_AUTHOR("Broadcom
Corporation <bcm-kernel-feedback-list@broadcom.com>");
drivers/pinctrl/bcm/pinctrl-bcm281xx.c:MODULE_AUTHOR("Sherman Yin
<syin@broadcom.com>");
drivers/pinctrl/bcm/pinctrl-bcm2835.c:MODULE_AUTHOR("Chris Boot, Simon
Arlott, Stephen Warren");
drivers/pinctrl/bcm/pinctrl-cygnus-mux.c:MODULE_AUTHOR("Ray Jui
<rjui@broadcom.com>");
drivers/pinctrl/berlin/berlin-bg2.c:MODULE_AUTHOR("Antoine T??nart
<antoine.tenart@free-electrons.com>");
drivers/pinctrl/berlin/berlin-bg2cd.c:MODULE_AUTHOR("Antoine T??nart
<antoine.tenart@free-electrons.com>");
drivers/pinctrl/berlin/berlin-bg2q.c:MODULE_AUTHOR("Antoine T??nart
<antoine.tenart@free-electrons.com>");
drivers/pinctrl/freescale/pinctrl-imx1.c:MODULE_AUTHOR("Alexander
Shiyan <shc_work@mail.ru>");
drivers/pinctrl/freescale/pinctrl-imx21.c:MODULE_AUTHOR("Alexander
Shiyan <shc_work@mail.ru>");
drivers/pinctrl/freescale/pinctrl-imx23.c:MODULE_AUTHOR("Shawn Guo
<shawn.guo@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx25.c:MODULE_AUTHOR("Denis Carikli
<denis@eukrea.com>");
drivers/pinctrl/freescale/pinctrl-imx27.c:MODULE_AUTHOR("Markus
Pargmann <mpa@pengutronix.de>");
drivers/pinctrl/freescale/pinctrl-imx28.c:MODULE_AUTHOR("Shawn Guo
<shawn.guo@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx35.c:MODULE_AUTHOR("Dong Aisheng
<dong.aisheng@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx51.c:MODULE_AUTHOR("Dong Aisheng
<dong.aisheng@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx53.c:MODULE_AUTHOR("Dong Aisheng
<dong.aisheng@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx6dl.c:MODULE_AUTHOR("Shawn Guo
<shawn.guo@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx6q.c:MODULE_AUTHOR("Dong Aisheng
<dong.aisheng@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx6sl.c:MODULE_AUTHOR("Shawn Guo
<shawn.guo@linaro.org>");
drivers/pinctrl/freescale/pinctrl-imx6sx.c:MODULE_AUTHOR("Anson Huang
<Anson.Huang@freescale.com>");
drivers/pinctrl/freescale/pinctrl-imx7d.c:MODULE_AUTHOR("Anson Huang
<Anson.Huang@freescale.com>");
drivers/pinctrl/intel/pinctrl-cherryview.c:MODULE_AUTHOR("Mika
Westerberg <mika.westerberg@linux.intel.com>");
drivers/pinctrl/intel/pinctrl-intel.c:MODULE_AUTHOR("Mathias Nyman
<mathias.nyman@linux.intel.com>");
drivers/pinctrl/intel/pinctrl-intel.c:MODULE_AUTHOR("Mika Westerberg
<mika.westerberg@linux.intel.com>");
drivers/pinctrl/intel/pinctrl-sunrisepoint.c:MODULE_AUTHOR("Mathias
Nyman <mathias.nyman@linux.intel.com>");
drivers/pinctrl/intel/pinctrl-sunrisepoint.c:MODULE_AUTHOR("Mika
Westerberg <mika.westerberg@linux.intel.com>");
drivers/pinctrl/mediatek/pinctrl-mt6397.c:MODULE_AUTHOR("Hongzhou Yang
<hongzhou.yang@mediatek.com>");
drivers/pinctrl/mediatek/pinctrl-mt8127.c:MODULE_AUTHOR("Yingjoe Chen
<yingjoe.chen@mediatek.com>");
drivers/pinctrl/mediatek/pinctrl-mt8135.c:MODULE_AUTHOR("Hongzhou Yang
<hongzhou.yang@mediatek.com>");
drivers/pinctrl/mediatek/pinctrl-mt8173.c:MODULE_AUTHOR("Hongzhou Yang
<hongzhou.yang@mediatek.com>");
drivers/pinctrl/mediatek/pinctrl-mtk-common.c:MODULE_AUTHOR("Hongzhou
Yang <hongzhou.yang@mediatek.com>");
drivers/pinctrl/meson/pinctrl-meson.c:MODULE_AUTHOR("Beniamino Galvani
<b.galvani@gmail.com>");
drivers/pinctrl/mvebu/pinctrl-armada-370.c:MODULE_AUTHOR("Thomas
Petazzoni <thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/mvebu/pinctrl-armada-375.c:MODULE_AUTHOR("Thomas
Petazzoni <thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/mvebu/pinctrl-armada-38x.c:MODULE_AUTHOR("Thomas
Petazzoni <thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/mvebu/pinctrl-armada-39x.c:MODULE_AUTHOR("Thomas
Petazzoni <thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/mvebu/pinctrl-armada-xp.c:MODULE_AUTHOR("Thomas
Petazzoni <thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/mvebu/pinctrl-dove.c:MODULE_AUTHOR("Sebastian
Hesselbarth <sebastian.hesselbarth@gmail.com>");
drivers/pinctrl/mvebu/pinctrl-kirkwood.c:MODULE_AUTHOR("Sebastian
Hesselbarth <sebastian.hesselbarth@gmail.com>");
drivers/pinctrl/mvebu/pinctrl-orion.c:MODULE_AUTHOR("Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>");
drivers/pinctrl/nomadik/pinctrl-abx500.c:MODULE_AUTHOR("Patrice
Chotard <patrice.chotard@st.com>");
drivers/pinctrl/nomadik/pinctrl-nomadik.c:MODULE_AUTHOR("Prafulla
WADASKAR and Alessandro Rubini");
drivers/pinctrl/pinctrl-adi2.c:MODULE_AUTHOR("Sonic Zhang
<sonic.zhang@analog.com>");
drivers/pinctrl/pinctrl-amd.c:MODULE_AUTHOR("Ken Xue
<Ken.Xue@amd.com>, Jeff Wu <Jeff.Wu@amd.com>");
drivers/pinctrl/pinctrl-as3722.c:MODULE_AUTHOR("Laxman
Dewangan<ldewangan@nvidia.com>");
drivers/pinctrl/pinctrl-at91.c:MODULE_AUTHOR("Jean-Christophe
PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>");
drivers/pinctrl/pinctrl-coh901.c:MODULE_AUTHOR("Linus Walleij
<linus.walleij@stericsson.com>");
drivers/pinctrl/pinctrl-lpc18xx.c:MODULE_AUTHOR("Joachim Eastwood
<manabian@gmail.com>");
drivers/pinctrl/pinctrl-palmas.c:MODULE_AUTHOR("Laxman
Dewangan<ldewangan@nvidia.com>");
drivers/pinctrl/pinctrl-rockchip.c:MODULE_AUTHOR("Heiko Stuebner
<heiko@sntech.de>");
drivers/pinctrl/pinctrl-single.c:MODULE_AUTHOR("Tony Lindgren
<tony@atomide.com>");
drivers/pinctrl/pinctrl-tb10x.c:MODULE_AUTHOR("Christian Ruppert
<christian.ruppert@abilis.com>");
drivers/pinctrl/pinctrl-tegra-xusb.c:MODULE_AUTHOR("Thierry Reding
<treding@nvidia.com>");
drivers/pinctrl/pinctrl-tegra114.c:MODULE_AUTHOR("Pritesh Raithatha
<praithatha@nvidia.com>");
drivers/pinctrl/pinctrl-tegra124.c:MODULE_AUTHOR("Ashwini Ghuge
<aghuge@nvidia.com>");
drivers/pinctrl/pinctrl-tegra20.c:MODULE_AUTHOR("Stephen Warren
<swarren@nvidia.com>");
drivers/pinctrl/pinctrl-tegra210.c:MODULE_AUTHOR("NVIDIA");
drivers/pinctrl/pinctrl-tegra30.c:MODULE_AUTHOR("Stephen Warren
<swarren@nvidia.com>");
drivers/pinctrl/pinctrl-tz1090-pdc.c:MODULE_AUTHOR("Imagination
Technologies Ltd.");
drivers/pinctrl/pinctrl-tz1090.c:MODULE_AUTHOR("Imagination Technologies Ltd.");
drivers/pinctrl/pinctrl-u300.c:MODULE_AUTHOR("Linus Walleij
<linus.walleij@linaro.org>");
drivers/pinctrl/pinctrl-zynq.c:MODULE_AUTHOR("S??ren Brinkmann
<soren.brinkmann@xilinx.com>");
drivers/pinctrl/qcom/pinctrl-apq8064.c:MODULE_AUTHOR("Bjorn Andersson
<bjorn.andersson@sonymobile.com>");
drivers/pinctrl/qcom/pinctrl-ipq8064.c:MODULE_AUTHOR("Andy Gross
<agross@codeaurora.org>");
drivers/pinctrl/qcom/pinctrl-msm8660.c:MODULE_AUTHOR("Bjorn Andersson
<bjorn.andersson@sonymobile.com>");
drivers/pinctrl/qcom/pinctrl-msm8960.c:MODULE_AUTHOR("Bjorn Andersson
<bjorn.andersson@sonymobile.com>");
drivers/pinctrl/qcom/pinctrl-msm8x74.c:MODULE_AUTHOR("Bjorn Andersson
<bjorn.andersson@sonymobile.com>");
drivers/pinctrl/qcom/pinctrl-spmi-gpio.c:MODULE_AUTHOR("Ivan T. Ivanov
<iivanov@mm-sol.com>");
drivers/pinctrl/qcom/pinctrl-spmi-mpp.c:MODULE_AUTHOR("Ivan T. Ivanov
<iivanov@mm-sol.com>");
drivers/pinctrl/samsung/pinctrl-exynos5440.c:MODULE_AUTHOR("Thomas
Abraham <thomas.ab@samsung.com>");
drivers/pinctrl/samsung/pinctrl-samsung.c:MODULE_AUTHOR("Thomas
Abraham <thomas.ab@samsung.com>");
drivers/pinctrl/sh-pfc/core.c:MODULE_AUTHOR("Magnus Damm, Paul Mundt,
Laurent Pinchart");
drivers/pinctrl/sirf/pinctrl-sirf.c:MODULE_AUTHOR("Rongjun Ying
<rongjun.ying@csr.com>");
drivers/pinctrl/sirf/pinctrl-sirf.c:MODULE_AUTHOR("Yuping Luo
<yuping.luo@csr.com>");
drivers/pinctrl/sirf/pinctrl-sirf.c:MODULE_AUTHOR("Barry Song
<baohua.song@csr.com>");
drivers/pinctrl/spear/pinctrl-plgpio.c:MODULE_AUTHOR("Viresh Kumar
<viresh.kumar@linaro.org>");
drivers/pinctrl/spear/pinctrl-spear1310.c:MODULE_AUTHOR("Viresh Kumar
<viresh.linux@gmail.com>");
drivers/pinctrl/spear/pinctrl-spear1340.c:MODULE_AUTHOR("Viresh Kumar
<viresh.linux@gmail.com>");
drivers/pinctrl/spear/pinctrl-spear300.c:MODULE_AUTHOR("Viresh Kumar
<viresh.linux@gmail.com>");
drivers/pinctrl/spear/pinctrl-spear310.c:MODULE_AUTHOR("Viresh Kumar
<viresh.linux@gmail.com>");
drivers/pinctrl/spear/pinctrl-spear320.c:MODULE_AUTHOR("Viresh Kumar
<viresh.linux@gmail.com>");
drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c:MODULE_AUTHOR("Maxime
Ripard <maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:MODULE_AUTHOR("Boris
Brezillon <boris.brezillon at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:MODULE_AUTHOR("Maxime
Ripard <maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c:MODULE_AUTHOR("Hans de
Goede <hdegoede@redhat.com>");
drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c:MODULE_AUTHOR("Chen-Yu
Tsai <wens@csie.org>");
drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c:MODULE_AUTHOR("Boris
Brezillon <boris.brezillon at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c:MODULE_AUTHOR("Maxime
Ripard <maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c:MODULE_AUTHOR("Chen-Yu Tsai
<wens@csie.org>");
drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard at free-electrons.com");
drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c:MODULE_AUTHOR("Vishnu
Patekar <vishnupatekar0510@gmail.com>");
drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c:MODULE_AUTHOR("Maxime Ripard
<maxime.ripard@free-electrons.com>");
drivers/pinctrl/vt8500/pinctrl-vt8500.c:MODULE_AUTHOR("Tony Prisk
<linux@prisktech.co.nz>");
drivers/pinctrl/vt8500/pinctrl-wm8505.c:MODULE_AUTHOR("Tony Prisk
<linux@prisktech.co.nz>");
drivers/pinctrl/vt8500/pinctrl-wm8650.c:MODULE_AUTHOR("Tony Prisk
<linux@prisktech.co.nz>");
drivers/pinctrl/vt8500/pinctrl-wm8750.c:MODULE_AUTHOR("Tony Prisk
<linux@prisktech.co.nz>");
drivers/pinctrl/vt8500/pinctrl-wm8850.c:MODULE_AUTHOR("Tony Prisk
<linux@prisktech.co.nz>");






-- 
Best Regards
Masahiro Yamada
