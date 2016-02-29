From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 29 Feb 2016 22:38:50 +0100
Subject: [PATCH 3/3] hwrng: mxc-fsl - add support for Freescale RNGC
In-Reply-To: <CAOMZO5BN-1U6vX0HAHWX30t+23NnqEpOw6AttSgvqaZnq=cN6Q@mail.gmail.com>
References: <1456761156-27664-1-git-send-email-s.trumtrar@pengutronix.de>
 <1456761156-27664-3-git-send-email-s.trumtrar@pengutronix.de>
 <CAOMZO5BN-1U6vX0HAHWX30t+23NnqEpOw6AttSgvqaZnq=cN6Q@mail.gmail.com>
Message-ID: <20160229213850.GS2613@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 06:16:50PM -0300, Fabio Estevam wrote:
> On Mon, Feb 29, 2016 at 12:52 PM, Steffen Trumtrar
> <s.trumtrar@pengutronix.de> wrote:
> 
> > +       ret = clk_prepare_enable(rngc->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       rngc->irq = platform_get_irq(pdev, 0);
> > +       if (!rngc->irq) {
> > +               dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
> > +               clk_disable_unprepare(rngc->clk);
> > +
> > +               return ret;
> 
> You are returning the wrong error code here:
> 
> Better do like this:
> 
>        rngc->irq = platform_get_irq(pdev, 0);
>        if (rngc->irq < 0) {

rngc->irq is unsigned, so this is never true.

>                dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
>                clk_disable_unprepare(rngc->clk);
>                return rngc->irq;
>        }

So here comes my better approach:

	ret = platform_get_irq(pdev, 0);
	if (ret <= 0) {
		if (ret == 0)
			ret = -EINVAL;
		dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
		clk_disable_unprepare(rngc->clk);

		return ret;
	}

	rngc->irq = ret;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
