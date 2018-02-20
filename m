From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Feb 2018 11:31:34 +0100
Subject: [PATCH 3/9] serial: imx: Fix out-of-bounds access through DT alias
In-Reply-To: <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20180220103134.xfh2zl2vgonb2ywb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

On Tue, Feb 20, 2018 at 10:40:18AM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: 9206ab8a0350c3da ("serial: imx: Fix out-of-bounds access through DT alias")

huh, this patch fixes itself?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1d7ca382bc12b238..e89e90ad87d8245c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2041,6 +2041,11 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		serial_imx_probe_pdata(sport, pdev);
>  	else if (ret < 0)
>  		return ret;

I'd prefer an empty line here.

> +	if (sport->port.line >= UART_NR) {

I would have used:

	if (sport->port.line >= ARRAY_SIZE(imx_ports))

which IMHO is better understandable
> +		dev_err(&pdev->dev, "serial%d out of range\n",
> +			sport->port.line);

Note that the same overflow can happen when a device is probed using
platform data (and your commit fixes that, too). Maybe worth to point
out in the commit log?

Other than that: Good catch, thanks for your patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
