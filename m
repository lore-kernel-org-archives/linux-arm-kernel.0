From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 May 2017 18:33:59 +0100
Subject: [PATCH v4 2/3] ASoC: stm32: Add I2S driver
In-Reply-To: <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
References: <1495120793-11687-1-git-send-email-olivier.moysan@st.com>
 <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
Message-ID: <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 05:19:52PM +0200, olivier moysan wrote:

This looks good so I'm going to apply it, a few things below though -
can you please send a followup patch for the issue with the Kconfig
symbol?

> --- a/sound/soc/stm/Kconfig
> +++ b/sound/soc/stm/Kconfig
> @@ -5,4 +5,4 @@ menuconfig SND_SOC_STM32
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	select REGMAP_MMIO
>  	help
> -	  Say Y if you want to enable ASoC-support for STM32
> +	  Say Y if you want to enable ASoC support for STM32

This appears to be an unrelated typo fix.

> diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
> index e466a47..8251931 100644
> --- a/sound/soc/stm/Makefile
> +++ b/sound/soc/stm/Makefile
> @@ -4,3 +4,7 @@ obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
>  
>  snd-soc-stm32-sai-objs := stm32_sai.o
>  obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
> +
> +# I2S
> +snd-soc-stm32-i2s-objs := stm32_i2s.o
> +obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-i2s.o

Perhaps make this a separate option?  It probably makes sense to rename
the option for the SAI at the same time.

> +
> +	ret = clk_prepare_enable(i2s->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(i2s->i2sclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
> +		goto err_pclk_disable;
> +	}

It'd be nice to have runtime PM to disable these when the device is idle
but that's not essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/66ffa55c/attachment.sig>
