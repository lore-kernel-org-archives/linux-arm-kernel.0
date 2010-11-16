From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Nov 2010 07:38:18 +0100
Subject: [PATCH] mx35_3ds: Add watchdog support
In-Reply-To: <78127.99191.qm@web51001.mail.re2.yahoo.com>
References: <20101115155201.GH8942@pengutronix.de>
	<78127.99191.qm@web51001.mail.re2.yahoo.com>
Message-ID: <20101116063818.GR8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Nov 15, 2010 at 09:31:34AM -0800, Fabio Estevam wrote:
> Hi Uwe and Wolfram,
> 
> --- On Mon, 11/15/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Subject: Re: [PATCH] mx35_3ds: Add watchdog support
> > To: "Fabio Estevam" <fabioestevam@yahoo.com>
> > Cc: fabio.estevam at freescale.com, s.hauer at pengutronix.de, linux-arm-kernel at lists.infradead.org
> > Date: Monday, November 15, 2010, 1:52 PM
> > Hi Fabio,
> > 
> > On Mon, Nov 15, 2010 at 06:31:09AM -0800, Fabio Estevam
> > wrote:
> > > mx35_3ds: Add watchdog support.
> > I just converted the mx3 watchdog device to dynamic
> > allocation.? Will
> > take care of mx35_3ds.
> 
> Ok, understood.
> 
> I have also started testing watchdog on MX51.
> 
> As there is no watchdog clock entry in the CCM block on MX51 I thought on doing the following:
> 
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
(Minor note: after your patch the brackets don't balance anymore.)

I wonder why the driver uses clk_get_sys("imx-wdt.0", NULL).
IMHO it should use clk_get(&pdev->dev, NULL).  (For that to work we need
to register the clock using "imx2-wdt.0".  (Or even better "imx2-wdt".))

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
