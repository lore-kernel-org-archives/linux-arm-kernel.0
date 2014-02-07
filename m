From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 09:31:36 -0500
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <20140207093206.GE17758@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
 <20140207012752.GO8533@titan.lakedaemon.net>
 <20140207093206.GE17758@lunn.ch>
Message-ID: <20140207143136.GV8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:32:06AM +0100, Andrew Lunn wrote:
> On Thu, Feb 06, 2014 at 08:27:52PM -0500, Jason Cooper wrote:
> > On Fri, Feb 07, 2014 at 12:42:06AM +0100, Andrew Lunn wrote:
> > > Instantiate the L2 cache from DT. Indicate in DT where the cache
> > > control register is and if write through should be made.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  .../devicetree/bindings/arm/mrvl/foroceon.txt      | 19 +++++++++
> > >  arch/arm/boot/dts/kirkwood.dtsi                    |  5 +++
> > >  arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  2 +
> > >  arch/arm/mach-kirkwood/board-dt.c                  | 15 +------
> > >  arch/arm/mm/cache-feroceon-l2.c                    | 46 ++++++++++++++++++++++
> > >  5 files changed, 73 insertions(+), 14 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> > 
> > for the next revision, please split out the dtsi changes into a separate
> > patch.
> > 
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> > > new file mode 100644
> > > index 000000000000..8058676d1476
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> > 
> > name typo.
> > 
> > > @@ -0,0 +1,19 @@
> > > +* Marvell Feroceon Cache
> > > +
> > > +Required properties:
> > > +- compatible : Should be "marvell,feroceon-kirkwood".
> > 
> > This is a little ambiguous, I'd like to see 'l2' in the compatible string.
> 
> I will take Jason's advice on naming and change this..

Ack.  (I assume you meant JasonG)

> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id feroceon_ids[] __initconst = {
> > > +	{ .compatible = "marvell,feroceon-kirkwood"},
> > > +	{}
> > > +};
> > > +
> > > +int __init feroceon_of_init(void)
> > > +{
> > > +	struct device_node *node;
> > > +	void __iomem *base;
> > > +	bool writethrough = false;
> > > +	struct resource res;
> > > +
> > > +	node = of_find_matching_node(NULL, feroceon_ids);
> > > +	if (!node) {
> > > +		pr_info("Didn't find marvell,feroceon-*, not enabling it\n");
> > > +		return -ENODEV;
> > > +	}
> > 
> > I'd prefer to fallback to hardcoded register address here.  We know
> > we're on kirkwood at this point.
> 
> We could also be on mv78xx0, sometime in the future. So we need to at
> least look at the compatible string to see what SoC we are. It is also
> rather ugly having hard coded addresses. We might as well go back to
> platform devices.

reverting to default behavior for missing dt information is an
acceptable compromise to the evolving DT landscape.  However...

> I would prefer upping this to pr_err(FW_INFO, and not falling back to
> hard coded values. This is not a fatal error, the machine continues to
> run, just a bit slower.

You are correct, and it would encourage the user to update their DT
blob.  So I'm fine with the way you have it.

thx,

Jason.
