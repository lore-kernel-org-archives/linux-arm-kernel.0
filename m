From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 14 Jan 2013 17:04:10 -0800
Subject: [PATCH] clk: max77686: Avoid double free at remove time
In-Reply-To: <1357520719-3782-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1357520719-3782-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20130115010410.23734.88154@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Laurent Pinchart (2013-01-06 17:05:19)
> The clk_lookup entry is dropped at remove time by a call to
> clkdev_drop(). That function frees the entry, which is also freed by the
> driver core as it has been allocated through devm_kzalloc(). This
> results in a double free.
> 
> Use kzalloc() instead of devm_kzalloc() to fix this.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Laurent,

Thanks for the fix.  Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/clk-max77686.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index d098f72..6de05c5 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -130,8 +130,7 @@ static int max77686_clk_register(struct device *dev,
>         if (IS_ERR(clk))
>                 return -ENOMEM;
>  
> -       max77686->lookup = devm_kzalloc(dev, sizeof(struct clk_lookup),
> -                                       GFP_KERNEL);
> +       max77686->lookup = kzalloc(sizeof(struct clk_lookup), GFP_KERNEL);
>         if (IS_ERR(max77686->lookup))
>                 return -ENOMEM;
>  
> -- 
> Regards,
> 
> Laurent Pinchart
