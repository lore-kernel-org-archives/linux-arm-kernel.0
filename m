From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jan 2013 14:38:40 -0500
Subject: [PATCH V3 7/8] mv643xx.c: Add basic device tree support.
In-Reply-To: <20130128101249.GB7754@e106331-lin.cambridge.arm.com>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <d2db6ddfddf90dd79c6c6c90a6006887076dea1a.1359146831.git.jason@lakedaemon.net>
 <20130128101249.GB7754@e106331-lin.cambridge.arm.com>
Message-ID: <20130128193840.GK1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 10:12:49AM +0000, Mark Rutland wrote:
> Hello,
> 
> I've taken a quick look at this, and I have a couple of comments on the binding
> and the way it's parsed.
> 
> On Fri, Jan 25, 2013 at 08:53:59PM +0000, Jason Cooper wrote:
> > From: Ian Molton <ian.molton@codethink.co.uk>
> > 
> >     This patch adds basic device tree support to the mv643xx ethernet driver.
> > 
> >     It should be enough for most current users of the device, and should allow
> >     a painless migration.
> > 
> >     Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  Documentation/devicetree/bindings/net/mv643xx.txt | 75 ++++++++++++++++++
> >  drivers/net/ethernet/marvell/mv643xx_eth.c        | 93 +++++++++++++++++++++--
> >  2 files changed, 161 insertions(+), 7 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/mv643xx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mv643xx.txt b/Documentation/devicetree/bindings/net/mv643xx.txt
> > new file mode 100644
> > index 0000000..2727f798
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mv643xx.txt
> > @@ -0,0 +1,75 @@
> > +mv643xx related nodes.
> > +
> > +marvell,mdio-mv643xx:
> > +
> > +Required properties:
> > +
> > + - interrupts : <a> where a is the SMI interrupt number.
> > + - reg : the base address and size of the controllers register space.
> > +
> > +Optional properties:
> > + - shared_smi : on some chips, the second PHY is "shared", meaning it is
> > +	really accessed via the first SMI controller. It is passed in this
> > +	way due to the present structure of the driver, which requires the
> > +	base address for the MAC to be passed in via the SMI controllers
> > +	platform data.
> 
> The phrase "the present structure of the driver" is not something that's
> generally good to hear in a binding document. Is shared_smi always going to be
> required for such configurations, or is there going to be any driver rework
> that makes it irrelevant?

Florian is working on bring mvmdio up to speed, I'll let him comment on
this.

> > + - tx_csum_limit : on some devices, this option is required for proper
> > +	operation wrt. jumbo frames.
> 
> This doesn't explain what this property is. Also "limit" doesn't describe
> what's limited (e.g. size, rate). How about something like
> max-tx-checksum-size?

sounds better, I'll update for the next version.

> 
> > +
> > +
> > +Example:
> > +
> > +smi0: mdio at 72000 {
> > +	compatible = "marvell,mdio-mv643xx";
> > +	reg = <0x72000 0x4000>;
> > +	interrupts = <46>;
> > +	tx_csum_limit = <1600>;
> > +	status = "disabled";
> > +};
> > +
> > +smi1: mdio at 76000 {
> > +	compatible = "marvell,mdio-mv643xx";
> > +	reg = <0x76000 0x4000>;
> > +	interrupts = <47>;
> > +	shared_smi = <&smi0>;
> > +	tx_csum_limit = <1600>;
> > +	status = "disabled";
> > +};
> > +
> > +
> > +
> > +marvell,mv643xx-eth:
> > +
> > +Required properties:
> > + - interrupts : the port interrupt number.
> > + - mdio : phandle of the smi device as drescribed above
> > +
> > +Optional properties:
> > + - port_number : the port number on this bus.
> > + - phy_addr : the PHY address.
> > + - reg : should match the mdio reg this device is attached to.
> > +	this is a required hack for now due to the way the
> > +	driver is constructed. This allows the device clock to be
> > +	kept running so that the MAC is not lost after boot.
> 
> More s/_/-/ candidates.

ok.

> Is there any reason to have "phy_addr" rather than "phy_address"? We already
> have #address-cells, which would seem to have set a precedent for naming.

Well, we also have "reg", which would seem to indicate the opposite.  And,
following your logic, we should really say "physical_address" :-P .  I
personally feel "phy_addr" is well understood, but I don't have a strong
opinion on it.

> 
> [...]
> 
> > @@ -2610,6 +2613,26 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
> >  	if (msp->base == NULL)
> >  		goto out_free;
> >  
> > +	if (pdev->dev.of_node) {
> > +		struct device_node *np = NULL;
> > +
> > +		/* when all users of this driver use FDT, we can remove this */
> > +		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > +		if (!pd) {
> > +			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
> > +			goto out_free;
> > +		}
> > +
> > +		of_property_read_u32(pdev->dev.of_node,
> > +			"tx_csum_limit", &pd->tx_csum_limit);
> 
> Is there any upper limit on what this property could be? It would be nice to
> have a sanity check.
> 
> Also, of_property_read_u32 reads a u32, but pd->tx_csum_limit is an int. It
> would be good to use a u32 temporary.

Good catch, I'll update for both.

> 
> [...]
> 
> > @@ -2858,7 +2893,36 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	int err;
> >  
> > -	pd = pdev->dev.platform_data;
> > +	if (pdev->dev.of_node) {
> > +		struct device_node *np = NULL;
> > +
> > +		/* when all users of this driver use FDT, we can remove this */
> > +		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > +		if (!pd) {
> > +			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
> > +			return -ENOMEM;
> > +		}
> > +
> > +		of_property_read_u32(pdev->dev.of_node,
> > +			"port_number", &pd->port_number);
> > +
> > +		if (!of_property_read_u32(pdev->dev.of_node,
> > +				"phy_addr", &pd->phy_addr))
> > +			pd->phy_addr = MV643XX_ETH_PHY_ADDR(pd->phy_addr);
> 
> From a cursory glance at mv643xx_eth.c, it looks like phy_addr needs to be in
> the range 0 to 0x1f. It might be worth a sanity check here (even if it just
> prints a warning).

right, this had been commented elsewhere.  phy_addr is XORd with 0x80,
so I'll correct my subsequent patch adding the DT entries and add the
warning here.

Thanks for the review,

Jason.
