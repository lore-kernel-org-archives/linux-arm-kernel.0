From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:28:56 -0700
Subject: [PATCH v3 01/19] clk: composite: Add unregister function
In-Reply-To: <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415222856.GQ14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23, Maxime Ripard wrote:
> The composite clock didn't have any unregistration function, which forced
> us to use clk_unregister directly on it.
> 
> While it was already not great from an API point of view, it also meant
> that we were leaking the clk_composite structure allocated in
> clk_register_composite.
> 
> Add a clk_unregister_composite function to fix this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

I'm currently attempting to change the way clks are registered so
that we don't return clk pointers from clk_register and have
users add OF clk providers that return clk_hw pointers instead of
clk pointers. Just a note, that this whole thing should be
deleted in the next cycle if I can convert everything!

>  drivers/clk/clk-composite.c  | 15 +++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 1f903e1f86a2..b0f3b84ebd13 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -286,3 +286,18 @@ err:
>  	kfree(composite);
>  	return clk;
>  }
> +
> +void clk_unregister_composite(struct clk *clk)
> +{
> +	struct clk_composite *composite;
> +	struct clk_hw *hw;
> +
> +	hw = __clk_get_hw(clk);
> +	if (!hw)
> +		return;
> +
> +	composite = to_clk_composite(hw);
> +
> +	clk_unregister(clk);
> +	kfree(composite);
> +}

EXPORT_SYMBOL_GPL?

Do I need to pick this up?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
