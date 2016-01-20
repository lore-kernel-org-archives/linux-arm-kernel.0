From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 20 Jan 2016 14:57:31 +0000
Subject: [PATCH] clk-divider: make sure read-only dividers do not write
 to their register
In-Reply-To: <8710207.gKyLbM2bKY@phil>
References: <8710207.gKyLbM2bKY@phil>
Message-ID: <20160120145731.GA6864@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 03:42:54PM +0100, Heiko Stuebner wrote:
> Commit e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1") removed
> the special ops struct for read-only clocks and instead opted to handle
> them regularly.
> 
> On the rk3368 this results in breakage as aclkm now gets set a value.
> While it is the same divider, the A53 core still doesn't like it.
> The reason being that "ACLKENMasserts one clock cycle before the rising
> edge of ACLKM" and the clock should only be touched when STANDBYWFIL2
> is asserted.
> 
> So make sure, read-only clocks don't touch the clock-register at all
> even if only writing the same value.
> 
> Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
> Reported-by: Zhang Qing <zhangqing@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

It wouldn't hurt to clarify in the comment that this isn't just an
optimisation, and that even writing the same value to the hardware may
not be safe.

In any case
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  drivers/clk/clk-divider.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index ded3ff4..6dfe261 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -391,6 +391,10 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long flags = 0;
>  	u32 val;
>  
> +	/* don't do writes in read-only case */
> +	if (divider->flags & CLK_DIVIDER_READ_ONLY)
> +		return 0;
> +
>  	value = divider_get_val(rate, parent_rate, divider->table,
>  				divider->width, divider->flags);
>  
> -- 
> 2.6.4
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/b6fd5394/attachment.sig>
