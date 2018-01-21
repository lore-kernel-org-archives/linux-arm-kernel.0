From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jan 2018 17:13:19 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180121102700.GF27654@lahna.fi.intel.com>
References: <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
 <20180118130026.GG32299@lunn.ch>
 <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
 <20180120195246.GC27654@lahna.fi.intel.com>
 <20180121010840.GB1217@lunn.ch>
 <20180121102700.GF27654@lahna.fi.intel.com>
Message-ID: <20180121161319.GA8017@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Right. So if you need to have some additional "parameters" with the
> connection, then I suppose you may want to go with the GenericSerialBus
> route. However, looking at the sample device tree description:
> 
>         davinci_mdio: ethernet at 5c030000 {
>                 compatible = "ti,davinci_mdio";
>                 reg = <0x5c030000 0x1000>;
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
>                 reset-delay-us = <2>;
> 
>                 ethphy0: ethernet-phy at 1 {
>                         reg = <1>;
>                 };
> 
>                 ethphy1: ethernet-phy at 3 {
>                         reg = <3>;
>                 };
>         };
> 
> would pretty much translate directly to this in ACPI if you don't need
> any additional attributes:
> 
> 	Device (ETH0) {
> 		Name (_ADR, /* PCI address of the NIC */)
> 
> 		Device (PHY0) {
> 			Name (_ADR, 1)
> 			...
> 		} 
> 
> 		Device (PHY1) {
> 			Name (_ADR, 3)
> 			...
> 		} 
> 	}
> 
> which looks pretty simple to me. You can also use _DSM and _DSD here to
> pass information (like the protocol number) for the PHY devices to Linux.

I'm not particularly worried about that simple case. Other than, i
don't want people to think that is all that is required. 

For a more full example, take a look at vf610-zii-dev-rev-b.dts. The
Freescale FEC Ethernet controller provides the base MDIO device,
mdio1. On top of this is an MDIO mux, using a few GPIO lines to
enable/disable 3 child MDIO busses. Each of these busses has an
Ethernet Switch. The Ethernet switch exports up to two MDIO busses,
and on these busses are Ethernet PHYs which are embedded inside the
switch. The Ethernet switches are also interrupt controllers, with the
PHYs having interrupt properties which point back to the interrupt
controller in the switch.

So i'm interested in an ACPI proposal which supports this board.

	   Andrew
