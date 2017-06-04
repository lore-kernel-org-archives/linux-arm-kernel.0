From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 05 Jun 2017 03:03:47 +0800
Subject: [PATCH v2 04/11] drm: sun4i: add support for H3's TCON0/1
In-Reply-To: <3642057.oKT9kIlu8M@jernej-laptop>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-5-icenowy@aosc.io> <3642057.oKT9kIlu8M@jernej-laptop>
Message-ID: <493AC6F2-3CB3-48F5-9568-A34AA927238F@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?5? GMT+08:00 ??2:46:24, "Jernej ?krabec" <jernej.skrabec@siol.net> ??:
>Hi,
>
>Dne nedelja, 04. junij 2017 ob 18:01:42 CEST je Icenowy Zheng
>napisal(a):
>> From: Icenowy Zheng <icenowy@aosc.xyz>
>> 
>> Allwinner H3 has two special TCONs, both come without channel0. And
>the
>> TCON1 of H3 has no special clocks even for the channel1.
>> 
>> Add support for these kinds of TCON.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Merged TCON0 and TCON1 quirks and compatibles.
>> 
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 52
>> +++++++++++++++++++++++++-------------
>drivers/gpu/drm/sun4i/sun4i_tcon.h |
>>  1 +
>>  2 files changed, 36 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 568cea0e5f8f..62ba4fc19f18
>> 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -59,6 +59,7 @@ void sun4i_tcon_channel_disable(struct sun4i_tcon
>*tcon,
>> int channel)
>> 
>>  	/* Disable the TCON's channel */
>>  	if (channel == 0) {
>> +		WARN_ON(!tcon->quirks->has_channel_0);
>>  		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
>>  				   SUN4I_TCON0_CTL_TCON_ENABLE, 0);
>>  		clk_disable_unprepare(tcon->dclk);
>> @@ -78,6 +79,7 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon
>*tcon,
>> int channel)
>> 
>>  	/* Enable the TCON's channel */
>>  	if (channel == 0) {
>> +		WARN_ON(!tcon->quirks->has_channel_0);
>>  		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
>>  				   SUN4I_TCON0_CTL_TCON_ENABLE,
>>  				   SUN4I_TCON0_CTL_TCON_ENABLE);
>> @@ -159,6 +161,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon
>*tcon,
>> 
>>  	/* Configure the dot clock */
>>  	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
>> +	WARN_ON(!tcon->quirks->has_channel_0);
>> 
>>  	/* Adjust clock delay */
>>  	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
>> @@ -366,10 +369,12 @@ static int sun4i_tcon_init_clocks(struct device
>*dev,
>>  	}
>>  	clk_prepare_enable(tcon->clk);
>> 
>> -	tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
>> -	if (IS_ERR(tcon->sclk0)) {
>> -		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
>> -		return PTR_ERR(tcon->sclk0);
>> +	if (tcon->quirks->has_channel_0) {
>> +		tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
>> +		if (IS_ERR(tcon->sclk0)) {
>> +			dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
>> +			return PTR_ERR(tcon->sclk0);
>> +		}
>>  	}
>> 
>>  	if (tcon->quirks->has_channel_1) {
>> @@ -594,10 +599,12 @@ static int sun4i_tcon_bind(struct device *dev,
>struct
>> device *master, goto err_free_clocks;
>>  	}
>> 
>> -	ret = sun4i_dclk_create(dev, tcon);
>> -	if (ret) {
>> -		dev_err(dev, "Couldn't create our TCON dot clock\n");
>> -		goto err_free_clocks;
>> +	if (tcon->quirks->has_channel_0) {
>> +		ret = sun4i_dclk_create(dev, tcon);
>> +		if (ret) {
>> +			dev_err(dev, "Couldn't create our TCON dot clock\n");
>> +			goto err_free_clocks;
>> +		}
>>  	}
>> 
>>  	ret = sun4i_tcon_init_irq(dev, tcon);
>> @@ -622,7 +629,8 @@ static int sun4i_tcon_bind(struct device *dev,
>struct
>> device *master, return 0;
>> 
>>  err_free_dotclock:
>> -	sun4i_dclk_free(tcon);
>> +	if (tcon->quirks->has_channel_0)
>> +		sun4i_dclk_free(tcon);
>>  err_free_clocks:
>>  	sun4i_tcon_free_clocks(tcon);
>>  err_assert_reset:
>> @@ -636,7 +644,9 @@ static void sun4i_tcon_unbind(struct device *dev,
>struct
>> device *master, struct sun4i_tcon *tcon = dev_get_drvdata(dev);
>> 
>>  	list_del(&tcon->list);
>> -	sun4i_dclk_free(tcon);
>> +
>> +	if (tcon->quirks->has_channel_0)
>> +		sun4i_dclk_free(tcon);
>>  	sun4i_tcon_free_clocks(tcon);
>>  }
>> 
>> @@ -667,24 +677,32 @@ static int sun4i_tcon_remove(struct
>platform_device
>> *pdev) }
>> 
>>  static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
>> -	.has_unknown_mux = true,
>> -	.has_channel_1	= true,
>> +	.has_unknown_mux	= true,
>> +	.has_channel_0		= true,
>> +	.has_channel_1		= true,
>>  };
>> 
>>  static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
>> -	.has_channel_1	= true,
>> +	.has_channel_0		= true,
>> +	.has_channel_1		= true,
>>  };
>> 
>>  static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
>> -	.has_channel_1	= true,
>> +	.has_channel_0		= true,
>> +	.has_channel_1		= true,
>>  };
>> 
>>  static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
>> -	/* nothing is supported */
>> +	.has_channel_0	= true,
>>  };
>> 
>>  static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
>> -	/* nothing is supported */
>> +	.has_channel_0	= true,
>> +};
>> +
>> +static const struct sun4i_tcon_quirks sun8i_h3_quirks = {
>> +	.has_channel_1		= true,
>> +	.swappable_input	= true,
>>  };
>> 
>>  static const struct of_device_id sun4i_tcon_of_table[] = {
>> @@ -693,7 +711,7 @@ static const struct of_device_id
>sun4i_tcon_of_table[] =
>> { { .compatible = "allwinner,sun6i-a31s-tcon", .data =
>&sun6i_a31s_quirks
>> }, { .compatible = "allwinner,sun8i-a33-tcon", .data =
>&sun8i_a33_quirks },
>> { .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks
>},
>> -	{ }
>> +	{ .compatible = "allwinner,sun8i-h3-tcon", .data = &sun8i_h3_quirks
>},
>
>I think you need to leave empty entry as a sentinel.

Sorry.

>
>>  };
>>  MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> b/drivers/gpu/drm/sun4i/sun4i_tcon.h index c3e01c06e9a0..9c706a0bd478
>> 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> @@ -145,6 +145,7 @@
>> 
>>  struct sun4i_tcon_quirks {
>>  	bool	has_unknown_mux; /* sun5i has undocumented mux */
>> +	bool	has_channel_0;	/* some A83T+ TCONs don't have channel 0*/
>>  	bool	has_channel_1;	/* a33 does not have channel 1 */
>>  	/* Some DE2 can swap the mixer<->TCON connection */
>>  	bool	swappable_input;
>> --
>> 2.12.2
>
>You missed sun4i_rgb_init() function which should also be guarded with
>"if 
>(tcon->quirks->has_channel_0)".
>

Yes...

>You should also expand function sun4i_drv_node_is_tcon() at sun4i_drv.c
>with 
>new entries, but I'm not sure if this fits in this patch.

Instead I think it should be renamed to something like
"sun4i_drv_node_is_tcon_with_ch0".

>
>Best regards,
>Jernej
