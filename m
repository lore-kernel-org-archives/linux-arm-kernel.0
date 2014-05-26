From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 14:21:19 -0700
Subject: [PATCH] clk: samsung: clk-s3c2410-dlck: do not use PNAME macro
 as it declares __initdata
In-Reply-To: <4598341.WkbLY9yLfe@phil>
References: <4598341.WkbLY9yLfe@phil>
Message-ID: <20140526212119.GP27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:58:53PM +0200, Heiko St?bner wrote:
> The originally used PNAME macro from the core samsung clock infrastructure
> declares the created array as initdata, creating section mismatch warnings
> in the dclk driver.
> 
> Thus declare them directly, removing these warning.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This should probably go though the samsung tree / arm-soc, as the
> offending patch is also in there.
> 
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
> index 8d8dff0..c1726f4 100644
> --- a/drivers/clk/samsung/clk-s3c2410-dclk.c
> +++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
> @@ -135,26 +135,26 @@ struct s3c24xx_dclk {
>  #define to_s3c24xx_dclk1(x) \
>  		container_of(x, struct s3c24xx_dclk, dclk1_div_change_nb)
>  
> -PNAME(dclk_s3c2410_p) = { "pclk", "uclk" };
> -PNAME(clkout0_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
> +static const char *dclk_s3c2410_p[] = { "pclk", "uclk" };
> +static const char *clkout0_s3c2410_p[] = { "mpll", "upll", "fclk", "hclk", "pclk",
>  			     "gate_dclk0" };
> -PNAME(clkout1_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
> +static const char *clkout1_s3c2410_p[] = { "mpll", "upll", "fclk", "hclk", "pclk",
>  			     "gate_dclk1" };
>  
> -PNAME(clkout0_s3c2412_p) = { "mpll", "upll", "rtc_clkout",
> +static const char *clkout0_s3c2412_p[] = { "mpll", "upll", "rtc_clkout",
>  			     "hclk", "pclk", "gate_dclk0" };
> -PNAME(clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk", "pclk",
> +static const char *clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk", "pclk",
>  			     "gate_dclk1" };

Fixed up this error in a separate commit, since it caused a build failure.

In other words, please build test your fixes before you send them. :)


-Olof
