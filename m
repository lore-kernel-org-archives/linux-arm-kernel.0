From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 27 Mar 2014 11:49:34 +0100
Subject: [PATCH] clk: reverse default clk provider initialization order in
 of_clk_init()
In-Reply-To: <1395917012-23483-1-git-send-email-s.nawrocki@samsung.com>
References: <1395917012-23483-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5334023E.8070101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/14 11:43, Sylwester Nawrocki wrote:
> This restores the default clocks registration order as parsed from
> devicetree, i.e. as before commit 1771b10d605d26ccee771a7fb4b08718
> "clk: respect the clock dependencies in of_clk_init", for when there
> is no explicit parent clock dependencies between clock providers
> specified in the device tree.
> 
> It prevents regressions (boot failure, division by 0 errors) on
> imx and exynos platforms.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Oops, I've forgotten to add:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

> ---
>  drivers/clk/clk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 07cba07..c859adf 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2596,7 +2596,7 @@ void __init of_clk_init(const struct of_device_id *matches)
>  
>  		parent->clk_init_cb = match->data;
>  		parent->np = np;
> -		list_add(&parent->node, &clk_provider_list);
> +		list_add_tail(&parent->node, &clk_provider_list);
>  	}
>  
>  	while (!list_empty(&clk_provider_list)) {

-- 
Regards,
Sylwester
