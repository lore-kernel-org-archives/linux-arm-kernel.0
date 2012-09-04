From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 14:45:41 +0100
Subject: [PATCH 01/11] input: ambakmi: Add missing clk_[un]prepare() calls
In-Reply-To: <20120904153744.10e07940@skate>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-2-git-send-email-pawel.moll@arm.com>
 <20120904153744.10e07940@skate>
Message-ID: <1346766341.2605.82.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 14:37 +0100, Thomas Petazzoni wrote:
> > --- a/drivers/input/serio/ambakmi.c
> > +++ b/drivers/input/serio/ambakmi.c
> > @@ -72,10 +72,14 @@ static int amba_kmi_open(struct serio *io)
> >  	unsigned int divisor;
> >  	int ret;
> >  
> > -	ret = clk_enable(kmi->clk);
> > +	ret = clk_prepare(kmi->clk);
> >  	if (ret)
> >  		goto out;
> >  
> > +	ret = clk_enable(kmi->clk);
> > +	if (ret)
> > +		goto clk_unprepare;
> > +
> 
> What about using clk_prepare_enable() here?
> 
> >  	free_irq(kmi->irq, kmi);
> >  	clk_disable(kmi->clk);
> > +	clk_unprepare(kmi->clk);
> 
> And clk_disable_unprepare() here?

Sure thing, thanks for pointing that out!

Pawel
