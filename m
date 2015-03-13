From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Mar 2015 15:48:40 +0100
Subject: [PATCH 7/7] common.c:105 Variable 'gephy' is  never used.
In-Reply-To: <20150313141926.GM8656@n2100.arm.linux.org.uk>
References: <1426254264-5105-1-git-send-email-ameenali023@gmail.com>
 <20150313141926.GM8656@n2100.arm.linux.org.uk>
Message-ID: <20150313144840.GA7311@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 02:19:26PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 03:44:24PM +0200, Ameen Ali wrote:
> > Variable 'gephy' is assigned a value that is never used.
> > 
> > Signed-off-by : <AmeenALi023@gmail.com>
> > ---
> >  arch/arm/mach-dove/common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> > index 0d1a892..115a413 100644
> > --- a/arch/arm/mach-dove/common.c
> > +++ b/arch/arm/mach-dove/common.c
> > @@ -113,7 +113,7 @@ static void __init dove_clk_init(void)
> >  	orion_clkdev_add(NULL, "orion_spi.1", tclk);
> >  	orion_clkdev_add(NULL, "orion_wdt", tclk);
> >  	orion_clkdev_add(NULL, "mv64xxx_i2c.0", tclk);
> > -
> > +        orion_clkdev_add(NULL,"mv643xx_eth_port.0",gephy);
> 
> NAK.  Just because some variable isn't read doesn't mean that you need
> to dream up some way to make it used.
> 
> In any case, this is wrong because it will duplicate this entry:
> 
> >  	orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);

Hi Russell

Missed that. Sorry.

What happens in the DT world is that ge clock is a child of the gephy
clock, so that when you enable the ge clock, it walks up towards the
parent and enables the gephy clock.

I don't see anything like this in the legacy Dove world. Are you just
relying on the bootloader turning on the phy and nothing turning it
off?

	Andrew
