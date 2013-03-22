From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 10:21:37 -0700
Subject: [PATCH] clk: prima2: fix return value check in
 sirfsoc_of_clk_init()
In-Reply-To: <CAPgLHd82XEZEP4eDvmvPjdHHz6u40+16W1GZeCWWw6Cj3SAwCg@mail.gmail.com>
References: <CAPgLHd82XEZEP4eDvmvPjdHHz6u40+16W1GZeCWWw6Cj3SAwCg@mail.gmail.com>
Message-ID: <20130322172137.834.44023@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wei Yongjun (2013-03-11 08:55:18)
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR()
> not NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/clk/clk-prima2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
> index f8e9d0c..b208665 100644
> --- a/drivers/clk/clk-prima2.c
> +++ b/drivers/clk/clk-prima2.c
> @@ -1113,7 +1113,7 @@ void __init sirfsoc_of_clk_init(void)
>  
>         for (i = pll1; i < maxclk; i++) {
>                 prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
> -               BUG_ON(!prima2_clks[i]);
> +               BUG_ON(IS_ERR(prima2_clks[i]);
>         }
>         clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
>         clk_register_clkdev(prima2_clks[io],  NULL, "io");

This patch failed to compile.  Fix is below and applied to clk-next.
Let me know if you have any issue with it:

Regards,
Mike



diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
index b208665..643ca65 100644
--- a/drivers/clk/clk-prima2.c
+++ b/drivers/clk/clk-prima2.c
@@ -1113,7 +1113,7 @@ void __init sirfsoc_of_clk_init(void)
 
 	for (i = pll1; i < maxclk; i++) {
 		prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
-		BUG_ON(IS_ERR(prima2_clks[i]);
+		BUG_ON(IS_ERR(prima2_clks[i]));
 	}
 	clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
 	clk_register_clkdev(prima2_clks[io],  NULL, "io");
