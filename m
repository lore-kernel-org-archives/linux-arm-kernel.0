From: julia@diku.dk (Julia Lawall)
Date: Tue, 15 Mar 2011 10:41:37 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110315090656.GC13316@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tried the following

@@
expression E1,E2;
@@

      gpio_direction_output(E1,E2);
      ...
-     gpio_set_value(E1,E2);

and found occurrences in 15 files.  In some cases there seems to be some 
delay before the call to gpio_set_value.  Does that have any impacton 
whether it is needed?

julia



On Tue, 15 Mar 2011, Uwe Kleine-K?nig wrote:

> [added Julia Lawall to Cc:]
> 
> Hello Fabio,
> 
> ack for both.
> 
> Julia: Maybe coccinelle can find more of these?
> 
> Best regards
> Uwe
> 
> On Mon, Mar 14, 2011 at 03:21:09PM -0300, Fabio Estevam wrote:
> > gpio_direction_output has already set the port at low logical level, so it is not needed
> > to call gpio_set_value to set the port to 0 again.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_evk.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> > index 652e1e0..78abce6 100644
> > --- a/arch/arm/mach-mx5/board-mx53_evk.c
> > +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> > @@ -90,7 +90,6 @@ static inline void mx53_evk_fec_reset(void)
> >  		return;
> >  	}
> >  	gpio_direction_output(SMD_FEC_PHY_RST, 0);
> > -	gpio_set_value(SMD_FEC_PHY_RST, 0);
> >  	msleep(1);
> >  	gpio_set_value(SMD_FEC_PHY_RST, 1);
> >  }
> > -- 
> > 1.6.0.4
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
