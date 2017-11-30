From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Nov 2017 17:33:50 +0000
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <20171130155050.GD7483@lunn.ch>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
Message-ID: <20171130173350.GE10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:50:50PM +0100, Andrew Lunn wrote:
> On Thu, Nov 30, 2017 at 10:00:35AM +0530, Bhaskar Upadhaya wrote:
> > Add 2.5G SGMII interface mode(PHY_INTERFACE_MODE_2500SGMII)
> > in existing phy_interface list.As auto-negotiation is not
> > supported for 2.5G SGMII
> 
> Hi Bhaskar
> 
> I've been thinking about this some more...
> 
> Is auto negotiation not supported in 2.5G SGMII in general, or just in
> the system you are using? Is it the PHY or the MAC which does not
> support it. Are we going to get into trouble if we find an 2.5G SGMII
> link which does negotiate?

I've been doing some research on this 2.5G SGMII "thing", and what
I've found so far (from Xilinx, I haven't been able to look through
anything else yet) is that at least Xilinx do the same thing.

There's a Xilinx document (pg047-gig-eth-pcs-pma.pdf) which says
throughout that the speed bits are not applicable for 2.5G SGMII.

Speeds > 1G appear to be defined only for full duplex (since the
latency through the PHY is too great for CDMA half-duplex to work.)
So, the duplex bits in SGMII would be meaningless for >1G.  Many
MACs, incidentally, do not support half-duplex at 1G speeds either.

That just leaves pause mode in the SGMII word.

> My understanding is that one of the main differences between SGMII and
> 1000BASE-X is the negotiation.

True.  1000BASE-X is an 802.3 standard, with the configuration word
defined by IEEE.  SGMII is derived from that by Cisco, but with the
configuration word replaced by a system whereby the PHY can inform
the MAC about the results of negotiation.

SGMII has a handshake so the PHY knows that the MAC has configured
itself, and some PHYs will not pass data until that handshake has
completed.

I suspect for 2.5G SGMII, I would expect that the handshake also has
to complete, so the PHY knows that the pause modes have been properly
received by the MAC.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
