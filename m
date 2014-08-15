From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Aug 2014 10:21:48 +0200
Subject: [PATCH v3] mmc: implement Driver Stage Register handling
In-Reply-To: <CAPDyKFqKVvwFi+JoOG-O1jznOB1UyhQW_ovb_N=+G_FtoqXQXA@mail.gmail.com>
References: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAPDyKFqKVvwFi+JoOG-O1jznOB1UyhQW_ovb_N=+G_FtoqXQXA@mail.gmail.com>
Message-ID: <20140815082148.GF5134@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Thu, Aug 14, 2014 at 11:26:28AM +0200, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 95cceae96944..52e83f389428 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (of_find_property(np, "mmc-hs400-1_2v", &len))
> >                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> >
> > +       if (of_find_property(np, "dsr", &len)) {
> > +               u32 tmp;
> > +
> > +               of_property_read_u32(np, "dsr", &tmp);
> > +               host->dsr_req = 1;
> > +               host->dsr = (u16)tmp;
> > +       }
> > +
> 
> Let's simplify the above with just:
> of_property_read_u16(np, "dsr", &host->dsr);
The downside here is that the syntax changes when using
of_property_read_u16. Instead of

	dsr = <0x100>

the following must be written then:

	dsr = /bits/ 16 <0x100>;

so I'd prefer to stay with of_property_read_u32. The block can still be
simplified. Will fix that in v4.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
