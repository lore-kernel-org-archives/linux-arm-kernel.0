From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 15:41:46 -0700
Subject: DSA: phy polling
In-Reply-To: <20150914182314.GP21084@n2100.arm.linux.org.uk>
References: <20150914104254.GI21084@n2100.arm.linux.org.uk>
 <55F703D7.1070707@gmail.com> <20150914182314.GP21084@n2100.arm.linux.org.uk>
Message-ID: <55F74D2A.8010104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 11:23, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2015 at 10:28:55AM -0700, Florian Fainelli wrote:
>> Just my 2 cents here, I suspect the original intention behind this code
>> was to help utilize the switch's built-in PHY polling unit when
>> available, and use the HW to collect the state of all PHYs in fewer
>> register to read, instead of having to do individual (and quite possibly
>> expensive) MDIO reads towards each individual per-port PHYs (at least
>> two reads per PHY to latch MII_BMSR).
> 
> Does the Marvell phy have such a register?  Looking at the register
> dump and plugging/unplugging cables seems not to show a register
> reporting whether any particular interface has changed state, and
> I haven't noticed there being any combined register in anything I've
> seen on these switches.

It seemed to me like the PPU was meant to provide that, but I cannot
find any "summary" register which would give you such a status, must
have conflated that with what Broadcom switches support.

> 
>> Now, I do agree there is a duplication of functionality here, and a
>> potential fix would be to avoid starting the PHY state machine if/when
>> the switch supports such a feature (not call phy_start*), that should
>> still get you consistent consistent link partner advertised/status
>> values, question is, does that really benefit anybody though?
> 
> I disagree - it's the DSA polling that needs to go.  The DSA polling
> only looks at the port status, and derives from it the carrier
> state.  The rest of the information is only turned into a printk().
> The PHY state machine does a lot more, recording the link speed so
> that ethtool works on the interface.

I am fine with that approach, it was not exactly clear to me before
reading the code whether the link polling workqueue was doing anything
useful in mv88e6xxx.c, now it is pretty clear to me, this is as
expensive (more actually because of the PPU get/put) and useless since
the PHY library directly polls the individual per-port PHYs.

> 
> If we do want to go the other way, then the phy code needs a rework so
> that it can be properly classed and drivers with non-standard MII
> registers supported without needing to build register emulation layers.
> 

That part is going to be challenging, all the ethtool/PHY library/MII
code is built around the assumption of translating user-configurable
settings into standard MII calls (all the adv_to* etc.), but, then
again, MII is just one possible translation layer here, you could "plug"
another one if your HW supports that (e.g: non-MDIO, but MMIO for
instance which understands basic concepts like speed/link/duplex/pause).

Oh well.
-- 
Florian
