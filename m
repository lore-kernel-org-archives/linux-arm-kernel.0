From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 2 May 2012 18:50:24 +0800
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
In-Reply-To: <20120501134446.GK2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
 <20120501134446.GK2194@S2101-09.ap.freescale.net>
Message-ID: <20120502105024.GC2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 09:44:48PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 03:02:57PM +0800, Richard Zhao wrote:
> > From: Richard Zhao <richard.zhao@linaro.org>
> > 
> > It tries to clk_get the clock. And if it failed, it assumes the clock
> > by default enabled.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  sound/soc/fsl/imx-sgtl5000.c |   40 ++++++++++++++++++++++++++++++++--------
> >  1 files changed, 32 insertions(+), 8 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> > index 73b935e..3a729ca 100644
> > --- a/sound/soc/fsl/imx-sgtl5000.c
> > +++ b/sound/soc/fsl/imx-sgtl5000.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/of_i2c.h>
> > +#include <linux/clk.h>
> >  #include <sound/soc.h>
> >  
> >  #include "../codecs/sgtl5000.h"
> > @@ -25,6 +27,7 @@ struct imx_sgtl5000_data {
> >  	struct snd_soc_card card;
> >  	char codec_dai_name[DAI_NAME_SIZE];
> >  	char platform_name[DAI_NAME_SIZE];
> > +	struct clk *codec_clk;
> >  	unsigned int clk_frequency;
> >  };
> >  
> > @@ -58,6 +61,7 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct device_node *ssi_np, *codec_np;
> >  	struct platform_device *ssi_pdev;
> > +	struct i2c_client *codec_dev;
> >  	struct imx_sgtl5000_data *data;
> >  	int int_port, ext_port;
> >  	int ret;
> > @@ -113,6 +117,11 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
> >  		ret = -EINVAL;
> >  		goto fail;
> >  	}
> > +	codec_dev = of_find_i2c_device_by_node(codec_np);
> > +	if (!codec_dev) {
> > +		dev_err(&pdev->dev, "failed to find codec platform device\n");
> > +		return -EINVAL;
> > +	}
> 
> What if the codec is accessed via SPI bus on some machines?
> 
> >  
> >  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data) {
> > @@ -120,11 +129,20 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
> >  		goto fail;
> >  	}
> >  
> > -	ret = of_property_read_u32(codec_np, "clock-frequency",
> > -				   &data->clk_frequency);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "clock-frequency missing or invalid\n");
> > -		goto fail;
> > +	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> 
> It's a clock of sgtl5000 codec.  I feel it makes more sense to have
> sgtl5000 device driver than machine driver to manage this clock.
The ASoC machine driver handled the clock settings, I just followed the
same way, using snd_soc_dai_set_sysclk to set codec clk. But what you
said  is reasonable. I also find it's impossible to use devm_get_clk.

Mark, do you suggest get clk in ASoC machine driver or in codec driver?

Thanks
Richard
> 
> Regards,
> Shawn
> 
> > +	if (IS_ERR(data->codec_clk)) {
> > +		/* assuming clock enabled by default */
> > +		data->codec_clk = NULL;
> > +		ret = of_property_read_u32(codec_np, "clock-frequency",
> > +					&data->clk_frequency);
> > +		if (ret) {
> > +			dev_err(&codec_dev->dev,
> > +				"clock-frequency missing or invalid\n");
> > +			goto fail;
> > +		}
> > +	} else {
> > +		data->clk_frequency = clk_get_rate(data->codec_clk);
> > +		clk_prepare_enable(data->codec_clk);
> >  	}
> 
