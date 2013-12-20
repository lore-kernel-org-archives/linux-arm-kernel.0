From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 20 Dec 2013 09:18:25 +0100
Subject: [PATCH RESEND] clk: divider: read before write for HIWORD mask
In-Reply-To: <1387511417-8573-1-git-send-email-haojian.zhuang@gmail.com>
References: <1387511417-8573-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201312200918.25802.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 20. Dezember 2013, 04:50:17 schrieb Haojian Zhuang:
> When multiple dividers share one register, we need to read & mask
> register fist. Then we set the right value.
> 
> For example, there're two mmc clock dividers shared in one registers.
> The clock register is HIWORD type.

Why do you need the read before write on hiword registers?

Say you have the two dividers on bits [15:8] and [7:0]. When you change the 
later one [7:0] you also set the bits [23:16] to enable the write to these 
lower bits - but also only to them.

With this setting the other bits of the register you didn't mark for writing 
won't be changed at all.


Heiko

> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/clk/clk-divider.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 8d3009e..e1ea289 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -227,12 +227,10 @@ static int clk_divider_set_rate(struct clk_hw *hw,
> unsigned long rate, if (divider->lock)
>  		spin_lock_irqsave(divider->lock, flags);
> 
> -	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
> -		val = div_mask(divider) << (divider->shift + 16);
> -	} else {
> -		val = clk_readl(divider->reg);
> -		val &= ~(div_mask(divider) << divider->shift);
> -	}
> +	val = clk_readl(divider->reg);
> +	val &= ~(div_mask(divider) << divider->shift);
> +	if (divider->flags & CLK_DIVIDER_HIWORD_MASK)
> +		val |= div_mask(divider) << (divider->shift + 16);
>  	val |= value << divider->shift;
>  	clk_writel(val, divider->reg);
