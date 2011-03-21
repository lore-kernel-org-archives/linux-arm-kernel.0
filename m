From: julia@diku.dk (Julia Lawall)
Date: Mon, 21 Mar 2011 09:01:12 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <AANLkTi=NSKcj7MYFE=xPj=Am=OxydXdOUEk8XJJyUCpC@mail.gmail.com>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<AANLkTi=NSKcj7MYFE=xPj=Am=OxydXdOUEk8XJJyUCpC@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1103210900080.4323@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Mar 2011, Grant Likely wrote:

> 2011/3/15 Julia Lawall <julia@diku.dk>:
> > On Tue, 15 Mar 2011, Uwe Kleine-K?nig wrote:
> >
> >> On Tue, Mar 15, 2011 at 10:41:37AM +0100, Julia Lawall wrote:
> >> > I tried the following
> >> >
> >> > @@
> >> > expression E1,E2;
> >> > @@
> >> >
> >> > ? ? ? gpio_direction_output(E1,E2);
> >> > ? ? ? ...
> >> > - ? ? gpio_set_value(E1,E2);
> >> >
> >> > and found occurrences in 15 files. ?In some cases there seems to be some
> >> > delay before the call to gpio_set_value. ?Does that have any impacton
> >> > whether it is needed?
> >> gpio_direction_output(E1,E2) implies gpio_set_value(E1,E2), so unless
> >> there is a gpio_set_value(E1,!E2) before gpio_set_value(E1,E2) is a
> >> noop.
> >>
> >> I still don't know how to work with coccinelle, so if you point me to a
> >> concrete location I can be more specific.
> >
> > OK. ?I have changed the semantic patch to the following:
> >
> > @@
> > expression E1,E2,E3;
> > @@
> >
> > ? ? ?gpio_direction_output(E1,E2);
> > ? ? ?... when != gpio_set_value(E1,E3)
> > - ? ? gpio_set_value(E1,E2);
> >
> > Now it doesn't do all the cases where there is an earlier set ofr some
> > other value. ?The patch I obtain is below. ?This only concerns 5 files.
> > I haven't checked the result at all.
> >
> > julia
> 
> Hi Julia,
> 
> Similar to my other reply, even though this patch is much smaller, I'm
> not particularly excited about changing all the drivers wholesale
> unless someone with hardware can give it a test.

I wasn't proposing either as an actual patch.  Only as a way to see what 
the actual code looks like and what issues should be taken into account.

thanks,
julia
