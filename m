From: bhaskar.upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 1 Dec 2017 18:40:44 +0000
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <20171130185300.GG10595@n2100.armlinux.org.uk>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
 <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
 <20171130174127.GA28828@lunn.ch>
 <20171130181520.GF10595@n2100.armlinux.org.uk>
 <20171130182621.GC28828@lunn.ch>
 <20171130185300.GG10595@n2100.armlinux.org.uk>
Message-ID: <AM3PR04MB449A2C7FDF78431360961E48C390@AM3PR04MB449.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
>Sent: Friday, December 01, 2017 12:23 AM
>To: Andrew Lunn <andrew@lunn.ch>
>Cc: Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>; netdev at vger.kernel.org;
>davem at davemloft.net; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
>
>On Thu, Nov 30, 2017 at 07:26:21PM +0100, Andrew Lunn wrote:
>> On Thu, Nov 30, 2017 at 06:15:20PM +0000, Russell King - ARM Linux wrote:
>> > On Thu, Nov 30, 2017 at 06:41:27PM +0100, Andrew Lunn wrote:
>> > > SGMII supports passing auto-negotiation results from the PHY to
>> > > the MAC. 1000BASE-X does not.
>> > >
>> > > SGMII supports the PHY running at 10, 100, and 1000 Mbps. But to
>> > > support this, the MAC needs to replicate the bits 100, or 10 times
>> > > when the PHY is running in 10 or 100Mbps mode.
>> > >
>> > > So with your 2.5G SGMII, you need to replicate the bits 250, 25,
>> > > or
>> > > 2.5 times if they PHY is running at lower speeds. This last one is
>> > > interesting.
>> >
>> > That's not what I've read so far - but I don't know about the PHY in
>> > this exact case because the docs are only available under NDA (which
>> > makes it incredibly difficult to have this discussion.)
>> >
>> > However, from what I can ascertain from a Xilinx document, 2.5G is
>> > 1G SGMII clocked 2.5x faster.  When in 2.5G mode, the other modes
>> > are unavailable.
>>
>> Hi Russell
>>
>> Thanks for looking into the details.
>>
>> So you need the PHY driver to see what it has negotiated, and when it
>> calls the adjust_link callback, the MAC needs look at the
>> phydev->interface and set the MAC to 2.5G SGMII or SGMII.
>
>Yes, it /looks/ that way from what I've read so far.  I'd like to do a more
>comprehensive look around at what various manufacturers are doing before
>saying that definitively.  Even better would be to find a specification for 2.5G
>SGMII!
>
>> Same as the Marvell 10G PHY driver flips between
>> PHY_INTERFACE_MODE_10GKR and PHY_INTERFACE_MODE_SGMII depending
>on
>> what it has negotiated.
>
>Having played extensively with the Marvell 88x3310 and thoroughly inspected its
>registers and analysed its behaviour, I'd be hessitant to compare other PHYs with
>it.  The 3310 PHY seems to be multiple PHY blocks (from two vendors) in a single
>package, and it dynamically switches in the appropriate hardware blocks
>according to the negotiated link modes.
>
>However, given that 1G SGMII is clocked at a different rate from 2.5G SGMII,
>both ends would need to be configured the same.
>
>For example, both mvneta and mvpp2.2 support 2.5G modes merely by
>reconfiguring the comphy block, and all that does is increase the serdes clock.
>That's used for 2500BASE-X (which I have had working locally through a devmem2
>pokes on Clearfog and the older Marvell pp2x driver on Macchiatobin) but it's
>more difficult to find 2.5G copper SFP modules to test with - which would
>presumably talk 2.5G SGMII.

So do we need to introduce a new interface type PHY_INTERFACE_MODE_2500SGMII or is there a way to deal with 2.5G SGMII ?

>
>--
>RMK's Patch system:
>https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.ar
>mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=02%7C01%7Cbhaskar.upadha
>ya%40nxp.com%7C6ed1aa95e2844f1f316008d538239cf6%7C686ea1d3bc2b4c6f
>a92cd99c5c301635%7C0%7C0%7C636476647969399947&sdata=z35Urdlslv7Cdq
>hmj6JUd48QyXrwjzrldIoFP9TEA6E%3D&reserved=0
>FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
>According to speedtest.net: 8.21Mbps down 510kbps up
