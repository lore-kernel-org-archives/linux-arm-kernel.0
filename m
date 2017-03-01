From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 1 Mar 2017 20:41:16 +0100 (CET)
Subject: [PATCH v3 2/7] mmc: bcm2835: Add new driver for the sdhost
 controller.
In-Reply-To: <87varsequk.fsf@eliezer.anholt.net>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-3-git-send-email-kraxel@redhat.com>
 <87tw7c27xk.fsf@eliezer.anholt.net>
 <68761051.37200.1488396112552@email.1und1.de>
 <87varsequk.fsf@eliezer.anholt.net>
Message-ID: <180442771.37741.1488397276709@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 1. M?rz 2017 um 20:31 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> >> Eric Anholt <eric@anholt.net> hat am 1. M?rz 2017 um 19:00 geschrieben:
> >> 
> >> 
> >> Gerd Hoffmann <kraxel@redhat.com> writes:
> >> 
> >> > From: Eric Anholt <eric@anholt.net>
> >> >
> >> > The 2835 has two SD controllers: The Arasan sdhci controller (supported
> >> > by the iproc driver) and a custom sdhost controller.  This patch adds a
> >> > driver for the latter.
> >> >
> >> > The sdhci controller supports both sdcard and sdio.  The sdhost
> >> > controller supports the sdcard only, but has better performance.  Also
> >> > note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
> >> > controller allows to use the sdhci controller for wifi support.
> >> >
> >> > The configuration is done by devicetree via pin muxing.  Both SD
> >> > controller are available on the same pins (2 pin groups = pin 22 to 27 +
> >> > pin 48 to 53).  So it's possible to use both SD controllers at the same
> >> > time with different pin groups.
> >> >
> >> > The code was originally written by Phil Elwell in the downstream
> >> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> >> > out of the original 2055) for inclusion.
> >> >
> >> > Signed-off-by: Eric Anholt <eric@anholt.net>
> >> 
> >> Ulf, what do you need done to this driver patch before it can go in?
> >> The commit message seems like it could use some rewriting at this point
> >> (Personally I would drop the detailed changelogs from Stefan and Gerd,
> >> updating the last paragraph here to give them credit), but what's
> >> important to me is getting the driver in so that distros don't have to
> >> carry this patch for wifi support.
> >
> > I'm still working on 3 small patches for this driver:
> >
> > 1. trivial error in a register comment
> > 2. ignore SDCMD_FAIL_FLAG during bcm2835_finish_command (downstream [1])
> > 3. remove unnecessary call to bcm2835_reset_internal
> >
> > I plan to submit them on Friday.
> >
> > [1] - https://github.com/raspberrypi/linux/commit/711cade866c9f865f9b283c9369e9486f27d1fec
> 
> Should any of those changes block merging the current code, though? 

No, but the recursion about bcm2835_finish_command() and bcm2835_transfer_complete() is still there.
