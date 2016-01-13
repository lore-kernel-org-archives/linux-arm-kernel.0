From: broonie@debian.org (Mark Brown)
Date: Wed, 13 Jan 2016 11:42:27 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <6044522.tqmlJ5a48h@wuerfel>
References: <1440159857.19360.50.camel@debian.org> <4468027.N4Q71mzei0@wuerfel>
 <20160112220058.GE6588@sirena.org.uk> <6044522.tqmlJ5a48h@wuerfel>
Message-ID: <20160113114227.GI6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 11:41:45PM +0100, Arnd Bergmann wrote:
> On Tuesday 12 January 2016 22:00:58 Mark Brown wrote:

> > There's also the potential for the overhead from interrupts to be worse
> > than the overhead for busy waiting, but given how badly we're coping now
> > it's worth another look.

> Possible, yes. Right now, we do a udelay(1), which I think waits between one and
> two microseconds normally, so we are probably adding extra latency of under
> one microsecond per byte by not polling constantly. If the interrupt latency
> from device-ready to entering the code is more than that, we can assume that
> the transfer ends up being slower. There is also some time spent for getting
> back out of the interrupt handler, but that's no worse than doing nothing
> in udelay().

Indeed.  It may also make the cache performance worse as a result of
frequently switching to the interrupt handler but if nothing else it
should make it easier for something else to get access to the CPU which
seems to be the issue here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160113/1928c3a6/attachment.sig>
