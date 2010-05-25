From: wim@iguana.be (Wim Van Sebroeck)
Date: Tue, 25 May 2010 12:12:33 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <20100525091840.GA25521@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
	<20100514024915.GE30794@pengutronix.de>
	<20100521215211.GV3972@infomag.iguana.be>
	<20100525091840.GA25521@pengutronix.de>
Message-ID: <20100525101233.GY3972@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> > I was not to happy with how the close of /dev/watchdog was being done.
> > So I modified your code so that
> > * the close is better supported.
> > * the code is ready for when we change to the generic watchdog api.
> 
> Cool, any concrete plans for this happening?

I'm reviewing it with Alan, we discussed some smaal changes. Once they are applied, Alan will review the code again.
After that we will sent it out for review on the mailing-lists. So I expect within 2 weeks.

> > I didn't compile test the code. Could you have a look at it? compile it and test it?
> 
> Will do. Some initial comments. (An incremental patch might have been easier to
> check)

Correct :-)

> > Goal is to get this in during this merge window still...
> 
> The new driver-rule should apply here, no?

Normally yes, but this should have been reviewed earlier by myself. If we have something working and after all the reviews we allready did, I think it is time that user's can start using this watchdog.

> > #define WDOG_SEC_TO_COUNT(s)	((s * 2) << 8)
> 
> Any reason you dropped the '- 1' from my version here?

If you want a timeout of 1 second, and you subtract the -1 then you only get 0.5 seconds according to the reference manual.

> > /* Apply nand and or masks to data read from addr and write back
> >  * we nand first so that we can erase the timeout before setting the new one */
> > #define IMX2_WDT_CHG_BITS(addr, nand, or) \
> > 	__raw_writew((__raw_readw(addr) & ~nand) | or, addr)
> 
> I don't like such a macro very much, but well...

Can be changed easily. Just did this, I'll sent you the new file.

> > static inline void imx2_wdt_init(void)
> > {
> > 	unsigned int bits_off;
> > 	unsigned int bits_on;
> > 
> > 	/* Strip the old watchdog Time-Out value */
> > 	bits_off = IMX2_WDT_WCR_WT;
> > 	/* Generate reset if WDOG times out */
> > 	bits_off |= IMX2_WDT_WCR_WRE;
> > 	/* Keep Watchdog Disabled */
> > 	bits_off |= IMX2_WDT_WCR_WDE;
> > 	/* Continue timer operation during DEBUG mode */
> > 	bits_off |= IMX2_WDT_WCR_WDBG;
> > 	/* Continue Watchdog Timer during Low Power modes */
> > 	bits_off |= IMX2_WDT_WCR_WDZST;
> > 	
> > 	/* Set the watchdog's Time-Out value */
> > 	bits_on = WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> > 	/* Don't set Watchdog Assertion */
> > 	bits_on |= IMX2_WDT_WCR_WDA;
> > 	/* Don't set Software Reset Signal */
> > 	bits_on |= IMX2_WDT_WCR_SRS;
> 
> This is too excessive IMO. The bootloader might already have setup the watchdog
> according to the board.

imho timeout should be set, watchdog should reset and not generate an interrupt and WDE bit should be used.
All the rest should indeed be set by a boot-loader.

> > 	IMX2_WDT_CHG_BITS(imx2_wdt.base + IMX2_WDT_WCR, bits_off, bits_on);
> > }
> > 
> > static inline void imx2_wdt_enable(void)
> > {
> > 	IMX2_WDT_CHG_BITS(imx2_wdt.base + IMX2_WDT_WCR, 0, IMX2_WDT_WCR_WDE);
> > }
> 
> I assume this is for the easy migration to the generic watchdog API? Otherwise
> I see little use for a seperate function.

Can indeed go in imx2_wdt_init.

> > 
> > static inline void imx2_wdt_ping(void)
> > {
> > 	/* When enabled, the Watchdog requires that a service sequence be
> > 	 * written to the Watchdog Service Register (WSR) */
> 
> IMHO this is maybe over-commenting :)

Deleted :-)

> The rest looks good, thanks for that. Some functions looks a bit too trivial
> (and are called just once) for my taste, but I guess this is for easier
> migration later? Oh, and a few whitespace issues, easily fixed.

Found that whitespace also allready.

Will sent you the changed code and a test-program (so that I can see what the output is :-) ).

Kind regards,
Wim.
