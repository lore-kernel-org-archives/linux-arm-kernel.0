From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 09:06:41 +0100
Subject: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
References: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111110080641.GT16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 12:59:18PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/tty/serial/imx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 163fc90..22fd9c8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(sport->clk);
>  		goto unmap;
>  	}
> +	clk_prepare(sport->clk);
>  	clk_enable(sport->clk);
>  
>  	sport->port.uartclk = clk_get_rate(sport->clk);
> @@ -1415,6 +1416,7 @@ deinit:
>  clkput:
>  	clk_put(sport->clk);
>  	clk_disable(sport->clk);
> +	clk_unprepare(sport->clk);

Ouch, clk_put before clk_disable? This is is bug. Care to fix it?

>  unmap:
>  	iounmap(sport->port.membase);
>  free:
> @@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
>  	}
>  
>  	clk_disable(sport->clk);
> +	clk_unprepare(sport->clk);
>  

Here clk_put is missing, another bug.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
