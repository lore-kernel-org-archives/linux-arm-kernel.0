From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Oct 2013 00:49:11 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20131002193316.GR12758@n2100.arm.linux.org.uk>
References: <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
 <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
 <20130927202110.GI12758@n2100.arm.linux.org.uk>
 <20130928083859.GQ12758@n2100.arm.linux.org.uk>
 <20130929061303.GB26156@S2101-09.ap.freescale.net>
 <20131002193316.GR12758@n2100.arm.linux.org.uk>
Message-ID: <20131002234911.GD12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 08:33:16PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 29, 2013 at 02:13:05PM +0800, Shawn Guo wrote:
> > On Sat, Sep 28, 2013 at 09:38:59AM +0100, Russell King - ARM Linux wrote:
> > > Okay, the answer is that yes, GPR1 bit 21 should be clear on this version
> > > of the hardware, but there's plans to have the IMX6 generate the clock
> > > and remove the crystal for the AR8035.
> > 
> > Be careful, as mentioned in the reply to Matt, in that case, IMX6 can
> > only output the clock on pad GPIO_16, and the clock has to be externally
> > routed back to IMX6 on pad ENET_REF_CLK, so that ENET can get reference
> > clock for RGMII mode.
> 
> Let me repeat that in case it was unclear.
> 
> The AR8035 on the current boards has a 25MHz crystal, and the AR8035 is
> *currently* required to be programmed to generate a 125MHz clock back to
> the IMX6 for the transmit timings.
> 
> In future, and on the real cubox-i, this crystal will not be present, and
> it will be required that the IMX6 generates the 25MHz clock for the
> AR8035.
> 
> So, for the _existing_ hardware, it is _required_ that the AR8035
> generates the transmit clock, and this is fed in on GPIO 16 as
> ENET_REF_CLK.  This means that SION for this *must* be set and
> GPR1 bit 21 *must* be clear.

Okay, I think I'm getting to the bottom of this.

RGMII mode.

In current hardware, the phy has its own 25MHz crystal.  This provides
the phy with its clocks, and the phy itself contains a PLL, which it
uses to generate 125MHz.

The phy can be (and is) configured to generate this 125MHz clock on
the CLK_25M pin, which is connected to the IMX6 ENET_REF_CLK pad (V22
ball).

Hence, we have in DT:
	MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK

So far, so good. 


On current hardware, GPIO 16 is not connected to anything except some
0402 resistor pads where the resistor is not fitted.  On future hardware,
the above crystal will be removed, and the appropriate 0402 resistor
placed to supply a clock provided on GPIO 16 to the phy.

Hence, to support both hardware configurations transparently, GPIO 16
should be configured to generate a 25MHz clock for use by the phy.

This apparantly is done by configuring the PLL on the IMX6 to 25MHz and
getting it to output it on this pin, and that is done in the freescale
BSP by this pin control setting:

	MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT

Now, if you look up that in the 4.1.0 BSP:

#define MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT                        \
		IOMUX_PAD(0x05E4, 0x0214, 0x12, 0x080C, 0, NO_PAD_CTRL)

and that says to write 0x12 to 0x20e0000 + 0x214 - the
IOMUXC_SW_MUX_CTL_PAD_GPIO16 register.  This name clearly implies that
the IMX6 is _outputting_ the reference clock.  The register values here
selects MUX_MODE 2 (ENET_REF_CLK) _with_ SION set.  There is no
configuration in this BSP for GPIO 16 in mux mode 2 without SION set.

However, because we want this pad to produce a clock from the internal
PLL, GPR1 bit 21 has to be set.  Remember - the ENET_TX_CLK is configured
to come from the ENET_REF_CLK pad, not GPIO 16.

So, I contend that it _is_ valid to have both GPIO 16 SION set and GPR1
bit 21 set.

All in all, we don't want to clear GPR1 bit 21 ever on the Cubox-i SOM.

Whether SION should be set or not is another - separate - issue.  All
we really care about is getting GPIO 16 providing a 25MHz clock.
