From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 Dec 2010 13:14:00 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <87wrntrrc2.fsf@lechat.rtp-net.org>
References: <20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
	<20101201111448.GF6017@pengutronix.de>
	<878w09u3nu.fsf@lechat.rtp-net.org>
	<20101201154128.GG6017@pengutronix.de>
	<87wrntrrc2.fsf@lechat.rtp-net.org>
Message-ID: <20101202121400.GH6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 12:44:29AM +0100, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> Hi,
> > On Wed, Dec 01, 2010 at 12:35:17PM +0100, Arnaud Patard wrote:
> >> Sascha Hauer <s.hauer@pengutronix.de> writes:
> >> 
> >> > On Mon, Nov 29, 2010 at 08:27:21PM -0200, Fabio Estevam wrote:
> >> >> Hi Sascha,
> >> >> 
> >> >> On Mon, Nov 29, 2010 at 7:24 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> >> ....
> >> >> >> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
> >> >> >> tool and placed it under /lib/firmware, but the result is the same
> >> >> >> with or without a valid firmware: when request_firmware is called the
> >> >> >> following crash happens:
> >> >> >
> >> >> > I tried to reproduce this today. Instead of crashing my kernel simply
> >> >> > hangs. This seems to be because request_firmware waits till the firmware
> >> >> > appears which never happens. I remember a crash like this though, I
> >> >> > think it has something to do with the firmware related kconfig options.
> >> >> > I hope to find a time slot later this week to track this down.
> >> >> 
> >> >> Could you please share your .config?
> >> >> 
> >> >> I would like to compare what may be causing the different behaviours
> >> >> we are seeing.
> >> >
> >> > It seems the reason for the crash is that firmware_class registers in
> >> > fs_initcall whereas the sdma driver uses it at subsys_initcall time.
> >> > Solution is to either use module_init in the sdma driver or
> >> > subsys_initcall in drivers/base/firmware_class.c.
> >> 
> >> When do we need to get sdma initialised & working ? if it's needed only
> >> by drivers, module_init should be fine, right ?
> >
> > It's needed only by drivers, yes. If it's fine depends on the link
> > order. The SDMA code is needed by the mxcmmc driver dor example, which
> > happens to be initialized after the dma code (see drivers/Makefile). So
> > it's fine as long nobody changes this order.
> >
> 
> I think that the pata driver in freescale tree is using SDMA... so it
> won't work ?

Probably not.

> 
> >> 
> >> >
> >> > When given a firmware it works, when no firmware is given the kernel
> >> > locks for some time because it waits for the firmware to appear which
> >> > never happens. We should probably use request_firmware_nowait in the
> >> > sdma driver.
> >> 
> >> what will happen if request_firmware_nowait() fails ? sdma becomes
> >> non-functionnal ?
> >
> > I haven't really looked into it. With one patch of my for-next queue the
> > SDMA engine runs will run without any firmware using the scripts in ROM.
> > So I suppose we can change the code so that once the firmware actually
> > is available we can add the missing RAM script pointers.
> >
> >> 
> >> >
> >> > I put together a branch with sdma sound working on the babbage and
> >> > mx35-3ds boards using mx3_defconfig/mx51_defconfig from this branch.
> >> > The branch works with and without firmware with the mentioned wait time
> >> > when the firmware is not available.
> >> 
> >> oh, you have a working sgtl5000 driver ready for mainline ?
> >
> > In the said branch there is a cleaned up sgtl5000 driver. What I would
> > do next is to post it and see what reactions I get. Unfortunately I
> > don't have the time to react on the reviews at the moment.
> >
> >> 
> >> >
> >> > BTW I changed the SDMA firmware repository to name the i.MX51 firmware
> >> > *to3.bin instead of to1, because that's what it actually is.
> >> >
> 
> what about to2 ?

Someone from Freescale (I think it was Yong) said to me 'if you find a
board with an i.MX51 older than to3 outside of Freescale, just throw it
away'. I don't know which SDMA code we have to use for to2.

> 
> >> > Sound support is a story with many frameworks and a lot of board
> >> > specifics involved, but I hope we manage to sort this out for i.MX soon.
> >> > Sorry for the inconvenience.
> >> >
> >> > It would be great if someone steps forward and mainlines this sgtl5000
> >> > codec driver, that's currently the main showstopper for sound support on
> >> > the Freescale boards.
> >> 
> >> hmm.... so I guess that I can answer myself at my last question: no.
> >
> > Well, as said I consider it ready for a first try. I don't now what Mark
> > Brown says to it though.
> >
> >> At
> >> least your sound branch can be used to test sound support ?
> >
> > Yes. It works on my babbage board and on a i.MX35 3ds board.
> 
> so, after fighting a little bit (my work is based on your 2.6.38 branch
> so I've made a patch to get you sdma sound branch on it), sound started
> to work here too. Once the patch ported, my main troubles were :
> - no license on snd-soc-imx-mx2.ko
> - sgtl5000 doesn't support regulator

Let's wait for Yongs MC13892 regulator driver then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
