From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2018 13:08:33 +0000
Subject: [PATCH] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180306134311.7bbf8ce7@bbrezillon>
References: <20180228143553.12485-1-gregory.clement@bootlin.com>
 <20180301183520.4251439a@bbrezillon> <874llt5ut2.fsf@bootlin.com>
 <20180306134311.7bbf8ce7@bbrezillon>
Message-ID: <20180306130833.GJ9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 01:43:11PM +0100, Boris Brezillon wrote:
> Hi Greg,
> 
> On Tue, 06 Mar 2018 12:04:41 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> 
> > Hi Boris,
> >  
> >  On jeu., mars 01 2018, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > 
> > > Hi Greg,
> > >
> > > On Wed, 28 Feb 2018 15:35:53 +0100
> > > Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> > >  
> > >> On Armada 7K/8K we need to explicitly enable the register clock. This
> > >> clock is optional because not all the SoCs using this IP need it but at
> > >> least for Armada 7K/8K it is actually mandatory.
> > >> 
> > >> The binding documentation is updated accordingly.
> > >> 
> > >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > >> ---
> > >>  Documentation/devicetree/bindings/mtd/marvell-nand.txt |  6 +++++-
> > >>  drivers/mtd/nand/marvell_nand.c                        | 14 ++++++++++++++
> > >>  2 files changed, 19 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > >> index c08fb477b3c6..4ee9813bf88f 100644
> > >> --- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > >> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> > >> @@ -14,7 +14,11 @@ Required properties:
> > >>  - #address-cells: shall be set to 1. Encode the NAND CS.
> > >>  - #size-cells: shall be set to 0.
> > >>  - interrupts: shall define the NAND controller interrupt.
> > >> -- clocks: shall reference the NAND controller clock.
> > >> +- clocks: shall reference the NAND controller clocks, the second one is
> > >> +  optional but needed for the Armada 7K/8K SoCs
> > >> +- clock-names: mandatory if there is a second clock, in this case the
> > >> +   name must be "core" for the first clock and "reg" for the second
> > >> +   one  
> > >
> > > Hm, not sure this is a good idea to impose a specific order. I know you  
> > 
> > It would be a problem if the use of this clock would be at dts level
> > for each board. But here we only setup this property in the dtsi at SoC
> > level. So enforcing the order is not a problem as the dtsi are all well
> > reviewed and remains pretty rare.
> 
> I'm still not convinced this is a good idea, but okay.
> 
> > 
> > > do that to avoid changing the code requesting the core clk, but I'd
> > > prefer to have a solution where we first search for a clock named
> > > "core" (devm_clk_get(&pdev->dev, "core")), and if it's missing,
> > > fall back to devm_clk_get(&pdev->dev, NULL).  
> > 
> > I really wanted to avoid adding more code only for legacy reason.
> 
> It's adding only 2 lines:
> 
> 	reg_clk = devm_clk_get(&pdev->dev, "core");
> 	if (IS_ERR(reg_clk) && PTR_ERR(reg_clk) == -ENOENT)
> 		reg_clk = devm_clk_get(&pdev->dev, NULL);

	reg_clk = devm_clk_get(&pdev->dev, "core");
	if (reg_clk == ERR_PTR(-ENOENT))
		reg_clk = devm_clk_get(&pdev->dev, NULL);

is simpler and easier to read?

> 
> > 
> > >
> > > Another solution would be to retrieve the reg clk only on platforms
> > > that need it (based on the compatible). This way you won't have to test
> > > for -ENOENT and could simply propagate the error to the upper layer.  
> > 
> > We can't do this because we need to be bacwkard compatible.
> 
> I don't get it. If the clock is missing in the DT, the NAND is
> already not working on these platforms, right? How could we break
> something that is already broken?
> 
> Regards,
> 
> Boris
> 
> -- 
> Boris Brezillon, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
