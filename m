From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Tue, 31 May 2011 11:37:11 +0200
Subject: [PATCH 4/4] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <4DE4AB3D.2010305@bluewatersys.com>
References: <1306665346-26657-1-git-send-email-ynezz@true.cz>
	<1306665346-26657-5-git-send-email-ynezz@true.cz>
	<4DE4AB3D.2010305@bluewatersys.com>
Message-ID: <20110531093711.GK16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ryan Mallon <ryan@bluewatersys.com> [2011-05-31 18:47:57]:

> > +#ifdef CONFIG_MACH_TS72XX
> > +	/*
> > +	 * It's more reliable to use CPLD watchdog to perform the reset
> > +	 */
> > +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> > +	    board_is_ts7300() || board_is_ts7400()) {
> > +		__raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> > +		__raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> > +	}
> > +#else
> >  	/*
> >  	 * Set then clear the SWRST bit to initiate a software reset
> >  	 */
> >  	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> >  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> > +#endif
> 
> Do we need the ifdef here? Isn't the if (board_is_xxx) test enough?

Yes, sure, that the test is enough. The rationale behind that ifdef is, that I
was just thinking, that it's not necessary to drag-in more code (althought
very small) in the kernel for other ep93xx machines. If it's ok without, I'll
make v2.

-- ynezz
