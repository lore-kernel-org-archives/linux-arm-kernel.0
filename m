From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Thu, 4 Jan 2018 15:25:30 +0100
Subject: [PATCH 01/11] clk: sunxi-ng: Don't set k if width is 0 for nkmp
 plls
In-Reply-To: <20171230210203.24115-2-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-2-jernej.skrabec@siol.net>
Message-ID: <20180104142530.ffz26qs66c6y7b2h@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 30, 2017 at 10:01:53PM +0100, Jernej Skrabec wrote:
> For example, A83T have nmp plls which are modelled as nkmp plls. Since k
> is not specified, it has offset 0, shift 0 and lowest value 1. This
> means that LSB bit is always set to 1, which may change clock rate.
> 
> Fix that by applying k factor only if k width is greater than 0.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This looks fine...

> ---
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index e58c95787f94..709f528af2b3 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -81,7 +81,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
>  					unsigned long parent_rate)
>  {
>  	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> -	unsigned long n, m, k, p;
> +	unsigned long n, m, k = 1, p;
>  	u32 reg;
>  
>  	reg = readl(nkmp->common.base + nkmp->common.reg);
> @@ -92,11 +92,13 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
>  	if (!n)
>  		n++;
>  
> -	k = reg >> nkmp->k.shift;
> -	k &= (1 << nkmp->k.width) - 1;
> -	k += nkmp->k.offset;
> -	if (!k)
> -		k++;
> +	if (nkmp->k.width) {
> +		k = reg >> nkmp->k.shift;
> +		k &= (1 << nkmp->k.width) - 1;
> +		k += nkmp->k.offset;
> +		if (!k)
> +			k++;
> +	}

... but could you add a comment there to explain why you're using a
different construct than the one used for the other factors?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/d66be374/attachment.sig>
