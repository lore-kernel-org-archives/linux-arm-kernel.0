From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 13:27:16 +0800
Subject: [PATCH 1/2] rtc: mxc: add a second clock
In-Reply-To: <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
Message-ID: <20150519052716.GO1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 16, 2015 at 12:35:29AM +0200, Philippe Reynes wrote:
> The mxc RTC needs two clocks, one for the input
> reference, and one for the IP. But this driver
> was only using one clock (for the reference).
> This patch add the second clock (for the IP).
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/mach-imx/clk-imx31.c |    3 ++-

We're moving the clock driver into drivers/clk/imx folder during this
development cycle.  I suggest you patch the file from there, and update
driver code in the next development cycle.

Shawn

>  drivers/rtc/rtc-mxc.c         |   26 +++++++++++++++++---------
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
> index 286ef42..480c54f 100644
> --- a/arch/arm/mach-imx/clk-imx31.c
> +++ b/arch/arm/mach-imx/clk-imx31.c
> @@ -130,7 +130,8 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
>  	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
> -	clk_register_clkdev(clk[rtc_gate], NULL, "imx21-rtc");
> +	clk_register_clkdev(clk[ckil], "rtc", "imx21-rtc");
> +	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
>  	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
>  	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
>  	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
> index 09d422b..e916a91 100644
> --- a/drivers/rtc/rtc-mxc.c
> +++ b/drivers/rtc/rtc-mxc.c
> @@ -79,7 +79,8 @@ struct rtc_plat_data {
>  	struct rtc_device *rtc;
>  	void __iomem *ioaddr;
>  	int irq;
> -	struct clk *clk;
> +	struct clk *clk_rtc;
> +	struct clk *clk_ipg;
>  	struct rtc_time g_rtc_alarm;
>  	enum imx_rtc_type devtype;
>  };
> @@ -373,17 +374,24 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	if (IS_ERR(pdata->ioaddr))
>  		return PTR_ERR(pdata->ioaddr);
>  
> -	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pdata->clk)) {
> -		dev_err(&pdev->dev, "unable to get clock!\n");
> -		return PTR_ERR(pdata->clk);
> +	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(pdata->clk_ipg)) {
> +		dev_err(&pdev->dev, "unable to get ipg clock!\n");
> +		return PTR_ERR(pdata->clk_ipg);
>  	}
>  
> -	ret = clk_prepare_enable(pdata->clk);
> +	ret = clk_prepare_enable(pdata->clk_ipg);
>  	if (ret)
>  		return ret;
>  
> -	rate = clk_get_rate(pdata->clk);
> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
> +	if (IS_ERR(pdata->clk_rtc)) {
> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> +		ret = PTR_ERR(pdata->clk_rtc);
> +		goto exit_put_clk;
> +	}
> +
> +	rate = clk_get_rate(pdata->clk_rtc);
>  
>  	if (rate == 32768)
>  		reg = RTC_INPUT_CLK_32768HZ;
> @@ -432,7 +440,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  exit_put_clk:
> -	clk_disable_unprepare(pdata->clk);
> +	clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return ret;
>  }
> @@ -441,7 +449,7 @@ static int mxc_rtc_remove(struct platform_device *pdev)
>  {
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(pdata->clk);
> +	clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return 0;
>  }
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
