From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Aug 2010 10:25:31 +0100
Subject: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
In-Reply-To: <20100805061453.GA7524@bnru02.bnr.st.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
	<AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
	<20100729142011.GG18923@n2100.arm.linux.org.uk>
	<20100805061453.GA7524@bnru02.bnr.st.com>
Message-ID: <20100805092531.GA23473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 11:44:54AM +0530, Rabin VINCENT wrote:
> On Thu, Jul 29, 2010 at 16:20:11 +0200, Russell King - ARM Linux wrote:
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 4917af9..8ca38d9 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -541,7 +541,11 @@ static int mmci_get_cd(struct mmc_host *mmc)
> >  	else
> >  		status = gpio_get_value(host->gpio_cd);
> >  
> > -	return !status;
> > +	/*
> > +	 * Use positive logic throughout - status is zero for no card,
> > +	 * non-zero for card inserted.
> > +	 */
> > +	return status;
> >  }
> 
> Your patch in -next has a !gpio_get_value,

Yes, because I at least need it for it to work on my Realview platform.
As no one else seemed interested in replying to my questions about it,
I decided that I'd fix it so at least what I had continued to work.

> so are you OK with the cd_noinvert addition (for the GPIO case)?
> Or a cd_invert and a patch to existing platforms?

I'd much prefer positive logic.  Double negatives (eg, not noinverted)
are always bad news.
