From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 15 Sep 2014 12:05:28 +0300
Subject: [PATCH] clk: ti: dra7-atl-clock: fix a memory leak
In-Reply-To: <1410529147-19950-1-git-send-email-t-kristo@ti.com>
References: <1410529147-19950-1-git-send-email-t-kristo@ti.com>
Message-ID: <5416ABD8.4040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 04:39 PM, Tero Kristo wrote:
> of_clk_add_provider makes an internal copy of the parent_names property
> while its called, thus it is no longer needed after this call and can
> be freed.

Thanks Tero, indeed this was overlooked in the original driver.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/clk/ti/clk-dra7-atl.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index 4a65b41..3f9308a 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -199,6 +199,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
>  
>  	if (!IS_ERR(clk)) {
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		kfree(parent_names);
>  		return;
>  	}
>  cleanup:
> 


-- 
P?ter
