From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Jul 2017 19:32:48 +0200
Subject: [PATCH] rtc: sun6i: ensure clk_data is kfree'd on error
In-Reply-To: <20170719165702.22220-1-colin.king@canonical.com>
References: <20170719165702.22220-1-colin.king@canonical.com>
Message-ID: <20170719173248.l4w5xc33enuor5if@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/07/2017 at 17:57:02 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two error return paths that do not kfree clk_data and
> we end up with a memory leak. Fix these with a kfree error exit
> path.
> 
> Detected by CoverityScan, CID#1402959 ("Resource Leak")
> 

I think that patch fixes the same issue (and more):
http://patchwork.ozlabs.org/patch/787151/

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 39cbc1238b92..61502221ab6e 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -204,7 +204,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>  	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
>  	if (IS_ERR(rtc->base)) {
>  		pr_crit("Can't map RTC registers");
> -		return;
> +		goto err;
>  	}
>  
>  	/* Switch to the external, more precise, oscillator */
> @@ -216,7 +216,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>  
>  	/* Deal with old DTs */
>  	if (!of_get_property(node, "clocks", NULL))
> -		return;
> +		goto err;
>  
>  	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
>  								"rtc-int-osc",
> @@ -246,6 +246,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>  	clk_data->num = 1;
>  	clk_data->hws[0] = &rtc->hw;
>  	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	return;
> +
> +err:
> +	kfree(clk_data);
>  }
>  CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
>  		      sun6i_rtc_clk_init);
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
