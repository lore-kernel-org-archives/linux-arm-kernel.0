From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 18:49:16 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
Message-ID: <20130927174916.GD12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 11:52:52AM -0500, Matt Sealey wrote:
> Russell,
> 
> There is a chicken bit in the IOMUXC GPR1 (IOMUXC+0x4 bit 21, it's on
> page 1927 of the i.MX6DQRM Rev 1 04/2013) which turns on or off the
> ENET_REF_CLK loopback. You could need to clear it to make the pad an
> input to the i.MX6 rather than an output to the PHY.. while it may
> seem like this removes the need for the SION bit in the pin you want,
> that's actually also required otherwise the pad mux latch 'sees' the
> data but the input latch behind it doesn't.
> 
> There is a great diagram somewhere in the manual (Figure 28-1, right
> at the top of the GPIO docs) - SION *forces* data (it's the input_on
> signal in the diagram IIRC) to the gpio data register behind the
> IOMUX, but the logic behind every muxed pad is almost the same across
> the SoC.

The manual which Fabio pointed me at (iMX 6Solo/6DualLite - IMX6SDLRM.pdf)
doesn't correspond - figure 28-1 is something entirely different.

> In essence, the pad control setting needs to be correct (SION set) and
> that chicken bit correctly cleared, or the clock input never goes into
> the MAC, because the MAC isn't connected directly to the pad, it's
> connected to the input latch. The only logic block that can 'really'
> read the pad latch is the GPIO unit.
> 
> Note that you MAY have to cycle the clock or reset the PHY or MAC
> *after* setting the pin up, otherwise the MAC won't get the clock..
> it's really a laborious process which isn't described properly in the
> DT (all it needs is a property to define where it's clock comes from
> and Do The Right Thing (tm) at driver init.. because this is
> infuriatingly common on i.MX6 designs, but not so common that everyone
> needs it)

Okay, but from what I'm working from (which works) the order is:

- Set IOMUXC GPR1 bit 21.
- Set ipg/ahb ethernet clock to 50MHz
- IOMUX settings applied, including setting the reference clock SION bit
- Reset lowered, wait 2ms, reset raised
- imx6_init_fec(fec_data_rgmii) called

After that is the time that the phy is configured to supply the 125MHz
reference clock into the IMX6.

That order seems to be happening with my 3.12-rc1 kernel, although a
little more spread out.

Thanks.
