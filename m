From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 7 Jun 2017 13:52:25 -0700
Subject: [PATCH] watchdog: meson: Handle return value of clk_prepare_enable
In-Reply-To: <ee0b1a0d0340608b10c47847a8472bc9e5e8b8e1.1496744678.git.arvind.yadav.cs@gmail.com>
References: <ee0b1a0d0340608b10c47847a8472bc9e5e8b8e1.1496744678.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170607205225.GC29222@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 03:04:15PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/meson_gxbb_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 45d4766..69a5a57 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -203,7 +203,9 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> -	clk_prepare_enable(data->clk);
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, data);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
