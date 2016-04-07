From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Apr 2016 21:48:29 +0200
Subject: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
In-Reply-To: <20160407174019.GM16484@atomide.com>
References: <20160207212316.GA6147@amd> <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd> <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd> <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd> <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd> <20160407174019.GM16484@atomide.com>
Message-ID: <20160407194828.GA13338@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > Ok, I realized that _something_ set up my keyboard on console, too, so
> > > > I'm able to do "init 1" and still interact with the console.
> > > > 
> > > > cm_idlest1_core blocking bits are now 0x42 pretty consistently. But
> > > > they stay 0x42, even when screen is on (and screen on prevents low
> > > > power, right?) so I guess they are not the whole story.
> > > 
> > > Yes they stay at 0x42. And it seems you've configured the UART
> > > idle timeouts too.
> > 
> > Yes, thanks for the script ;-).
> > 
> > > > I'm able to get down to 50mA power consumption with screen off. I was
> > > > getting 90mA with X, wifi in powersave and screen off.
> > > > 
> > > > Head proximity sensor is still on in this configuration. But I guess
> > > > that should not keep the system busy...?
> > > > 
> > > > Ok, wait a moment, I'm getting "Camera Focus", "Camera Capture" and
> > > > "Lock button" interrupts ... at something like 20/second. Without
> > > > touching anything. Hmm. Also "pm_wkup", but that might be
> > > > expected. Plus, 49052000.gpio and 49054000.gpio are rather
> > > > active. Might be related to the above. Also "gp_timer" and
> > > > 48070000.i2c are active, perhaps also related. I don't think I have
> > > > the camera working...
> > > 
> > > Hmm that does not sound right at all for the GPIOs. The pm_wkup
> > > interrupt triggers every time you hit wfi pretty much, so that
> > > should be OK.
> > 
> > Wifi was down at that point.
> > 
> > Some more testing: after boot, interrupt counts stay low, as
> > expected. But when I attempt to enable power management, they start
> > rising. Sometimes 60/second, sometimes less.
> > 
> > Things are fine as long as I don't enable the off mode; when I enable
> > the off mode, "echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode"
> > interrupt counts start rising immediately. "echo 0 >
> > /sys/kernel/debug/pm_debug/enable_off_mode" stops that.
> > 
> > But no matter what configuration, activity LEDs still indicate it is
> > busy, and idle power consumption is cca 53mA.
> 
> Not seeing that here at all. My n900 with v4.6-rc2 and omap2plus_defconfig
> booted with u-boot keeps hitting off mode with both LEDs going off just
> fine. It's waking up about once a second or a litte bit more often.

Ok, that was 4.4 (with patches that should not be related).

I now checked with 4.6-rc2+mini_changes, and I'm getting similar results:

Battery 4.05V 4.07V 4.11V 85% 91% 98% 1546/1569 mAh Full -131/550/100
mA
00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
f7fffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042
0000000d 48004a28 (fa004a28) cm_idlest3_core

I'm booting from NOLO, and I'm _not_ loading/removing gadget modules,
as blocking bits are 0x42, so gadget is not a problem. (Let me know if
I'm wrong).

Let me retry with 4.6-rc2 (9735a22799b9214d17d3c231fe377fc852f042e9),
no modifications. Aha, but vanilla 4.6-rc2 does not have
cm_idlest1_core display in debugfs :-(. 

And yes, I see the same effect in /proc/interrupts:

180:        280  49052000.gpio   4 Edge      Camera Focus
181:        280  49052000.gpio   5 Edge      Camera Capture
(few seconds after that)
180:        738  49052000.gpio   4 Edge      Camera Focus
181:        738  49052000.gpio   5 Edge      Camera Capture

after I do echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode .

> Care to post your .config somewhere, I could give that a try?

gzipped config is attached.

Note that I'm still using NOLO. I enabled the sleep, then went to
runlevel 1. LEDs still stay on, 55mA power consumption. That was with
1 in off_mode.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 24857 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160407/6f758f45/attachment-0001.gz>
