From: marex@denx.de (Marek Vasut)
Date: Sun, 21 Dec 2014 22:50:15 +0100
Subject: [PATCH] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <1419169599-24791-1-git-send-email-stefan.wahren@i2se.com>
References: <1419169599-24791-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201412212250.16007.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 21, 2014 at 02:46:39 PM, Stefan Wahren wrote:

Hi!

[...]

> diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
> index 4adeed6..bdecec1 100644
> --- a/drivers/clk/mxs/clk-ref.c
> +++ b/drivers/clk/mxs/clk-ref.c
> @@ -16,6 +16,8 @@
>  #include <linux/slab.h>
>  #include "clk.h"
> 
> +#define BF_CLKGATE	BIT(7)
> +
>  /**
>   * struct clk_ref - mxs reference clock
>   * @hw: clk_hw for the reference clock
> @@ -39,7 +41,7 @@ static int clk_ref_enable(struct clk_hw *hw)
>  {
>  	struct clk_ref *ref = to_clk_ref(hw);
> 
> -	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + CLR);
> +	writeb(BF_CLKGATE, ref->reg + ref->idx + CLR);

Should this be writeb_relaxed() maybe ?

>  	return 0;
>  }
> @@ -48,7 +50,7 @@ static void clk_ref_disable(struct clk_hw *hw)
>  {
>  	struct clk_ref *ref = to_clk_ref(hw);
> 
> -	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + SET);
> +	writeb(BF_CLKGATE, ref->reg + ref->idx + SET);

Same here and all around the place ?

Other than that, it looks pretty OK :)

Best regards,
Marek Vasut
