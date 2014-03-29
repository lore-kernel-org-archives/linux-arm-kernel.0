From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 29 Mar 2014 01:41:47 -0700
Subject: [PATCH] clk: reverse default clk provider initialization order in
 of_clk_init()
In-Reply-To: <1395917012-23483-1-git-send-email-s.nawrocki@samsung.com>
References: <1395917012-23483-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140329084147.5762.51815@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-03-27 03:43:32)
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

I pulled this into clk-next but it didn't seem to get picked up by
linux-next in time for today's build. Let's test the next linux-next to
insure that the regressions are gone. If not then I'll likely need to
drop "clk: respect the clock dependencies in of_clk_init" from clk-next
for 3.15.

Regards,
Mike

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
>                 parent->clk_init_cb = match->data;
>                 parent->np = np;
> -               list_add(&parent->node, &clk_provider_list);
> +               list_add_tail(&parent->node, &clk_provider_list);
>         }
>  
>         while (!list_empty(&clk_provider_list)) {
> -- 
> 1.7.9.5
> 
