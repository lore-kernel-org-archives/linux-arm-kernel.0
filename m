From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 18:16:39 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1104201704350.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:

Very useful changelog.

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> only compile tested so far.

You are not listening at all, right?
 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 264c809..7627815 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -14,10 +14,23 @@
>  int clk_prepare(struct clk *clk)
>  {
>  	int ret = 0;
> +	struct clk *parent = ERR_PTR(-ENOSYS);
>  
>  	if (!clk)
>  		return 0;
>  
> +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {

Why the hell is this conditional? I told you that a proper abstraction
is for the sane cases which are the majority of the hardware and we
don't code for the buggy HW case unless we have evidence that it
exists. Once we have that evidence we can decide what to do - add a
flag or a separate function.

> +		parent = clk_get_parent(clk);
> +
> +		if (!IS_ERR(parent)) {
> +			ret = clk_prepare(parent);
> +			if (ret)
> +				return ret;
> +		} else if (PTR_ERR(parent) != -ENOSYS)
> +			/* -ENOSYS means no parent and is OK */
> +			return PTR_ERR(parent);
> +	}

And this whole mess should be written:

    ret = clk_prepare(clk->parent);
    if (ret)
		return ret;

Which returns 0 when there is no parent and it also returns 0 when
there is no prepare callback for the parent. Why the hell do we need
all this ERRPTR checking mess and all this conditional crap ?

Thanks,

	tglx
