From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 15:18:18 +0000
Subject: [PATCH 7/7] common.c:105 Variable 'gephy' is  never used.
In-Reply-To: <20150313144840.GA7311@lunn.ch>
References: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
 <20150313141926.GM8656@n2100.arm.linux.org.uk>
 <20150313144840.GA7311@lunn.ch>
Message-ID: <20150313151818.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:48:40PM +0100, Andrew Lunn wrote:
> On Fri, Mar 13, 2015 at 02:19:26PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Mar 13, 2015 at 03:44:24PM +0200, Ameen Ali wrote:
> > > Variable 'gephy' is assigned a value that is never used.
> > > 
> > > Signed-off-by : <AmeenALi023@gmail.com>
> > > ---
> > >  arch/arm/mach-dove/common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> > > index 0d1a892..115a413 100644
> > > --- a/arch/arm/mach-dove/common.c
> > > +++ b/arch/arm/mach-dove/common.c
> > > @@ -113,7 +113,7 @@ static void __init dove_clk_init(void)
> > >  	orion_clkdev_add(NULL, "orion_spi.1", tclk);
> > >  	orion_clkdev_add(NULL, "orion_wdt", tclk);
> > >  	orion_clkdev_add(NULL, "mv64xxx_i2c.0", tclk);
> > > -
> > > +        orion_clkdev_add(NULL,"mv643xx_eth_port.0",gephy);
> > 
> > NAK.  Just because some variable isn't read doesn't mean that you need
> > to dream up some way to make it used.
> > 
> > In any case, this is wrong because it will duplicate this entry:
> > 
> > >  	orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);
> 
> Hi Russell
> 
> Missed that. Sorry.
> 
> What happens in the DT world is that ge clock is a child of the gephy
> clock, so that when you enable the ge clock, it walks up towards the
> parent and enables the gephy clock.
> 
> I don't see anything like this in the legacy Dove world. Are you just
> relying on the bootloader turning on the phy and nothing turning it
> off?

See, this is why I hate these trivial patches - they waste people's time
and create a load of unnecessary confusion where there's absolutely none
needed.

Here's the legacy code:

        gephy = dove_register_gate("gephy", "tclk", CLOCK_GATING_BIT_GIGA_PHY);

Here, we have a gate controlled by the CLOCK_GATING_BIT_GIGA_PHY bit
between the tclk, and gephy clock.  This is immediately followed by:

        ge = dove_register_gate("ge", "gephy", CLOCK_GATING_BIT_GBE);

which is a gate controlled by the CLOCK_GATING_BIT_GBE bit between the
gephy clock and the ge clock.  This second clock is then registered for
use by the ethernet device:

        orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);

If we look at clk_summary, we see:

 tclk                                    12           12   166666667          0 0
    gephy                                 1            1   166666667          0 0
       ge                                 1            1   166666667          0 0

which is the same relationship as in DT:

 tclk                                    13           13   166666667          0 0
    gephy                                 1            1   166666667          0 0
       ge                                 2            2   166666667          0 0

There is no problem here; this has been a complete waste of our time
while we discuss this non-problem.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
