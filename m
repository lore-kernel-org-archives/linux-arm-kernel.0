From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Jan 2010 20:55:20 +0100
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion
	between read and write value of two bits in POWER_MISCELLANEUS
	register.
In-Reply-To: <20100105181541.GE4274@sortiz.org>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<4B26799F.1020507@ru.mvista.com>
	<1260813540.2022.174.camel@climbing-alby>
	<20100105181541.GE4274@sortiz.org>
Message-ID: <20100105195520.GA8555@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 07:15:42PM +0100, Samuel Ortiz wrote:
> > @@ -187,6 +190,13 @@ int mc13783_reg_write(struct mc13783 *mc13783, unsigned int offset, u32 val)
> >  
> >         buf = 1 << 31 | offset << MC13783_REGOFFSET_SHIFT | val;
> >  
> > +       /* Take care of table 4-24 in Freescale MC13783IGPLDRM.pdf making
> > +        * the assumption that PWGTnDRV signals controls core power supplies
> > +        * that software must not disable. */
> > +       if (offset == MC13783_REG_POWER_MISCELLANEOUS)
> > +               buf &= ~(MC13783_REGCTRL_PWGT1SPIEN |
> > +                        MC13783_REGCTRL_PWGT2SPIEN);
> > +
> Although I see where you want to go, I dont really enjoy that solution.
> I would prefere to have specific register write/rmw routines for
> MC13783_REG_POWER_MISCELLANEOUS, and at the same time forbid to access the
> latter from the current mc13783_reg_* API.
Ack.  This is what I already suggested in

	http://thread.gmane.org/gmane.linux.kernel/927112/focus=930317

(This happend to be a reply to patch 2/4 as I replied to Alberto's ping
for patches 1 and 2.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
