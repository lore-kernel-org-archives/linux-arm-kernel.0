From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 07 Aug 2013 00:20:19 +0200
Subject: [PATCH v4 2/4] mmc: dw_mmc: Add exynos resume_noirq callback to
 clear WAKEUP_INT
In-Reply-To: <CAD=FV=W3kxkwHGoWE5YsztW7NNOYQCy6yFwNJQDaTFx=58cgbA@mail.gmail.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <19655139.gpQFe0oLNI@flatron>
 <CAD=FV=W3kxkwHGoWE5YsztW7NNOYQCy6yFwNJQDaTFx=58cgbA@mail.gmail.com>
Message-ID: <4664300.eCYx009QLm@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 of August 2013 15:09:46 Doug Anderson wrote:
> Tomasz,
> 
> On Tue, Aug 6, 2013 at 2:58 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> >> +static int dw_mci_exynos_resume_noirq(struct device *dev)
> >> +{
> >> +     struct dw_mci *host = dev_get_drvdata(dev);
> >> +     u32 clksel;
> >> +
> >> +     clksel = mci_readl(host, CLKSEL);
> >> +     if (clksel & SDMMC_CLKSEL_WAKEUP_INT)
> >> +             mci_writel(host, CLKSEL, clksel);
> > 
> > What about clock gating? Will the clock used for clocking this
> > register be always enabled when this gets called?
> 
> Since this is just accessing and writing a register in the "Mobile
> Storage Host" block, I'd imagine that this should be the "biu" (bus
> interface unit) clock, right?  The dw_mmc code grabs the biu clock at
> probe time and never lets it go.  That means that we're OK as long as
> common clock framework has already restored clocks to normal operation
> by this time.
> 
> Do you think that common clock framework might not have put the clocks
> back into order by the time "noirq" callbacks are executed?

Ahh, so the dw_mmc driver doesn't do any clock gating? This is not very 
nice of it.

Well, in this case your patch is OK, but possibly some clock gating will 
have to be added to this driver at some point of time. Anyway:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
