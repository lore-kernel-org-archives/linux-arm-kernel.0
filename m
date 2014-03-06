From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Mar 2014 15:21:17 +0100
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <5318779C.8030901@free-electrons.com>
References: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
 <20140306131429.GJ4780@lunn.ch>
 <5318779C.8030901@free-electrons.com>
Message-ID: <20140306142117.GL4780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Gregory
> > 
> > I guess checkpatch.pl is probably complaining about missing vendor
> > prefix?
> > 
> 
> yes and also about m25p128 itself because it was not explicitly written
> in Documentation/devicetree/bindings/. Actually it was written to "see the
> "m25p_ids" table in drivers/mtd/devices/m25p80.c for the list of" the compatible
> name.
> 
> For the first warning I can add the vendor part, but for the other warning, do we
> really want to copy the m25p_ids table in Documentation/devicetree/bindings/mtd/m25p80.txt ?

I think the DT Maintainers and checkpatch.pl maintainers need to think
about this. Maybe a regex would be enough in
Documentation/devicetree/bindings/mtd/m25p80.txt?

For the moment i would suggest adding a vendor prefix, but nothing
more.


> >> +			/*
> >> +			 * The Ethernet nodes are not ordered by
> >> +			 * address on purpose. Indeed the first
> >> +			 * Ethernet port of the board (Giga0) is
> >> +			 * located at 0x70000 whereas the the second
> >> +			 * Ethernet(Giga 1) port is located at
> >> +			 * 0x30000.
> >> +			 */
> >> +
> >> +			ethernet at 70000 {
> >> +				status = "okay";
> >> +				phy = <&phy0>;
> >> +				phy-mode = "rgmii";
> >> +			};
> >> +
> >> +			ethernet at 30000 {
> >> +				status = "okay";
> >> +				phy = <&phy1>;
> >> +				phy-mode = "rgmii";
> >> +			};
> >> +
> > 
> > I think you can use aliases to get the order correct, independent of
> > how you list them in DT. That should be a lot safer than assuming
> > things are instantiated from top to bottom.
> 
> It sounds interesting, how would you do this?

As there already is in armada-370-xp.dtsi

        aliases {
                eth0 = &eth0;
                eth1 = &eth1;
        };


	eth0: ethernet at 70000 {
	}
        eth1: ethernet at 74000 {
	}

This at least works for i2c devices. The pdev->id is set using the
alias number.

      Andrew
