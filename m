From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 11 Apr 2012 02:38:53 +0100
Subject: [PATCH] ARM: orion5x: Fix GPIO enable bits for MPP9
In-Reply-To: <20120411012133.GD14790@titan.lakedaemon.net>
References: <1333771725.7150.32.camel@deadeye>
 <20120411012133.GD14790@titan.lakedaemon.net>
Message-ID: <1334108333.7150.333.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-04-10 at 21:21 -0400, Jason Cooper wrote:
> On Sat, Apr 07, 2012 at 05:08:45AM +0100, Ben Hutchings wrote:
> > Commit 554cdaefd1cf7bb54b209c4e68c7cec87ce442a9 seems to have
> > accidentally inverted the GPIO valid bits for MPP9 (only).  For the
> > mv2120 platform which uses MPP9 as a GPIO LED device, this results in
> > the error:
> > 
> > [   12.711476] leds-gpio: probe of leds-gpio failed with error -22
> > 
> > Reported-by: Henry von Tresckow <hvontres@gmail.com>
> > References: http://bugs.debian.org/667446
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Cc: stable at vger.kernel.org [v3.0+]
> > ---
> > I know nothing about this platform, and this is totally untested.  But
> > it does look quite straightforward...
> 
> Can we confirm that it doesn't break functionality on the following:
> 
> * d2net            (MPP9_GPIO, /* Rear power switch (auto|off) */)
> * db88f5281        (MPP9_GPIO, /* JP3, CON11.3 */)
> * dns-323          (MPP9_GPIO, /* power button switch */)
> * dns-323b         (MPP9_GPIO, /* power button switch */)
> * dns-323c         (MPP9_GPIO, /* i/o left amber LED */)
> * ls-chl           (MPP9_GPIO, /* USB POWER */)
> * ls_hgl           (MPP9_GPIO, /* USB_PWR */)
> * lsmini           (MPP9_GPIO, /* LED_FUNC */)
> * mv2120           (MPP9_GPIO, /* SATA 1 fail LED */)
> * net2big          (MPP9_GPIO, /* Rear power switch (auto|off) */)
> * rd88f5181l-fxo   (MPP9_GPIO, /* GE_RXERR */)
> * rd88f5181l-ge    (MPP9_GPIO, /* GE_RXERR */)
> * terastation_pro2 (MPP9_GPIO, /* RTC int */)
> * wnr854t          (MPP9_GIGE, /* GE_RXERR */)
> * wrt350n-v2       (MPP9_GIGE, /* GE_RXERR */)

The flags in question control whether the pin is exposed to the rest of
the system as a GPIO, not how the hardware is configured.  Just look at
how these tables and flags are being used in
arch/arm/plat-orion/mpp.c:orion_mpp_conf(), and compare with all the
other MPPn_GPIO definitions.

Also look at the old determine_type_encoding() function removed by the
earlier commit: there is nothing special about MPP9.

mv2120 currently has broken LEDs because MPP9 is not exposed as a GPIO,
and many of the others probably have the same problem.

> Also, while I'm looking at it, Is it correct that four boards
> (rd88f5181l-*, wnr854t, wrt350n-v2) use the same pin for the same
> purpose, two declare it as GPIO, and two as GIGE... :-/  Perhaps part of
> the same problem?

I would guess that all those boards should specify MPP9_GIGE, but I'm
just trying to fix a recent regression.

Ben.

-- 
Ben Hutchings
It is easier to change the specification to fit the program than vice versa.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/9a96ad1f/attachment-0001.sig>
