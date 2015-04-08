From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Apr 2015 11:25:21 +0200
Subject: [PATCH] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
 <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
Message-ID: <15530630.jvXTF4Jl8n@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 8. April 2015, 16:52:08 schrieb Caesar Wang:
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.
> 
> Signed-off-by: jay.xu <xjq@rock-chips.com>
> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Serien-cc: linux-kernel at vger.kernel.org
> Serien-cc: devicetree at vger.kernel.org
> Serien-cc: dianders at chromium.org
> 
> ---
> 
>  sound/soc/codecs/max98090.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index b112b1c..066954a0 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2611,6 +2611,22 @@ static int max98090_i2c_remove(struct i2c_client
> *client) return 0;
>  }
> 
> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
> +
> +	dev_info(&i2c->dev, "shut down device\n");

is this dev_info really necessary? dev_dbg might be better, or leave it out 
completely, as it doesn't really provide any additional benefit.


> +
> +	/* Enable volume smoothing, disable zero cross.  This will cause
> +	 * a quick 40ms ramp to mute on shutdown.
> +	 */

Comment style is off ... should be

/*
 * Enable volume smoothing, disable zero cross.  This will cause
 * a quick 40ms ramp to mute on shutdown.
 */


> +	regmap_write(max98090->regmap,
> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
> +	regmap_write(max98090->regmap,
> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
> +	msleep(40);
> +}
> +
>  #ifdef CONFIG_PM
>  static int max98090_runtime_resume(struct device *dev)
>  {
> @@ -2697,6 +2713,7 @@ static struct i2c_driver max98090_i2c_driver = {
>  	},
>  	.probe  = max98090_i2c_probe,
>  	.remove = max98090_i2c_remove,
> +	.shutdown = max98090_i2c_shutdown,
>  	.id_table = max98090_i2c_id,
>  };
