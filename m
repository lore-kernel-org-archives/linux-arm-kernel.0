From: peter.ujfalusi@nokia.com (Peter Ujfalusi)
Date: Wed, 26 May 2010 14:16:49 +0300
Subject: [alsa-devel] [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
	<1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
Message-ID: <201005261416.49362.peter.ujfalusi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 26 May 2010 08:09:46 ext Ryan Mallon wrote:
> Add ep93xx i2s audio driver

..

> +static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info)
> +{
> +       int i;
> +
> +       /* Disable fifos */
> +       for (i = 0; i < 3; i++) {
> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN + (i * 4), 0);
> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN + (i * 4), 0);
> +       }
> +
> +       /* Disable i2s */
> +       ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
> +
> +       /* Disable clocks */
> +       clk_disable(info->lrclk);
> +       clk_disable(info->sclk);
> +       clk_disable(info->mclk);
> +}

I think this will break the other stream in duplex case, since you stop both 
FIFOs, and also disable the clocks.
Does the ep93xx supports duplex audio?

-- 
P?ter
