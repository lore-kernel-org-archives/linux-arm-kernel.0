From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2015 19:23:14 +0100
Subject: DSA: phy polling
In-Reply-To: <55F703D7.1070707@gmail.com>
References: <20150914104254.GI21084@n2100.arm.linux.org.uk>
 <55F703D7.1070707@gmail.com>
Message-ID: <20150914182314.GP21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 10:28:55AM -0700, Florian Fainelli wrote:
> Just my 2 cents here, I suspect the original intention behind this code
> was to help utilize the switch's built-in PHY polling unit when
> available, and use the HW to collect the state of all PHYs in fewer
> register to read, instead of having to do individual (and quite possibly
> expensive) MDIO reads towards each individual per-port PHYs (at least
> two reads per PHY to latch MII_BMSR).

Does the Marvell phy have such a register?  Looking at the register
dump and plugging/unplugging cables seems not to show a register
reporting whether any particular interface has changed state, and
I haven't noticed there being any combined register in anything I've
seen on these switches.

> Now, I do agree there is a duplication of functionality here, and a
> potential fix would be to avoid starting the PHY state machine if/when
> the switch supports such a feature (not call phy_start*), that should
> still get you consistent consistent link partner advertised/status
> values, question is, does that really benefit anybody though?

I disagree - it's the DSA polling that needs to go.  The DSA polling
only looks at the port status, and derives from it the carrier
state.  The rest of the information is only turned into a printk().
The PHY state machine does a lot more, recording the link speed so
that ethtool works on the interface.

If we do want to go the other way, then the phy code needs a rework so
that it can be properly classed and drivers with non-standard MII
registers supported without needing to build register emulation layers.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
