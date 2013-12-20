From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Fri, 20 Dec 2013 17:05:28 +0800
Subject: [PATCH v3 4/9] ASoC: fsl-ssi: Fix interrupt mapping and release
In-Reply-To: <1387367865-26391-5-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20131220090527.GB15246@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Wed, Dec 18, 2013 at 12:57:40PM +0100, Markus Pargmann wrote:
> irqs should only be requested/released with enabled DMA and not on MX21.
> MX21 has some special register write configurations, so we do not add
> support for statistics on mx21 for the moment.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> @@ -227,13 +228,15 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
>  
>  	if (sisr & CCSR_SSI_SISR_RFRC) {
>  		ssi_private->stats.rfrc++;
> -		sisr2 |= CCSR_SSI_SISR_RFRC;
> +		if (ssi_private->hw_type != FSL_SSI_MX51)
> +			sisr2 |= CCSR_SSI_SISR_RFRC;
>  		ret = IRQ_HANDLED;
>  	}
>  
>  	if (sisr & CCSR_SSI_SISR_TFRC) {
>  		ssi_private->stats.tfrc++;
> -		sisr2 |= CCSR_SSI_SISR_TFRC;
> +		if (ssi_private->hw_type != FSL_SSI_MX51)
> +			sisr2 |= CCSR_SSI_SISR_TFRC;

I had a hard time on this part of modification because I just saw the commit
comments 'not on MX21' until I checked the RM of imx35, which should be same
as imx21 one: RFRC and RFRC became non-writeable since imx51. The should be
the reason here right?

And just for curiosity, is there any wrong with this part, like causing SSI
mis-behavior?

Thank you,
Nicolin Chen
