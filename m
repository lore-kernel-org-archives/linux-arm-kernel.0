From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Sep 2011 15:30:51 +0200
Subject: [PATCH v3 1/1] ASoC: mxs-saif: add record function
In-Reply-To: <1315399910-6525-1-git-send-email-b29396@freescale.com>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
Message-ID: <20110909133051.GS1912@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 08:51:50PM +0800, Dong Aisheng wrote:
> 1. add different clkmux mode handling
> SAIF can use two instances to implement full duplex (playback &
> recording) and record saif may work on EXTMASTER mode which is
> using other saif's BITCLK&LRCLK.
> 
> The clkmux mode could be set in pdata->init() in mach-specific code.
> For generic saif driver, it only needs to know who is his master
> and the master id is also provided in mach-specific code.
> 
> 2. support playback and capture simutaneously however the sample
> rates can not be different due to hw limitation.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

One thing I see...

> @@ -422,20 +503,39 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
>  			__raw_readl(saif->base + SAIF_DATA);
>  		}
>  
> -		dev_dbg(cpu_dai->dev, "CTRL 0x%x STAT 0x%x\n",
> +		master_saif->ongoing = 1;
> +
> +		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
>  			__raw_readl(saif->base + SAIF_CTRL),
>  			__raw_readl(saif->base + SAIF_STAT));
>  
> +		dev_dbg(master_saif->dev, "CTRL 0x%x STAT 0x%x\n",
> +			__raw_readl(master_saif->base + SAIF_CTRL),
> +			__raw_readl(master_saif->base + SAIF_STAT));
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		dev_dbg(cpu_dai->dev, "stop\n");
>  
> -		clk_disable(saif->clk);
> -		if (!saif->mclk_in_use)
> +		/* wait a while for the current sample to complete */
> +		delay = USEC_PER_SEC / master_saif->cur_rate;
> +
> +		if (!master_saif->mclk_in_use) {
> +			__raw_writel(BM_SAIF_CTRL_RUN,
> +				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +			udelay(delay);
> +		}
> +		clk_disable(master_saif->clk);
> +
> +		if (saif != master_saif) {
>  			__raw_writel(BM_SAIF_CTRL_RUN,
>  				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +			udelay(delay);

I think we should use usleep_range for both udelays here? Having a rate
of 8000, we'd burn 250us here.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110909/56c6ccac/attachment.sig>
