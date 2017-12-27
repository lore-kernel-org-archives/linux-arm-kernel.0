From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Dec 2017 23:20:00 +0000
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171227224252.GB2626@kwain>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171227224252.GB2626@kwain>
Message-ID: <20171227231959.GU10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 11:42:52PM +0100, Antoine Tenart wrote:
> Hi Russell,
> 
> On Wed, Dec 27, 2017 at 10:24:01PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
> > >  
> > > +&cps_eth2 {
> > > +	/* CPS Lane 5 */
> > > +	status = "okay";
> > > +	phy-mode = "2500base-x";
> > > +	/* Generic PHY, providing serdes lanes */
> > > +	phys = <&cps_comphy5 2>;
> > > +};
> > > +
> > 
> > This is wrong.  This lane is connected to a SFP cage which can support
> > more than just 2500base-X.  Tying it in this way to 2500base-X means
> > that this port does not support conenctions at 1000base-X, despite
> > that's one of the most popular and more standardised speeds.
> 
> What do you suggest to describe this in the dt, to enable a port using
> the current PPv2 driver?

I don't - I'm merely pointing out that you're bodging support for the
SFP cage rather than productively discussing phylink for mvpp2.

As far as I remember, the discussion stalled at this point:

- You think there's modes that mvpp2 supports that are not supportable
  if you use phylink.

- I've described what phylink supports, and I've asked you for details
  about what you can't support.

Unfortunately, no details have been forthcoming, and no further
discussion has occurred - the ball is entirely in your court to
progress this issue since I requested information from you and that
is where things seem to have stalled.

The result is that, with your patch, you're locking the port to 2.5G
speeds, meaning that only 4.3Mbps Fibrechannel SFPs can be used with
the port, and it can only be used with another device that supports
2.5G speeds.  You can't use a copper RJ45 module, and you can't use
a standard 1000base-X module either in this configuration.

What I'm most concerned about, given the bindings for comphy that
have been merged, is that Free Electrons is pushing forward seemingly
with no regard to the requirement that the serdes lanes are dynamically
reconfigurable, and that's a basic requirement for SFP, and for the
88x3310 PHYs on the Macchiatobin platform.

So, my question to you is: what is Free Electrons plans to properly
support the ethernet ports on the Macchiatobin platform?


For those on the Cc list who don't know, phylink is part of full support
for SFP and SFP+ cages, sponsored (in terms of hardware including SFP
modules) by SolidRun on both SolidRun's Clearfog and Macchiatobin
platforms, supporting a wide range of SFP modules including:

- 1G Optical ethernet modules (duplex and bidi modules)
- 10/100/1G RJ45 modules
- 10G SFP+ modules
- 2.5Gbase-X using 4.3Mbps Fibrechannel modules
- Direct attach cables

There is work ongoing between Florian, Andrew and myself to switch DSA
to phylink, and have SFP modules working with both Marvell and Broadcom
DSA switches.

Phylink and SFP was already merged into mainline, and has been usable
(provided that the network driver is converted to phylink rather than
phylib) since 4.14-rc1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
