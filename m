From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 10:55:05 +0100
Subject: [PATCH 01/12] clocksource: sh_cmt: Add clk_prepare/unprepare
 support
In-Reply-To: <20131029055534.GB11580@verge.net.au>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029055534.GB11580@verge.net.au>
Message-ID: <9952506.6pWpQZf7WG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 29 October 2013 14:55:35 Simon Horman wrote:
> On Mon, Oct 28, 2013 at 11:49:18PM +0100, Laurent Pinchart wrote:
> > Prepare the clock at probe time, as there is no other appropriate place
> > in the driver where we're allowed to sleep.
> > 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks Laurent,
> 
> I have queued this up in the clocksources branch of my renesas tree.
> I will send a pull request to Mike once v3.13-rc1 has hit the shelves.
> Mike, please let me know if you would prefer something earlier than that.

I thought the clocksource patches had to go through Daniel's tree. If you can 
take them directly that's easier, so I'm fine with that. Does this imply your 
Acked-by (for patches 01 to 03) ?

> > ---
> > 
> >  drivers/clocksource/sh_cmt.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> > index 0965e98..940341a 100644
> > --- a/drivers/clocksource/sh_cmt.c
> > +++ b/drivers/clocksource/sh_cmt.c
> > @@ -634,12 +634,18 @@ static int sh_cmt_clock_event_next(unsigned long
> > delta,> 
> >  static void sh_cmt_clock_event_suspend(struct clock_event_device *ced)
> >  {
> > -	pm_genpd_syscore_poweroff(&ced_to_sh_cmt(ced)->pdev->dev);
> > +	struct sh_cmt_priv *p = ced_to_sh_cmt(ced);
> > +
> > +	pm_genpd_syscore_poweroff(&p->pdev->dev);
> > +	clk_unprepare(p->clk);
> >  }
> >  
> >  static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
> >  {
> > -	pm_genpd_syscore_poweron(&ced_to_sh_cmt(ced)->pdev->dev);
> > +	struct sh_cmt_priv *p = ced_to_sh_cmt(ced);
> > +
> > +	clk_prepare(p->clk);
> > +	pm_genpd_syscore_poweron(&p->pdev->dev);
> >  }
> >  
> >  static void sh_cmt_register_clockevent(struct sh_cmt_priv *p,
> > 
> > @@ -737,6 +743,10 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct
> > platform_device *pdev)> 
> >  		goto err2;
> >  	}
> > 
> > +	ret = clk_prepare(p->clk);
> > +	if (ret < 0)
> > +		goto err3;
> > +
> >  	if (res2 && (resource_size(res2) == 4)) {
> >  		/* assume both CMSTR and CMCSR to be 32-bit */
> >  		p->read_control = sh_cmt_read32;
> > @@ -773,19 +783,21 @@ static int sh_cmt_setup(struct sh_cmt_priv *p,
> > struct platform_device *pdev)> 
> >  			      cfg->clocksource_rating);
> >  	if (ret) {
> >  		dev_err(&p->pdev->dev, "registration failed\n");
> > -		goto err3;
> > +		goto err4;
> >  	}
> >  	p->cs_enabled = false;
> >  	
> >  	ret = setup_irq(irq, &p->irqaction);
> >  	if (ret) {
> >  		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
> > -		goto err3;
> > +		goto err4;
> >  	}
> >  	
> >  	platform_set_drvdata(pdev, p);
> >  	
> >  	return 0;
> > 
> > +err4:
> > +	clk_unprepare(p->clk);
> >  err3:
> >  	clk_put(p->clk);
> >  err2:
-- 
Regards,

Laurent Pinchart
