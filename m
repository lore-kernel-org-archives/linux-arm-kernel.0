From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 01 Dec 2010 12:35:17 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <20101201111448.GF6017@pengutronix.de> (Sascha Hauer's message of
	"Wed, 1 Dec 2010 12:14:48 +0100")
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
	<20101201111448.GF6017@pengutronix.de>
Message-ID: <878w09u3nu.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Mon, Nov 29, 2010 at 08:27:21PM -0200, Fabio Estevam wrote:
>> Hi Sascha,
>> 
>> On Mon, Nov 29, 2010 at 7:24 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> ....
>> >> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
>> >> tool and placed it under /lib/firmware, but the result is the same
>> >> with or without a valid firmware: when request_firmware is called the
>> >> following crash happens:
>> >
>> > I tried to reproduce this today. Instead of crashing my kernel simply
>> > hangs. This seems to be because request_firmware waits till the firmware
>> > appears which never happens. I remember a crash like this though, I
>> > think it has something to do with the firmware related kconfig options.
>> > I hope to find a time slot later this week to track this down.
>> 
>> Could you please share your .config?
>> 
>> I would like to compare what may be causing the different behaviours
>> we are seeing.
>
> It seems the reason for the crash is that firmware_class registers in
> fs_initcall whereas the sdma driver uses it at subsys_initcall time.
> Solution is to either use module_init in the sdma driver or
> subsys_initcall in drivers/base/firmware_class.c.

When do we need to get sdma initialised & working ? if it's needed only
by drivers, module_init should be fine, right ?

>
> When given a firmware it works, when no firmware is given the kernel
> locks for some time because it waits for the firmware to appear which
> never happens. We should probably use request_firmware_nowait in the
> sdma driver.

what will happen if request_firmware_nowait() fails ? sdma becomes
non-functionnal ?

>
> I put together a branch with sdma sound working on the babbage and
> mx35-3ds boards using mx3_defconfig/mx51_defconfig from this branch.
> The branch works with and without firmware with the mentioned wait time
> when the firmware is not available.

oh, you have a working sgtl5000 driver ready for mainline ?

>
> BTW I changed the SDMA firmware repository to name the i.MX51 firmware
> *to3.bin instead of to1, because that's what it actually is.
>
> Sound support is a story with many frameworks and a lot of board
> specifics involved, but I hope we manage to sort this out for i.MX soon.
> Sorry for the inconvenience.
>
> It would be great if someone steps forward and mainlines this sgtl5000
> codec driver, that's currently the main showstopper for sound support on
> the Freescale boards.

hmm.... so I guess that I can answer myself at my last question: no. At
least your sound branch can be used to test sound support ?

Arnaud
