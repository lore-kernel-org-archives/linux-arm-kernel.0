From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 May 2015 09:04:52 +0200
Subject: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core
 extensions
In-Reply-To: <55470AA7.9050605@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi>
 <20150503185601.GD25193@pengutronix.de>
 <55470AA7.9050605@offcode.fi>
Message-ID: <20150504070452.GE25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Timo,

On Mon, May 04, 2015 at 08:59:03AM +0300, Timo Kokkonen wrote:
> Hi, 03.05.2015 21:56, Uwe Kleine-K?nig wrote:
> >On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
> >>+static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
> >>+{
> >>+	void __iomem *base = wdev->base;
> >>+
> >>+	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
> >>+}
> >This isn't reliable. The sequence needed to enable the watchdog is
> >	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
> >	writel(0x4444, base + OMAP_WATCHDOG_SPR);
> >
> >The sequence to stop is:
> >	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
> >	writel(0x5555, base + OMAP_WATCHDOG_SPR);
> >
> >But:
> >
> >barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
> >44e35048: 00005555                                           UU..
> >barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
> >barebox at TI AM335x BeagleBone black:/ md 0x44e35048+4
> >44e35048: 00004444                                           DD..
> >
> >So the register contains 0x4444 but the timer doesn't run. So at best
> >testing for 0x4444 is a good heuristic.
> 
> Yeah.. I don't think we can get any better than that. Unless we
> start checking the counter register and see whether it really counts
> or not, and I think that's a bit overkill.. So I'd say we should be
> safe when assuming bootloader is doing things correctly. Although,
> we could add a comment to the code that the test may not be 100%
> reliable in case the start sequence have not been issued properly.
> 
> Thanks for pointing this out!
It doesn't seem to much overhead to do:

	/*
	 * There is no register that tells us if the timer is running,
	 * so we have to resort to sample twice. The minimal frequency
	 * is 256 Hz (32768 Hz prescaled with 2**7).
	 */
	counter1 = readl(base + OMAP_WATCHDOG_CCR);
	mdelay(4);
	counter2 = readl(base + OMAP_WATCHDOG_CCR);
	return counter1 != counter2;

I'd say it's even worth to do:

	cntrl = readl(base + OMAP_WATCHDOG_CNTRL);
	if (cntrl & (1 << 5))
		shift = (cntrl >> 2) & 0x7;
	else
		shift = 0;
	counter1 = readl(base + OMAP_WATCHDOG_CCR);
	udelay(31 << shift);
	counter2 = readl(base + OMAP_WATCHDOG_CCR);
	return counter1 != counter2;

For some bonus points add some defines for the magic constants.

This is save as the OMAP_WATCHDOG_CNTRL doesn't seem to accept reads
while the counter is running. Maybe even this could be used to detect a
running timer?:

 - enable timer:
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0xbbbb
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444

 - read out WCLR
	barebox at TI AM335x BeagleBone black:/ md 0x44e35024+4      
	44e35024: 00000020                                            ...

 - write to WCLR
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35024 0x0

 - check result; didn't work
	barebox at TI AM335x BeagleBone black:/ md 0x44e35024+4 
	44e35024: 00000020                                            ...

 - stop timer
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0xaaaa
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35048 0x5555

 - recheck WCLR
	barebox at TI AM335x BeagleBone black:/ md 0x44e35024+4
	44e35024: 00000020                                            ...

 - write to WCLR
	barebox at TI AM335x BeagleBone black:/ mw 0x44e35024 0x0

 - check result; write succeeded
	barebox@TI AM335x BeagleBone black:/ md 0x44e35024+4
	44e35024: 00000000                                           ....

(This is was tested on an AM335x.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
