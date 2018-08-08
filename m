From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 8 Aug 2018 23:32:04 +0200
Subject: Droid 4: suspend to RAM?
In-Reply-To: <20180808090512.GQ99251@atomide.com>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd> <20180727113214.GA32069@amd>
 <20180808090512.GQ99251@atomide.com>
Message-ID: <20180808213204.GD15831@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-08 02:05:12, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180727 11:35]:
> > Hi!
> > > > > high even before modem (and thus USB) is enabled.
> > > > >
> > > > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > > > consumption than stock operating system.
> > > > >
> > > > > (My Linux can survive for 10 hours, stock system could survive for 4
> > > > > days if I'm not mistaken).
> > > > >
> > > > > I thought I would experiment with suspend to RAM.. and it indeed
> > > > > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > > > > wakeup with button somehow? Is suspend to RAM required for good power
> > > > > consumption?
> > > > 
> > > > Sorry but pm subsystem has debug mode that you can test in a easy way.
> > > > You can even wakeup by any rtc alarm easily.
> > > 
> > > Yes, that is how it works on PC (but there power button works,
> > > too). Is it expected to work on Droid in v4.18?
> > 
> > I tried setting up wakeup using RTC, but no, it does not seem to work:
> > 
> > root at devuan:/my/tui/d4# rtcwake -m no -s 5
> > rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
> > root at devuan:/my/tui/d4# echo mem > /sys/power/state
> 
> Works for me here as tested on next-20180808, maybe you don't have
> CONFIG_RTC_DRV_CPCAP? Maybe you are trying to use
>CONFIG_RTC_DRV_OMAP?

I tried with mainline... there will be no graphics in next, right? And
yes, I had CONFIG_RTC_DRV_CPCAP and not CONFIG_RTC_DRV_OMAP.

> Then for deeper idle modes, you need to also idle UARTs, and unbind or
> unload USB related modules. You should get to something like 160mW
> power consumption with mdm6600 enabled and SoC suspended that way.

That's slightly interesting. echo mem > /sys/power/state should do all
the work, right? Disable UARTs etc. Plus, is 160mW still a bit high?

> Then again system running idle is about the same with timers and
> interrupts working so I'd just idle UARTs and unload USB modules :)
> 
> My UART idle script below for reference.

Thanks, let me try...

								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/7ac2c84e/attachment.sig>
