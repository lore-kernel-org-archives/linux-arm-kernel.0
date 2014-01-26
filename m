From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 26 Jan 2014 21:33:33 +0000
Subject: Freescale FEC packet loss
In-Reply-To: <201401262012.13051.marex@denx.de>
References: <201401222255.29467.marex@denx.de>
 <1390762590.2735.39.camel@deadeye.wl.decadent.org.uk>
 <201401262012.13051.marex@denx.de>
Message-ID: <1390772013.2735.47.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-01-26 at 20:12 +0100, Marek Vasut wrote:
> On Sunday, January 26, 2014 at 07:56:30 PM, Ben Hutchings wrote:
> > On Wed, 2014-01-22 at 22:55 +0100, Marek Vasut wrote:
> > > Hi guys,
> > > 
> > > I am running stock Linux 3.13 on i.MX6Q SabreLite board. The CPU is
> > > i.MX6Q TO 1.0 .
> > > 
> > > I am hitting a WARNING when I use the FEC ethernet to transfer data, thus
> > > I started investigating this problem. TL;DR I am not able to figure this
> > > problem out, so I am not attaching a patch :-(
> > > 
> > > Steps to reproduce:
> > > -------------------
> > > 1) Boot stock Linux 3.13 on i.MX6Q SabreLite board
> > > 2) Plug in an SD card into one of the SD slots (I use the full-size one)
> > > 3) Plug in an USB stick into one of the USB ports (I use the upper one)
> > > 4) Plug in an ethernet cable into the board
> > > 
> > >    -> Connect the other side into a gigabit-capable PC
> > 
> > [...]
> > 
> > I think there are known problems with 1000BASE-T on the Sabre Lite
> > board.
> 
> This is MX6-wide thing, not sabrelite specific actually.
> 
> > Two possible workarounds are to limit the PHY to 100BASE-TX
> > (should be doable with ethtool) or force it to be clock master for
> > 1000BASE-T (requires a driver patch).
> 
> Can you please elaborate on the later ? I don't quite understand that.

1000BASE-T uses all 4 pairs in both directions at the same time, which
requires that both ends transmit symbols synchronously.  As part of the
autonegotiation protocol, they decide which is the clock master (using a
local clock generator) and which is the clock slave (generating a clock
from the received signal).  A PHY can be configured to support only one
of these roles.

> > The vendor kernel apparently does both!
> 
> More like the vendor kernel papers over this bug.
> 
> > Matthew Garrett has been trying to implement a workaround in a
> > clean way.
> 
> Do you have any pointers about this please ?

http://thread.gmane.org/gmane.linux.drivers.devicetree/58570

Ben.

-- 
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140126/3121cd37/attachment.sig>
