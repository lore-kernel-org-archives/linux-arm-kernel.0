From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Apr 2014 18:29:33 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <533AC67D.2060906@boundarydevices.com>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <533AC67D.2060906@boundarydevices.com>
Message-ID: <20140401172933.GB7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 07:00:29AM -0700, Eric Nelson wrote:
> Hi Russell,
>
> What value do you have for pad control register
> IOMUXC_SW_PAD_CTL_PAD_RGMII_TX_CTL (0x020E0388)?

You're referring to the iMX6Q, the Hummingboard is iMX6S, so that's
0x20e06bc.  I have value 0x1b030.

> I notice in some of the DTS files that this has a value of 0x100b0,
> which seems wrong. Bit 16 seems to be a HYSteresis bit, and enabling
> that seems wrong (also bit 7 seems wrong, as it's undefined in the RM).

Yes, bit 7 should not be set as it's reserved, but this is ignored.
Setting the hysteresis bit affects the input thresholds, and this signal
is only ever used as an output.  While selecting HYS mode for an output
may seem odd, that should not have any effect here.

In any case, TX_CTL doesn't have much to do with it.  I've fully proved
that the interface works fine under full duplex conditions, achieving
500Mbps transmit and 570-600Mbps receive with TCP connections (which is
nicely beyond what freescale claim the hardware is capable of.)

The phy needs TX_CTL asserted in order to transmit anything, so as it
works in full duplex mode, this must be happening correctly.

The FEC needs RX_CTL asserted to indicate that valid data is being
received by the phy - if this was not being recognised by the FEC, full
duplex mode wouldn't work.

The last scenario is the error signals encoded onto TX_CTL/RX_CTL.  This
is one area I can't comment on yet - monitoring these signals is not
exactly easy (and requires two steady hands.)  However, I have briefly
monitored these signals when running at 100mbit half-duplex. With the
scope RX_CTL and triggering on it, I do see TX_CTL being raised by the
FEC.

Whether TX_CTL is raised by the FEC just before or after RX_CTL has been
asserted I can't say yet.

However, TX_CTL raised while RX_CTL is raised or toggling means that a
collision has occurred.  TX_CTL should never be raised while RX_CTL
indicates that there is a "carrier" present in half-duplex mode (and
therefore there is already another ethernet station transmitting on
the wire.)

Remember, I'm seeing late collisions.  The only way that happens is if
something starts transmitting after 64 bytes into an ethernet frame, and
it implies that something is not noticing that the link is busy before it
starts blurting out.

I know that my hubs are fine - the 10mbit hub has been used over _many_
years (it's more than 20 years old now) and has always been rock solid...
unlike the 10/100 hub with a dodgy switch between the two segments which
I can lock out the 10 mbit segment with enough 100mbit traffic.

Let's also not forget that these signals run at 125MHz at gigabit speeds,
and 2.5MHz at 10mbit...  if they were marginal at 10mbit, gigabit
certainly would not work.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
