From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 13 Jun 2014 23:11:12 -0300
Subject: [PATCH] Fixes two memory leaks in drivers/clk/sunxi/clk-sunxi.c
In-Reply-To: <1402710473-3295-1-git-send-email-nickkrause@sympatico.ca>
References: <1402710473-3295-1-git-send-email-nickkrause@sympatico.ca>
Message-ID: <539BAF40.4060800@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 13/06/14 22:47, Nick escribi?:
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 4264834..07b45d1 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -41,9 +41,11 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>   	const char *clk_name = node->name;
>   	u32 rate;
>
> -	if (of_property_read_u32(node, "clock-frequency", &rate))
> +	if (of_property_read_u32(node, "clock-frequency", &rate)) {
> +		kfree(fixed);
> +		kfree(gate);

Why are you trying to free these two, when they haven't been allocated yet?

>   		return;
> -
> +	}
>   	/* allocate fixed-rate and gate clock structs */
>   	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
>   	if (!fixed)
>

fixed is allocated here. gate follows suit after it.

Cheers,

Emilio

PS: For next time, please use a proper prefix on your patch subject 
("clk: sunxi: " in this case) as well as add a description to your patch 
and a signoff line.
