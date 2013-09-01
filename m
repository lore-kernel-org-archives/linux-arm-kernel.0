From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 1 Sep 2013 18:41:53 +0200
Subject: [PATCH 08/14] ASoC: kirkwood: prefer external clock over
 internal clock
In-Reply-To: <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
Message-ID: <20130901184153.353c644f@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 31 Aug 2013 13:42:36 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  sound/soc/kirkwood/kirkwood-i2s.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index 84dd9b0..8e10369 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -104,20 +104,20 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
>  {
>  	uint32_t clks_ctrl;
>  
> -	if (rate == 44100 || rate == 48000 || rate == 96000) {
> -		/* use internal dco for supported rates */
> -		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
> -			__func__, rate);
> -		kirkwood_set_dco(priv->io, rate);
> -
> -		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
> -	} else if (!IS_ERR(priv->extclk)) {
> +	if (!IS_ERR(priv->extclk)) {
>  		/* use optional external clk for other rates */
>  		dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
>  			__func__, rate, 256 * rate);
>  		clk_set_rate(priv->extclk, 256 * rate);
>  
>  		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
> +	} else if (rate == 44100 || rate == 48000 || rate == 96000) {

The rate is always good, and having this test raises a compilation warning
(clks_ctrl may be not initialized).


> +		/* use internal dco for supported rates */
> +		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
> +			__func__, rate);
> +		kirkwood_set_dco(priv->io, rate);
> +
> +		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
>  	}
>  	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
>  }



-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
