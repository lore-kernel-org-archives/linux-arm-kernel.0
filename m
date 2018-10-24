From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 24 Oct 2018 19:04:36 +0100
Subject: [PATCH v2 02/15] clk: sunxi-ng: Add check for minimal rate to
 NKM PLLs
In-Reply-To: <20181023155035.9101-3-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com>
Message-ID: <20181024180436.5n3i3z6h2yezc4cv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 09:20:22PM +0530, Jagan Teki wrote:
> Some NKM PLLs doesn't work well when their output clock rate is set below
> certain rate.
> 
> So, add support for minimal rate for relevant PLLs.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
> 
>  drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 841840e35e61..d17539dc88dd 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>  
> +	if (rate < nkm->min_rate) {
> +		rate = nkm->min_rate;
> +		if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +			rate /= nkm->fixed_post_div;

I'm not sure this is right. Is the post divider taken into account to
calculate the minimum, or is the minimum on the rate before the fixed
post divider.

How did you test this?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
