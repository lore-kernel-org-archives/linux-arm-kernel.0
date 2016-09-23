From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 16:27:37 -0500
Subject: [PATCH v2] ASoC: rk3399_gru_sound: fix recording pop at first
 attempt
In-Reply-To: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
References: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20160923212737.GA17658@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 09:50:06PM +0800, Xing Zheng wrote:
> From: Wonjoon Lee <woojoo.lee@samsung.com>
> 
> Pop happens when mclk applied but dmic's own boot-time

This statement doesn't make sense.

> Specify dmic delay times in dt to make sure
> clocks are ready earlier than dmic working

I don't think this really belongs in DT. Seems like better control of 
the init order is needed. Or why not just a fixed delay in the driver?

> 
> Signed-off-by: Wonjoon Lee <woojoo.lee@samsung.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2:
> - rename dmic-delay to dmic-wakeup-delay-ms
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 +++++++
>  sound/soc/rockchip/rk3399_gru_sound.c                      | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index f19b6c8..eac91db 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -6,10 +6,17 @@ Required properties:
>    connected to the codecs
>  - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
>  
> +Optional properties:
> +- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> +  If this option is specified, which means it's required dmic need
> +  delay for DMIC to ready so that rt5514 can avoid recording before
> +  DMIC send valid data
> +
>  Example:
>  
>  sound {
>  	compatible = "rockchip,rk3399-gru-sound";
>  	rockchip,cpu = <&i2s0>;
>  	rockchip,codec = <&max98357a &rt5514 &da7219>;
> +	dmic-wakeup-delay-ms = <20>;
>  };
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index ee06489..9ed735a 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -38,6 +38,8 @@
>  
>  #define SOUND_FS	256
>  
> +unsigned int rt5514_dmic_delay;
> +
>  static struct snd_soc_jack rockchip_sound_jack;
>  
>  static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
> @@ -123,6 +125,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> +	/* Wait for DMIC stable */
> +	msleep(rt5514_dmic_delay);
> +
>  	return 0;
>  }
>  
> @@ -343,6 +348,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/* Set DMIC delay */
> +	ret = device_property_read_u32(&pdev->dev, "dmic-delay",

Obviously, this doesn't work now...

> +					&rt5514_dmic_delay);
> +	if (ret) {
> +		rt5514_dmic_delay = 0;
> +		dev_dbg(&pdev->dev,
> +			"no optional property 'dmic-delay' found, default: no delay\n");
> +	}
> +
>  	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
>  	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
>  	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -- 
> 1.9.1
> 
> 
