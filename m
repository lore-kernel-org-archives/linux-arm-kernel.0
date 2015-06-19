From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Jun 2015 10:30:21 -0500
Subject: [PATCH] i2c: omap: improve duty cycle on SCL
In-Reply-To: <5583AB9D.6090805@gmx.de>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
 <55815581.80807@gmx.de> <20150617153812.GB18421@saruman.tx.rr.com>
 <5582678F.4010505@gmx.de>
 <20150618172428.GB27790@saruman.tx.rr.com>
 <5583AB9D.6090805@gmx.de>
Message-ID: <20150619153021.GD29392@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 07:41:49AM +0200, Michael Lawnick wrote:
> Am 18.06.2015 um 19:24 schrieb Felipe Balbi:
> >On Thu, Jun 18, 2015 at 08:39:11AM +0200, Michael Lawnick wrote:
> >>Am 17.06.2015 um 17:38 schrieb Felipe Balbi:
> >>>Hi,
> >>>
> >>>On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
> >>>>Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> >>>>>With this patch we try to be as close to 50%
> >>>>>duty cycle as possible. The reason for this
> >>>>>is that some devices present an erratic behavior
> >>>>>with certain duty cycles.
> >>>>>
> >>>>>One such example is TPS65218 PMIC which fails
> >>>>>to change voltages when running @ 400kHz and
> >>>>>duty cycle is lower than 34%.
> >>>>>
> >>>>>The idea of the patch is simple:
> >>>>>
> >>>>>calculate desired scl_period from requested scl
> >>>>>and use 50% for tLow and 50% for tHigh.
> >>>>...
> >>>>Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5?
> >>>>
> >>>>>PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE     UNIT
> >>>>>                                          MIN. MAX.     MIN. MAX.
> >>>>>LOW period of the SCL clock     tLOW      4.7   ?       1.3   ?       ?s
> >>>>>HIGH period of the SCL clock    tHIGH     4.0   ?       0.6   ?       ?s
> >>>>
> >>>>Your signal is in spec (0.85 ?s high, 1,65 low).
> >>>>Maybe your TPS65218 is just buggy or signals are bad?
> >>>
> >>>yes, tps is buggy, it's written in the commit log itself.
> >>>
> >>
> >>So I think it is unacceptable to change the adapters code violating
> >>specification because some buggy device doesn't work properly.
> >
> >read the other thread and you'll see that it's not violating jack
> >
> >>This change for your device has chance to blow up many correctly
> >>working ones.
> >
> >How ?
> >
> The answer is so obvious that I'm a bit irritated.
> Your patch description tells: 'and use 50% for tLow and 50% for tHigh'

another one who can't do simple algebra.

http://marc.info/?l=linux-i2c&m=143456423512634&w=2
http://marc.info/?l=linux-i2c&m=143456444212698&w=2
http://marc.info/?l=linux-omap&m=143456762413953&w=2

> For 400kHz this means 1.25 us for high and low. This clearly violates the
> specification for minimum low period and will not work with any device that
> relies on it.
> In the other thread it is discussed that your patch does effectively not do
> what you describe but this is something completely independent.

Read the comment where the calculation goes, it states that we try to
get as close to 50% duty cycle while making sure we're within spec.

Also, commit log is saying that we're using 50% of SCL period for tLow
and tHigh calculation, not that duty cycle will be 50%, which it isn't.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150619/a9f6121b/attachment.sig>
