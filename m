From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 19:04:21 +0000
Subject: [PATCH] mx35_3ds: Add watchdog support
In-Reply-To: <78127.99191.qm@web51001.mail.re2.yahoo.com>
References: <20101115155201.GH8942@pengutronix.de>
	<78127.99191.qm@web51001.mail.re2.yahoo.com>
Message-ID: <20101115190421.GF31421@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 09:31:34AM -0800, Fabio Estevam wrote:
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2ee7dac..63f600c 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -270,10 +270,12 @@ static int __init imx2_wdt_probe(struct
> platform_device *pdev)
>         return -ENOMEM;
>     }
> 
> -    imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
> -    if (IS_ERR(imx2_wdt.clk)) {
> -        dev_err(&pdev->dev, "can't get Watchdog clock\n");
> -        return PTR_ERR(imx2_wdt.clk);
> +    if (!cpu_is_mx51()) {
> +        imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
> +        if (IS_ERR(imx2_wdt.clk)) {
> +            dev_err(&pdev->dev, "can't get Watchdog clock\n");
> +            return PTR_ERR(imx2_wdt.clk);
> +        }
>     }

Why not do what we do on other platforms (such as omap) and provide a dummy
imx-wdt.0 clock for non-MX51 CPUs?  Then you don't need to code such stuff
into drivers.
