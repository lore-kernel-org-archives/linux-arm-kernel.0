From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 08:19:27 -0700
Subject: [PATCH] pinctrl: single: check for any error when getting rows
In-Reply-To: <20161109141706.12624-1-ahaslam@baylibre.com>
References: <20161109141706.12624-1-ahaslam@baylibre.com>
Message-ID: <20161109151926.GS2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Haslam <ahaslam@baylibre.com> [161109 07:19]:
> pinctrl_count_index_with_args returns -ENOENT not
> -EINVAL. The return check would pass, and we would
> try to kzalloc with a negative error size throwing
> a warning.
> 
> Instead of checking for -EINVAL specifically, lets
> check for any error and avoid negative size allocations.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Thanks for fixing that:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/pinctrl/pinctrl-single.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 539f31c..56e22be 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1228,7 +1228,7 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
>  	struct pcs_function *function;
>  
>  	rows = pinctrl_count_index_with_args(np, name);
> -	if (rows == -EINVAL)
> +	if (rows < 0)
>  		return rows;
>  
>  	npins_in_row = pcs->width / pcs->bits_per_pin;
> -- 
> 2.10.1
> 
