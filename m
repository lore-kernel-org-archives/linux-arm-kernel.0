From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 28 Jul 2015 17:13:03 +0200
Subject: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver driver
In-Reply-To: <8512006.Rsa7Aqr0B5@diego>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <8512006.Rsa7Aqr0B5@diego>
Message-ID: <1438096383.3969.39.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-28 at 16:28 +0200, Heiko St?bner wrote:
> Hi,
> 
> could you streamline the prefixes a bit perhaps? I.e. so far I've 
> seen
> 
> rk_spdif_dev
> spdif_runtime_suspend
> rockchip_snd_txctrl
> rockchip_spdif_hw_params
> 
> I guess rockchip_spdif_* or rk_spdif_* for everything might make this 
> a bit 
> nicer

Will do in V2, i probalby copied a few too many warts from the i2s
driver ;)

Thanks for the review!


> Am Dienstag, 28. Juli 2015, 14:03:29 schrieb Sjoerd Simons:
> > Add a driver for the SDPIF transceiver available on RK3066, RK3188 
> > and
> > RK3288. Heavily based on the rockchip i2s driver.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> >  sound/soc/rockchip/Kconfig          |   9 +
> >  sound/soc/rockchip/Makefile         |   3 +
> >  sound/soc/rockchip/rockchip_spdif.c | 375
> > ++++++++++++++++++++++++++++++++++++ 
> > sound/soc/rockchip/rockchip_spdif.h | 
> > 63 ++++++
> >  4 files changed, 450 insertions(+)
> >  create mode 100644 sound/soc/rockchip/rockchip_spdif.c
> >  create mode 100644 sound/soc/rockchip/rockchip_spdif.h
> > 
> > diff --git a/sound/soc/rockchip/Kconfig 
> > b/sound/soc/rockchip/Kconfig
> > index 58bae8e..20bc676 100644
> > --- a/sound/soc/rockchip/Kconfig
> > +++ b/sound/soc/rockchip/Kconfig
> > @@ -15,6 +15,14 @@ config SND_SOC_ROCKCHIP_I2S
> >  	  Rockchip I2S device. The device supports upto maximum of
> >  	  8 channels each for play and record.
> > 
> > +config SND_SOC_ROCKCHIP_SPDIF
> > +	tristate "Rockchip SPDIF Device Driver"
> > +	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
> > +	select SND_SOC_GENERIC_DMAENGINE_PCM
> > +	help
> > +	  Say Y or M if you want to add support for SPDIF driver 
> > for
> > +	  Rockchip SPDIF transceiver device.
> > +
> >  config SND_SOC_ROCKCHIP_MAX98090
> >  	tristate "ASoC support for Rockchip boards using a 
> > MAX98090 codec"
> >  	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
> > @@ -33,3 +41,4 @@ config SND_SOC_ROCKCHIP_RT5645
> >  	help
> >  	  Say Y or M here if you want to add support for SoC audio 
> > on Rockchip
> >  	  boards using the RT5645/RT5650 codec, such as Veyron.
> > +
> 
> unrelated newline
> 
> > diff --git a/sound/soc/rockchip/Makefile 
> > b/sound/soc/rockchip/Makefile
> > index 1bc1dc3..b02ab69 100644
> > --- a/sound/soc/rockchip/Makefile
> > +++ b/sound/soc/rockchip/Makefile
> > @@ -1,10 +1,13 @@
> >  # ROCKCHIP Platform Support
> >  snd-soc-i2s-objs := rockchip_i2s.o
> > +snd-soc-spdif-objs := rockchip_spdif.o
> > 
> >  obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
> > +obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-spdif.o
> > 
> >  snd-soc-rockchip-max98090-objs := rockchip_max98090.o
> >  snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
> > 
> >  obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip
> > -max98090.o
> >  obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
> > +
> > diff --git a/sound/soc/rockchip/rockchip_spdif.c
> > b/sound/soc/rockchip/rockchip_spdif.c new file mode 100644
> > index 0000000..e60ccf6
> > --- /dev/null
> > +++ b/sound/soc/rockchip/rockchip_spdif.c
> > @@ -0,0 +1,375 @@
> > +/* sound/soc/rockchip/rockchip_spdif.c
> > + *
> > + * ALSA SoC Audio Layer - Rockchip I2S Controller driver
> 								^spd
> if
> 
> > + *
> > + * Copyright (c) 2014 Rockchip Electronics Co. Ltd.
> > + * Author: Jianqun <jay.xu@rock-chips.com>
> > + * Copyright (c) 2015 Collabora Ltd.
> > + * Author: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > + *
> > + * This program is free software; you can redistribute it and/or 
> > modify
> > + * it under the terms of the GNU General Public License version 2 
> > as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/clk.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/dmaengine_pcm.h>
> > +
> > +#include "rockchip_spdif.h"
> > +
> > +#define DRV_NAME "rockchip-spdif"
> > +
> > +struct rk_spdif_dev {
> > +	struct device *dev;
> > +
> > +	struct clk *mclk;
> > +	struct clk *hclk;
> > +
> > +	struct snd_dmaengine_dai_dma_data playback_dma_data;
> > +
> > +	struct regmap *regmap;
> > +};
> > +
> > +static int spdif_runtime_suspend(struct device *dev)
> > +{
> > +	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(spdif->mclk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int spdif_runtime_resume(struct device *dev)
> > +{
> > +	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(spdif->mclk);
> > +	if (ret) {
> > +		dev_err(spdif->dev, "clock enable failed %d\n", 
> > ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static inline struct rk_spdif_dev *to_info(struct snd_soc_dai 
> > *dai)
> > +{
> > +	return snd_soc_dai_get_drvdata(dai);
> > +}
> > +
> > +static void rockchip_snd_txctrl(struct rk_spdif_dev *spdif, int 
> > on)
> > +{
> > +	if (on) {
> > +		regmap_update_bits(spdif->regmap, SPDIF_DMACR,
> > +				   SPDIF_DMACR_TDE_ENABLE,
> > +				   SPDIF_DMACR_TDE_ENABLE);
> > +
> > +		regmap_update_bits(spdif->regmap, SPDIF_XFER,
> > +				   SPDIF_XFER_TXS_START,
> > +				   SPDIF_XFER_TXS_START);
> 
> personally I'm always unsure of regmap return values. While the 
> underlying 
> method is mmio in this case, regmap_* in theory still has the 
> possibility to 
> return errors, so I'm not sure if it's ok to silently ignore them.
> 
> Here it would simply mean return the error and also return it in 
> rockchip_spdif_trigger below.
> 
> 
> Heiko

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
