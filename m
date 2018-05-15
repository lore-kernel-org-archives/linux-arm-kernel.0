From: david@lechnology.com (David Lechner)
Date: Tue, 15 May 2018 10:36:58 -0500
Subject: [PATCH v2 2/2] clk: davinci: psc-dm365: fix few clocks
In-Reply-To: <20180515112224.30122-3-nsekhar@ti.com>
References: <20180515112224.30122-1-nsekhar@ti.com>
 <20180515112224.30122-3-nsekhar@ti.com>
Message-ID: <9bb03875-d1b8-43a3-b9a4-a06c5eecf603@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2018 06:22 AM, Sekhar Nori wrote:
> Fix parent of EMAC and voice codec PSC clocks. Documentation is clear
> on EMAC clock parent, but its not fully clear on parent of voice codec
> clock. The implementation chosen is matches arch/arm/mach-davinci/dm365.c.
> Add a comment explaining this for posterity.
> 
> There is only one power domain on DM365. Fix the power domain of voice
> codec and vpss dac modules.
> 
> While at it, add a comment explaining how the parent of vpss dac clock was
> derived. Note that this patch does not touch the parent of vpss dac clock.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2: add comments explaining parents of voice codec and vpss dac clocks
> 
>   drivers/clk/davinci/psc-dm365.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
> index 3ad915f37376..289af3913fb0 100644
> --- a/drivers/clk/davinci/psc-dm365.c
> +++ b/drivers/clk/davinci/psc-dm365.c
> @@ -65,9 +65,22 @@ static const struct davinci_lpsc_clk_info dm365_psc_info[] = {
>   	LPSC(31, 0, arm,         pll2_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
>   	LPSC(38, 0, spi3,        pll1_sysclk4, spi3_clkdev,        0),
>   	LPSC(39, 0, spi4,        pll1_auxclk,  spi4_clkdev,        0),
> -	LPSC(40, 0, emac,        pll2_sysclk4, emac_clkdev,        0),
> -	LPSC(44, 1, voice_codec, pll1_sysclk3, voice_codec_clkdev, 0),
> -	LPSC(46, 1, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
> +	LPSC(40, 0, emac,        pll1_sysclk4, emac_clkdev,        0),
> +	/*
> +	 * The TRM (ARM Subsystem User's Guide) shows two clocks input into
> +	 * voice codec module (PLL2 SYSCLK4 with a DIV2 and PLL1 SYSCLK4). Its
> +	 * not fully clear from documentation which clock should be considered
> +	 * as parent for PSC. The clock chosen here is to maintain
> +	 * compatibility with existing code in arch/arm/mach-davinci/dm365.c
> +	 */
> +	LPSC(44, 0, voice_codec, pll2_sysclk4, voice_codec_clkdev, 0),
> +	/*
> +	 * Its not fully clear from TRM (ARM Subsystem User's Guide) as to what
> +	 * the parent of VPSS DAC LPSC should actually be. PLL1 SYSCLK3 feeds
> +	 * into HDVICP and MJCP. The clock chosen here is to remain compatible
> +	 * with code existing in arch/arm/mach-davinci/dm365.c
> +	 */
> +	LPSC(46, 0, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
>   	LPSC(47, 0, vpss_master, pll1_sysclk5, vpss_master_clkdev, 0),
>   	LPSC(50, 0, mjcp,        pll1_sysclk3, NULL,               0),
>   	{ }
> 

Reviewed-by: David Lechner <david@lechnology.com>
