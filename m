From: l.fu@pengutronix.de (Luotao Fu)
Date: Mon, 21 Jun 2010 09:37:36 +0200
Subject: [PATCH] imxfb: add flag to avoid disabling clk multiple times
In-Reply-To: <4C1CE6B8.4090504@gmail.com>
References: <1275561288-20661-1-git-send-email-l.fu@pengutronix.de>
	<4C1CE6B8.4090504@gmail.com>
Message-ID: <20100621073736.GA24817@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Sat, Jun 19, 2010 at 05:48:08PM +0200, Martin Fuzzey wrote:
> Hi Luotao,
> 
> Luotao Fu wrote:
> > while the imxfb driver blanks the screen. The clock supply to the framebuffer
> > controller is disabled. The same callback to disable the fb is, however, also
> > used the remove and shutdown hooks of the imxfb platform driver. This means that
> > the imxfb driver can run into a WARN in clock_disable while unloading or
> > rebooting, if the screen is blanked previously, since the same clock will be
> > than eventually disabled multiple times.  This patch adds a flag to make sure
> > that the clock will only be disabled, if it was not already disabled before.
> >
> >   
> Actually it's worse than that - you don't need to unload the
> driver or reboot to run into this problem because imxfb_blank()
> calls imxfb_disable_controller() for cases
>     case FB_BLANK_POWERDOWN:
>     case FB_BLANK_VSYNC_SUSPEND:
>     case FB_BLANK_HSYNC_SUSPEND:
>     case FB_BLANK_NORMAL:
> 
> Often an X server will call these after successive timeouts
> (eg Normal, Suspend, Powerdown) so you can get into the
> multiple suspend problem you describe just by waiting long
> enough for at least two blank levels to be activated.
> 
> Furthermore once this happens, not only does a WARN occur
> in clock_disable but the clock usage counter will actually become
> negative so it will require multiple wake up requests to switch
> the display back on.
> 
> I was just about to post a patch for this but I see you beat
> me to it :).
> 
> Your patch fixes the clock_disable problem but fbi->backlight_power()
> and fbi->lcd_power() can still be called multiple times.
> Not sure if that is really a problem - they should be idempotent.
> 

Multiple calling of the backlight_power and lcd_power function hooks
should be no trouble on most platforms since they mostly control some
PWM or GPIO lines, which won't complain to be turned on or off again.
Never the less I agree with you that this is quite unneccessary.

> I did it by making all of imxfb_disable_controller() do nothing if the
> disable was already done like this  (just for illustration not submission,
> lines may be mangled):
> 

This solution looks better and more clear than mine, which only concentrate
on clock. Only nitpickings: I'd probably defined "enabled" as a bool. Further
it might be nice to change pr_debug so that one would see a failed
enable/disable call. some like
pr_debug("Disabling LCD controller ... ");

if (!fbi->enabled) {
	pr_debug("already disabled\n");
	return;
} else
		pr_debug("\n");

Applied and tested on my board here. (consolefb only, no X running.)
so far:
Acked-by: Luotao Fu <l.fu@pengutronix.de>

 
thanks
and
cheers

Luotao Fu
-- 
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100621/82ae43a9/attachment.sig>
