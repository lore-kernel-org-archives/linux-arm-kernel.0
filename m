From: chas@cmf.nrl.navy.mil (chas williams - CONTRACTOR)
Date: Fri, 26 Apr 2013 09:12:20 -0400
Subject: [PATCH 05/21] atm: he: use mdelay instead of large udelay
 constants
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7203@saturn3.aculab.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-6-git-send-email-arnd@arndb.de>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7203@saturn3.aculab.com>
Message-ID: <20130426091220.468cf59e@thirdoffive.cmf.nrl.navy.mil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Apr 2013 09:21:59 +0100
"David Laight" <David.Laight@ACULAB.COM> wrote:

> > ARM cannot handle udelay for more than 2 miliseconds, so we
> > should use mdelay instead for those.
> ...
> > @@ -1055,7 +1055,7 @@ static int he_start(struct atm_dev *dev)
> >  	he_writel(he_dev, 0x0, RESET_CNTL);
> >  	he_writel(he_dev, 0xff, RESET_CNTL);
> > 
> > -	udelay(16*1000);	/* 16 ms */
> > +	mdelay(16);	/* 16 ms */
> >  	status = he_readl(he_dev, RESET_CNTL);
> 
> 16ms seems a long time to spin.
> I'd have thought a sleep would be more appropriate.
> Since this looks like timing a hardware reset pulse
> it can't matter if it is somewhat longer.

Yes, I wrote this bit some time ago when I was less wise. The
programmer's guide doesn't say how long to sleep, so the value isn't
critical.  It just has to be "long enough".  An msleep() would be fine
here.
