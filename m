From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 09:24:19 +0100
Subject: [PATCH v2] [media] marvell-ccic: simplify and fix clk handling
 (a bit)
In-Reply-To: <20130926081356.GA6314@pengutronix.de>
References: <1380048167-13729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380049187-16036-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130925011520.1fa24013@lwn.net>
 <A63A0DC671D719488CD1A6CD8BDC16CF4AB6BB9AAD@SC-VEXCH4.marvell.com>
 <20130926081356.GA6314@pengutronix.de>
Message-ID: <20130926082418.GN12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 10:13:56AM +0200, Uwe Kleine-K?nig wrote:
> Hi Libin,
> 
> On Wed, Sep 25, 2013 at 07:47:19PM -0700, Libin Yang wrote:
> > In the clk enable and prepare function, we will check the NULL
> > pointer. So it should be no problem.
> I'm not sure what you mean here and unfortunately your quoting style
> makes your statement appear without context.
> 
> 	if (... && !IS_ERR(cam->mipi_clk)) {
> 		if (cam->mipi_clk)
> 			devm_clk_put(mcam->dev, cam->mipi_clk);
> 		cam->mipi_clk = NULL;
> 	}
> 
> might work in your setup, but it's wrong usage of the clk API. There is
> no reason NULL couldn't be a valid clk pointer. Moreover I cannot find a
> place in that driver that calls prepare and/or enable for the mipi_clk.
> (BTW, calling clk_get_rate on a disabled clk is another thing you
> shouldn't do.)

It's a bug for another reason.  Consider this:

	clk = devm_clk_get(...);

Now, as the CLK API defines only IS_ERR(clk) to be errors, if clk is NULL
then the devm API will allocate a tracking structure for the "allocated"
clock.  If you then do:

	if (!IS_ERR(clk)) {
		if (clk)
			devm_clk_put(clk);
		clk = NULL;
	}

Then this structure won't get freed.  Next time you call devm_clk_get(),
you'll allocate another tracking structure.  If the driver does this a
lot, it will spawn lots of these tracking structures which will only get
cleaned up when the device is unbound (possibly never.)

So, what this driver is doing with its NULL checks against clocks is
buggy, no two ways about it.
