From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 10:10:47 +0800
Subject: [PATCH] serial/imx: propagate error from of_alias_get_id instead
 of using -ENODEV
In-Reply-To: <20111214203153.GB24496@pengutronix.de>
References: <1323894411-12294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111214203153.GB24496@pengutronix.de>
Message-ID: <20111215021046.GD3259@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:31:53PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Dec 14, 2011 at 09:26:51PM +0100, Uwe Kleine-K?nig wrote:
> > A quick look at of_alias_get_id shows that in the error case it returns
> > -ENODEV, too, but still it's better style to propagate the value as is.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Alan Cox <alan@linux.intel.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> > Cc: Jason Liu <jason.hui@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/tty/serial/imx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 163fc90..75c159a 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1301,7 +1301,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
> >  	ret = of_alias_get_id(np, "serial");
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> > -		return -ENODEV;
> > +		return ret;
> >  	}
> >  	sport->port.line = ret;
> >  
> One more comment on serial_imx_probe_dt:
> 
> It is used as follows:
> 
>         ret = serial_imx_probe_dt(sport, pdev);
> 	if (ret == -ENODEV)
> 		serial_imx_probe_pdata(sport, pdev);
> 
> IMHO you should distinguish here more carefully between the different
> -ENODEV cases. It's OK to call serial_imx_probe_pdata() if
> 
> 	!pdev->dev.of_node
> 
> but if
> 
> 	of_alias_get_id(np, "serial")
> 
> returns an error isn't that something that should make the probing of
> the device fail instead of relying on platform data and the device id
> that are non-existant and more or less random respectively if the device
> is instantiated by dt?
> 
Yes, agreed.  Care to send a fix for that too?

-- 
Regards,
Shawn
