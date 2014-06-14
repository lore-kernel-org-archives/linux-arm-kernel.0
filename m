From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 14 Jun 2014 21:22:42 +0400
Subject: [PATCH] Fixes two memory leaks in drivers/clk/sunxi/clk-sunxi.c
In-Reply-To: <1402710473-3295-1-git-send-email-nickkrause@sympatico.ca>
References: <1402710473-3295-1-git-send-email-nickkrause@sympatico.ca>
Message-ID: <539C84E2.6060209@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/14/2014 05:47 AM, Nick wrote:

   Please sign off on your patches, they can't applied otherwise.

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

    Eh, we only allocate 'fixed' after this point, no?

> +		kfree(gate);
>   		return;
> -
> +	}
>   	/* allocate fixed-rate and gate clock structs */
>   	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
>   	if (!fixed)

WBR, Sergei
