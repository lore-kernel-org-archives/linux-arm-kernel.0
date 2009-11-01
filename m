From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 1 Nov 2009 02:18:26 +0100
Subject: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM
	set
In-Reply-To: <20091030173317.GX7180@atomide.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
	<200910301542.27206.jkrzyszt@tis.icnet.pl>
	<20091030173317.GX7180@atomide.com>
Message-ID: <200911010218.29347.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Friday 30 October 2009 18:33:18 Tony Lindgren napisa?(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091030 07:43]:
> > Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa?(a):
> > > With CONFIG_PM=y, the omapfb/lcd device on Amstrad Delta, after
> > > initially starting correctly, breaks with the following error messages:
> > >
> > > omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> > > ...
> > > omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> > > omapfb omapfb: too many reset attempts, giving up.
> > >
> > > Looking closer at this I have found that it had been broken almost 2
> > > years ago with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM
> > > fixes for OMAP1.
> > >
> > > The definite reason for broken omapfb/lcd_ams_delta in PM mode appeared
> > > to be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch below
> > > fixes it.
> > >
> > > Since PM area is quite new to me, I am not sure if there may be a
> > > better solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit
> > > being switched to idle is to enable a clock that uses it (tipb_ck,
> > > dma_ck, or tc_ck or one of its children in this case, right?).
> > >
> > > I assume there is no bug in omapfb nor lcdc, as that would be already
> > > detected. Maybe it would be better to fix
> > > drivers/video/omap/lcd_ams_delta.c (or
> > > arch/arm/mach-omap1/board-ams-delta), but I don't know what clock
> > > should I enable, if any.
> >
> > More looking at it, I found that might be omap_dma_running() from
> > arch/arm/plat-omap/dma.c that needs correction. It already checks for LCD
> > dma running for OMAP1610, but does nothing similiar for 1510. I have
> > revisited http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no
> > hint how to do that in a 1610 similiar way.
>
> Hmm to me it looks like the OMAP_DMA_CCR_EN should be set in one of the
> channels if enabled. Maybe you need add a similar check somewhere in
> the *_lcd_dma_* functions too in dma.c?

Tony,
It sounds reasonable, but the problem is that in the OMAP5910 documentation I 
can find no DMA_CCR equivalent in the LCD dedicated DMA channel register set, 
nor EN equivalent in the DMA_LCD_CTRL register.

I have had a look at *_lcd_dma_*, as you suggested, and found this:

        /*
         * Set the Enable bit only if an external controller is
         * connected. Otherwise the OMAP internal controller will
         * start the transfer when it gets enabled.
         */
        if (enable_1510_mode || !lcd_dma.ext_ctrl)
                return;

That may suggest checking for LCD controller, not DMA channel, enable bit 
could give an answer if LCD DMA is likely to be running or not. So maybe 
adding a function to drivers/video/omap/lcdc.c that would check for 
OMAP_LCDC_CONTROL:OMAP_LCDC_CTRL_LCD_EN, then invoke that function from 
omap_dma_running() in case of omap1510 could be a proper solution.

However, that would affect not only Amstrad Delta, but all 1510 based 
machines. Since there were no reports about broken LCD DMA on 1510, I'd 
rather get a confirmation from omap guys, more experienced than me, that the 
solution proposed is correct and should work not only for my Amstrad Delta 
before I get that way.

Thanks,
Janusz
