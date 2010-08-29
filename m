From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Aug 2010 07:46:08 +1000
Subject: [PATCH 3/3 v3] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100827122230.GF1473@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<20100827122230.GF1473@pengutronix.de>
Message-ID: <201008300746.08153.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a typo and a minor niggle..

On Friday, August 27, 2010 10:22:31 pm Sascha Hauer wrote:
> This patch adds support for the Freescale i.MX SDMA engine.

> +static int sdma_config_ownership(struct sdma_channel *sdmac,
> +		bool event_override, bool mcu_verride, bool dsp_override)
> +{
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +	u32 evt, mcu, dsp;
> +
> +	if (event_override && mcu_verride && dsp_override)
> +		return -EINVAL;
> +
> +	evt = __raw_readl(sdma->regs + SDMA_H_EVTOVR);
> +	mcu = __raw_readl(sdma->regs + SDMA_H_HOSTOVR);
> +	dsp = __raw_readl(sdma->regs + SDMA_H_DSPOVR);
> +
> +	if (dsp_override)
> +		dsp &= ~(1 << channel);
> +	else
> +		dsp |= (1 << channel);
> +
> +	if (event_override)
> +		evt &= ~(1 << channel);
> +	else
> +		evt |= (1 << channel);
> +
> +	if (mcu_verride)
> +		mcu &= ~(1 << channel);
> +	else
> +		mcu |= (1 << channel);
> +
> +	__raw_writel(evt, sdma->regs + SDMA_H_EVTOVR);
> +	__raw_writel(mcu, sdma->regs + SDMA_H_HOSTOVR);
> +	__raw_writel(dsp, sdma->regs + SDMA_H_DSPOVR);
> +
> +	return 0;
> +}
s/mcu_verride/mcu_override


> +static void sdma_event_enable(struct sdma_channel *sdmac, unsigned int
> event) +{
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +	u32 val;
> +	u32 chnenbl = chnenbl_ofs(sdma, event);
> +
> +	val = __raw_readl(sdma->regs + chnenbl);
> +	val |= (1 << channel);
> +	__raw_writel(val, sdma->regs + chnenbl);
> +}
s/chnenbl/chanenbl ?
 (or chanenable, etc.) 
Everything else was easily readable, but I did a double take when I read 
through this.


Cheers,
Marc
