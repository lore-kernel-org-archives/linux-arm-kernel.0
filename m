From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Oct 2009 10:33:18 -0700
Subject: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when
	PM set
In-Reply-To: <200910301542.27206.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
	<200910301542.27206.jkrzyszt@tis.icnet.pl>
Message-ID: <20091030173317.GX7180@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091030 07:43]:
> Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa?(a):
> > With CONFIG_PM=y, the omapfb/lcd device on Amstrad Delta, after initially
> > starting correctly, breaks with the following error messages:
> >
> > omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> > ...
> > omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> > omapfb omapfb: too many reset attempts, giving up.
> >
> > Looking closer at this I have found that it had been broken almost 2 years
> > ago with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM fixes for
> > OMAP1.
> >
> > The definite reason for broken omapfb/lcd_ams_delta in PM mode appeared to
> > be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch below fixes it.
> >
> > Since PM area is quite new to me, I am not sure if there may be a better
> > solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit being
> > switched to idle is to enable a clock that uses it (tipb_ck, dma_ck, or
> > tc_ck or one of its children in this case, right?).
> >
> > I assume there is no bug in omapfb nor lcdc, as that would be already
> > detected. Maybe it would be better to fix
> > drivers/video/omap/lcd_ams_delta.c (or
> > arch/arm/mach-omap1/board-ams-delta), but I don't know what clock should I
> > enable, if any.
> 
> More looking at it, I found that might be omap_dma_running() from 
> arch/arm/plat-omap/dma.c that needs correction. It already checks for LCD dma 
> running for OMAP1610, but does nothing similiar for 1510. I have revisited 
> http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no hint how to do 
> that in a 1610 similiar way.

Hmm to me it looks like the OMAP_DMA_CCR_EN should be set in one of the
channels if enabled. Maybe you need add a similar check somewhere in
the *_lcd_dma_* functions too in dma.c?

Regards,

Tony
