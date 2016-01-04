From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 19:10:14 +0000
Subject: [PATCH] serial: imx: Fix suspend / resume.
In-Reply-To: <20160104182206.10852.47155.stgit@localhost>
References: <20160104182206.10852.47155.stgit@localhost>
Message-ID: <20160104191014.GN19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 07:22:06PM +0100, Martin Fuzzey wrote:
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 016e4be..16a551b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2071,13 +2071,13 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
>  	struct imx_port *sport = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	ret = clk_enable(sport->clk_ipg);
> +	ret = clk_prepare_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
>  
>  	serial_imx_save_context(sport);
>  
> -	clk_disable(sport->clk_ipg);
> +	clk_disable_unprepare(sport->clk_ipg);

NAK.  If this is _noirq, then it's a context which can't sleep.  Therefore,
calling functions that do sleep is not permitted.

> @@ -2088,13 +2088,13 @@ static int imx_serial_port_resume_noirq(struct device *dev)
>  	struct imx_port *sport = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	ret = clk_enable(sport->clk_ipg);
> +	ret = clk_prepare_enable(sport->clk_ipg);
>  	if (ret)
>  		return ret;
>  
>  	serial_imx_restore_context(sport);
>  
> -	clk_disable(sport->clk_ipg);
> +	clk_disable_unprepare(sport->clk_ipg);

Ditto.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
