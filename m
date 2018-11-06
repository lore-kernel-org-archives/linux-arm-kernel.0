From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Nov 2018 11:19:53 +0000
Subject: [PATCH] PCI: imx: Add imx6sx suspend/resume support
In-Reply-To: <1541066574.3593.1.camel@pengutronix.de>
References: <e57884e2dbc429918db81662ddbafe22c472385c.1539019758.git.leonard.crestez@nxp.com>
 <AM0PR04MB42907F7BFDBF9648381DED49EECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
 <1541066574.3593.1.camel@pengutronix.de>
Message-ID: <50557a2f8b265d74734a6fbda79a5c4ef6b33038.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-01 at 11:02 +0100, Philipp Zabel wrote:
> Hi Leonard,
> 
> On Wed, 2018-10-31 at 11:02 +0000, Leonard Crestez wrote:
> > On 10/8/2018 8:38 PM, Leonard Crestez wrote:
> > > Enable PCI suspend/resume support on imx6sx socs. This is similar to
> > > imx7d with a few differences:
> > > 
> > > * The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other
> > > pcie control bits on 6sx.
> > > * The pcie_inbound_axi clk needs to be turned off in suspend. On resume
> > > it is restored via resume -> deassert_core_reset -> enable_ref_clk.
> > > 
> > > Most of the resume logic is shared with the initial reset after probe.

> > > +	/*
> > > +	 * Some variants have a turnoff reset in DT while
> > > +	 * others poke at iomuxc registers.
> > > +	 */
> > > +	if (imx6_pcie->turnoff_reset) {
> > > +		reset_control_assert(imx6_pcie->turnoff_reset);
> > > +		reset_control_deassert(imx6_pcie->turnoff_reset);
> > > +	} else if (imx6_pcie->variant == IMX6SX) {
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> > > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > +				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> > > +	} else {
> > > +		dev_err(dev, "PME_Turn_Off not implemented\n");
> > > +		return;
> > > +	}
> 
> I'd use switch(imx6_pcie->variant) for consistency with the other places
> where different variants need to be handled separately.

Yes, this makes sense. But the only thing handle as a variant here
would be 6sx itself, for 7d if (imx6_pcie->turnoff_reset) still makes
sense.

This driver has quite a lot of long functions with switch statements,
maybe some day it should be converted to use a per-soc ops structure?

> > > @@ -790,22 +807,35 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> > >   {
> > >   	clk_disable_unprepare(imx6_pcie->pcie);
> > >   	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > >   	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > >   
> > > -	if (imx6_pcie->variant == IMX7D) {
> > > +	switch (imx6_pcie->variant) {
> > > +	case IMX6SX:
> > > +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > +		break;
> > > +	case IMX7D:
> > >   		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > >   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > >   				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > +		break;
> > > +	default:
> > > +		break;
> > >   	}
> 
> This disables the ref clock. Should this be split into a separate
> function imx6_pcie_disable_ref_clk() for symmetry with the already
> existing imx6_pcie_enable_ref_clk() ?

Not sure. The symmetry would be limited because enabling requirements
are more stringent than shutdown.

For example the mirror operation on imx7d is done in init_phy instead
of enable_ref_clk. I didn't test but I expect that moving refclk
selection around might violate HW init sequencing requirements so I'd
rather not poke at this.

> That could then also be used to disable pcie_inbound_axi in the error
> path of imx6_pcie_deassert_core_reset().

Not sure, clock disabling on error is also complicated.

In imx6_pcie_deassert_core_reset there is no error path after
enable_ref_clk so there would be nowhere to call disable_ref_clk
outside suspend. In theory imx7d phy pll could fail to lock but we just
print something instead of propagating the error.

If imx6_pcie_establish_link fails clocks could be turned off. It makes
sense to save power if no pcie card is inserted, right? This is what
the imx vendor tree does but my understanding is that this does not
pass compliance testing so I'd rather not upstream this behavior.

See https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/host/pci-imx6.c?h=imx_4.9.88_2.0.0_ga#n1378

Cutting power if the pci slot is empty seems worthwhile but browsing
through other dwc-pci implementations and they don't seem to do this
either.

Instead clocks should stay on if link fails, I guess this is a
requirement for hotplug?

--
Regards,
Leonard
