From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:50:54 +0000
Subject: [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <20170220173633.d4ke4eohaacgsw3h@piout.net>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
 <20170220173633.d4ke4eohaacgsw3h@piout.net>
Message-ID: <20170220175054.GP21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 06:36:33PM +0100, Alexandre Belloni wrote:
> On 20/02/2017 at 18:06:11 +0100, Gregory CLEMENT wrote:
> >  On ven., f?vr. 17 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> > 
> > > The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
> > > the SOC integration differs in 2 points:
> > >      - MBUS bridge timing initialization
> > >      - IRQ configuration at SoC level
> > >
> > > This patch set extends the driver support to these SoCs family.
> > >
> > > In this second version the device tree was updated allowing to use the
> > > RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
> > > CP master is not connected (by package) to the oscillator. So this one
> > > is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
> > > will be the RTC clock in CP slave connected to the oscillator which
> > > will be used.
> > 
> > I saw on IRC than Russell managed to have a more coherent date with this
> > series on his 8040 based board. For the record, as the U-Boot on this
> > board didn't provide a "date reset" command for the RTC located on CP
> > slave, then Russell needed to do the following:
> > 
> > devmem2 0xf428401c w 0
> > devmem2 0xf4284018 w 0x2000
> 
> The question being what does that do and whether it could be done in the
> driver instead.

It's not specific to the Armada 8040, the same problem exists with
Armada 38x, so holding this up for that reason does not make sense.

>From what I've been told via SolidRun, it's an errata work-around.
Armada 38x needs "date reset" to be given _twice_ in uboot if the
RTC is not functioning, and part of the "date reset" sequence is
the above couple of register writes.

What effect it would have on an already running RTC is not known -
but using "date reset" in uboot for a correct RTC has the effect of
setting it back to 1970.

On Armada 38x:

Table 1461: RTC Clock Correction Register   Offset:   0x000A3818
Bit         Field                Type / InitVal  Description
31:16       Reserved             RSVD   0x0      Reserved
15          Correct Mode         RW     0x0      Correction Mode
                                                 0 = Low
                                                 1 = High
14:0        Correct Value        RW     0x0      Correction Value

Table 1462: RTC Test Configuration Register Offset:   0x000A381C
Bit         Field                Type / InitVal   Description
31:5        Reserved             RSVD   0x0       Reserved
4           Func Test            RW     0x0       Functional Test Acceleration
3:0         Reserved             RSVD   0x0       Reserved

So, we don't know what the first write really does.

I suspect that the errata is "RTC is not reset at power up" for the RTC
power domain.

I don't know where the value of 0x2000 comes from for the correction
value, all I know is that's the value uboot uses with "date reset".
We probably do _not_ want the driver writing that each time the
kernel boots, since that's a tuning parameter.

This is all purely guesswork though.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
