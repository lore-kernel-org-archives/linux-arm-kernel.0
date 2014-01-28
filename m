From: marex@denx.de (Marek Vasut)
Date: Tue, 28 Jan 2014 02:01:39 +0100
Subject: Freescale FEC packet loss
In-Reply-To: <1390772013.2735.47.camel@deadeye.wl.decadent.org.uk>
References: <201401222255.29467.marex@denx.de>
 <201401262012.13051.marex@denx.de>
 <1390772013.2735.47.camel@deadeye.wl.decadent.org.uk>
Message-ID: <201401280201.39174.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 26, 2014 at 10:33:33 PM, Ben Hutchings wrote:
> On Sun, 2014-01-26 at 20:12 +0100, Marek Vasut wrote:
> > On Sunday, January 26, 2014 at 07:56:30 PM, Ben Hutchings wrote:
> > > On Wed, 2014-01-22 at 22:55 +0100, Marek Vasut wrote:
> > > > Hi guys,
> > > > 
> > > > I am running stock Linux 3.13 on i.MX6Q SabreLite board. The CPU is
> > > > i.MX6Q TO 1.0 .
> > > > 
> > > > I am hitting a WARNING when I use the FEC ethernet to transfer data,
> > > > thus I started investigating this problem. TL;DR I am not able to
> > > > figure this problem out, so I am not attaching a patch :-(
> > > > 
> > > > Steps to reproduce:
> > > > -------------------
> > > > 1) Boot stock Linux 3.13 on i.MX6Q SabreLite board
> > > > 2) Plug in an SD card into one of the SD slots (I use the full-size
> > > > one) 3) Plug in an USB stick into one of the USB ports (I use the
> > > > upper one) 4) Plug in an ethernet cable into the board
> > > > 
> > > >    -> Connect the other side into a gigabit-capable PC
> > > 
> > > [...]
> > > 
> > > I think there are known problems with 1000BASE-T on the Sabre Lite
> > > board.
> > 
> > This is MX6-wide thing, not sabrelite specific actually.
> > 
> > > Two possible workarounds are to limit the PHY to 100BASE-TX
> > > (should be doable with ethtool) or force it to be clock master for
> > > 1000BASE-T (requires a driver patch).
> > 
> > Can you please elaborate on the later ? I don't quite understand that.
> 
> 1000BASE-T uses all 4 pairs in both directions at the same time, which
> requires that both ends transmit symbols synchronously.  As part of the
> autonegotiation protocol, they decide which is the clock master (using a
> local clock generator) and which is the clock slave (generating a clock
> from the received signal).  A PHY can be configured to support only one
> of these roles.

I checked the patch you pointed me to. The patch basically messes with the 
CTL1000 (0x9) register of the PHY, right ? I did the adjustments to the PHY 
register manually , but the result is still the same (backtrace).

I did two different kinds of adjustment:
1) reg 0x9 |= 0x1800;
2) reg 0x9 |= 0x1000;
In both cases, the crash did happen. I verified the PHY register was configured 
as necessary. The KSZ9021 PHY bit 12 configures the master/slave override, same 
as the patch does. The bit 11 forces either master or slave mode for the PHY. In 
both cases the crash was there.

I think this patch won't help in this case, sorry.

Best regards,
Marek Vasut
