From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Jun 2013 16:49:21 +0800
Subject: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire its clock
In-Reply-To: <1370826467-30399-1-git-send-email-festevam@gmail.com>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
Message-ID: <20130610084919.GC6381@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 10:07:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On a mx6qsabrelite board the following error happens on probe:
> 
> sgtl5000: probe of 0-000a failed with error -5
> imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered
> imx-sgtl5000 sound.13: snd_soc_register_card failed (-517)
> platform sound.13: Driver imx-sgtl5000 requests probe defer
> 
> Prior to reading the codec ID we need to turn the SYS_MCLK clock, so let's 
> enable the codec clock inside sgtl5000_i2c_probe().
> 
> Also remove the codec clock enable/disable functions from the machine driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> I haven't had a chance to convert mx28 to pass the codec clock via device tree
> yet. It looks like it is a bit trickier there, as it uses the saif clock.
> 
> Given that mx28 audio playback is already broken in linux-next, this series
> does not make things worse on mx28 side.

Okay.  But I assume you will get it fixed soon.

> 
>  sound/soc/codecs/sgtl5000.c  | 34 ++++++++++++++++++++++++++++++----
>  sound/soc/fsl/imx-sgtl5000.c | 30 +++++++-----------------------
>  2 files changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index c8f2afb..2e0227b 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -114,6 +114,7 @@ struct sgtl5000_priv {
>  	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
>  	struct ldo_regulator *ldo;
>  	struct regmap *regmap;
> +	struct clk *mclk;
>  };
>  
>  /*
> @@ -1522,16 +1523,28 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	sgtl5000->mclk = devm_clk_get(&client->dev, NULL);
> +	if (IS_ERR(sgtl5000->mclk)) {
> +		ret = PTR_ERR(sgtl5000->mclk);
> +		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sgtl5000->mclk);
> +	if (ret)
> +		return ret;
> +
>  	/* read chip information */
>  	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
>  	if (ret)
> -		return ret;
> +		goto disable_clk;
>  
>  	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
>  	    SGTL5000_PARTID_PART_ID) {
>  		dev_err(&client->dev,
>  			"Device with ID register %x is not a sgtl5000\n", reg);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto disable_clk;
>  	}
>  
>  	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
> @@ -1542,17 +1555,30 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>  	/* Ensure sgtl5000 will start with sane register values */
>  	ret = sgtl5000_fill_defaults(sgtl5000);
>  	if (ret)
> -		return ret;
> +		goto disable_clk;
>  
>  	ret = snd_soc_register_codec(&client->dev,
>  			&sgtl5000_driver, &sgtl5000_dai, 1);
> +	if (ret)
> +		goto disable_clk;
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(sgtl5000->mclk);
>  	return ret;
>  }
>  
>  static int sgtl5000_i2c_remove(struct i2c_client *client)
>  {
> -	snd_soc_unregister_codec(&client->dev);
> +	struct sgtl5000_priv *sgtl5000;
> +	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
> +								GFP_KERNEL);

Are you kidding?  You should call i2c_get_clientdata() rather than
devm_kzalloc() to get the pointer.

> +	if (!sgtl5000)
> +		return -ENOMEM;
>  
> +	snd_soc_unregister_codec(&client->dev);
> +	clk_disable_unprepare(sgtl5000->mclk);
>  	return 0;
>  }
>  
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index a60aaa0..823151b 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -129,20 +129,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	}
>  
>  	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> -	if (IS_ERR(data->codec_clk)) {
> -		/* assuming clock enabled by default */
> -		data->codec_clk = NULL;
> -		ret = of_property_read_u32(codec_np, "clock-frequency",
> -					&data->clk_frequency);
> -		if (ret) {
> -			dev_err(&codec_dev->dev,
> -				"clock-frequency missing or invalid\n");
> -			goto fail;
> -		}
> -	} else {
> -		data->clk_frequency = clk_get_rate(data->codec_clk);
> -		clk_prepare_enable(data->codec_clk);
> -	}
> +	if (IS_ERR(data->codec_clk))
> +		goto fail;
> +
> +	data->clk_frequency = clk_get_rate(data->codec_clk);

With codec driver setting up the clock now, the only use of codec_clk 
n this machine driver is getting the rate and setting up sysclk with
snd_soc_dai_set_sysclk().  I'm wondering if it makes more sense to move
all these over into codec driver, so that machine driver does not need
to touch the clock at all.

Shawn

>  
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
> @@ -157,10 +147,10 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	data->card.dev = &pdev->dev;
>  	ret = snd_soc_of_parse_card_name(&data->card, "model");
>  	if (ret)
> -		goto clk_fail;
> +		goto fail;
>  	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
>  	if (ret)
> -		goto clk_fail;
> +		goto fail;
>  	data->card.num_links = 1;
>  	data->card.owner = THIS_MODULE;
>  	data->card.dai_link = &data->dai;
> @@ -170,7 +160,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	ret = snd_soc_register_card(&data->card);
>  	if (ret) {
>  		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> -		goto clk_fail;
> +		goto fail;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -179,8 +169,6 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -clk_fail:
> -	clk_put(data->codec_clk);
>  fail:
>  	if (ssi_np)
>  		of_node_put(ssi_np);
> @@ -194,10 +182,6 @@ static int imx_sgtl5000_remove(struct platform_device *pdev)
>  {
>  	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
>  
> -	if (data->codec_clk) {
> -		clk_disable_unprepare(data->codec_clk);
> -		clk_put(data->codec_clk);
> -	}
>  	snd_soc_unregister_card(&data->card);
>  
>  	return 0;
> -- 
> 1.8.1.2
> 
