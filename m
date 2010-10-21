From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 20 Oct 2010 20:32:26 -0500
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <8739s0iqu9.fsf@lechat.rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020091654.GL28166@pengutronix.de>
	<AANLkTimoLQKUjrTHv9xwd8TkGQ3inT_+4-hjfo+Tudj=@mail.gmail.com>
	<20101020192641.GA6466@bee.dooz.org>
	<8739s0iqu9.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTiksPJ_KXtvqXAa+SxrqM4yyyT_Gjmub5MpEa4LG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 2:53 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
>
> The TO2 and TO3 are very similar but there are important differencies :
> - different reset pin
> - mmc slot on mmc0 (esdhci1) vs mmc1 (esdhci2)

Actually the 1.1 boards have two SD card slots (one is inside under
the lid, MicroSD) and the differentiation is merely so that the front
slot always gets the LED activity (it's more useful to users to know
that the SD card they inserted is doing stuff than the magic one
behind 9 screws that you need to dismantle the case to get to..)

> So you do need to know if you're either on TO2 or TO3 and you can't
> guess this info without looking at the board id pins.

Ideally the board id pins would be implemented on all revisions of the
board, but since they are not there on 1.0 and 1.1 (and the IOMUX
takes time to settle to pretend they are there with pullups/pulldowns)
this is the hard cause of the problem. However, reading board id pins
right after IOMUX is going to cause random results on any board.

Check the Genesi git tree (arch/arm/mach-mx5/mx51_efikamx_io.c) and
you'll see how we split this up to basically set up the pins, do other
things, THEN find out the board id. The similarities mean you can go
and do a bunch of other stuff while you are waiting for the IOMUX to
settle, and by that time it will be done. While that time is not
exactly deterministic, it is certainly not 500ms, we used to have a
delay of 100ms just to be very very sure, and then just split it out
and it works just as well.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
