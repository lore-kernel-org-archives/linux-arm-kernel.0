From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 21 Feb 2017 17:44:20 +0100
Subject: [PATCH v4 3/3] PCI: imx6: Add code to support i.MX7D
In-Reply-To: <CAL_Jsq+zo9cVEiT3p4oEL8UWqHNEVqszkC3htO-p+C2oFXPuSw@mail.gmail.com>
References: <20170207155027.7734-1-andrew.smirnov@gmail.com>
 <20170207155027.7734-4-andrew.smirnov@gmail.com>
 <20170215171700.5vz5seeihgtwn76p@rob-hp-laptop>
 <1487236340.13536.5.camel@pengutronix.de>
 <CAL_Jsq+zo9cVEiT3p4oEL8UWqHNEVqszkC3htO-p+C2oFXPuSw@mail.gmail.com>
Message-ID: <1487695460.2268.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 21.02.2017, 10:38 -0600 schrieb Rob Herring:
> On Thu, Feb 16, 2017 at 3:12 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Mittwoch, den 15.02.2017, 11:17 -0600 schrieb Rob Herring:
> >> On Tue, Feb 07, 2017 at 07:50:27AM -0800, Andrey Smirnov wrote:
> >> > Add various bits of code needed to support i.MX7D variant of the IP.
> >> >
> >> > Cc: yurovsky at gmail.com
> >> > Cc: Lucas Stach <l.stach@pengutronix.de>
> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> > Cc: Rob Herring <robh+dt@kernel.org>
> >> > Cc: Mark Rutland <mark.rutland@arm.com>
> >> > Cc: Lee Jones <lee.jones@linaro.org>
> >> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >> > Cc: linux-arm-kernel at lists.infradead.org
> >> > Cc: devicetree at vger.kernel.org
> >> > Cc: linux-kernel at vger.kernel.org
> >> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> > ---
> >> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 ++-
> >> >  drivers/pci/host/pci-imx6.c                        | 121 ++++++++++++++++-----
> >> >  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
> >> >  3 files changed, 112 insertions(+), 26 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> > index 83aeb1f..11db2ab 100644
> >> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> > @@ -4,7 +4,11 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
> >> >  and thus inherits all the common properties defined in designware-pcie.txt.
> >> >
> >> >  Required properties:
> >> > -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
> >> > +- compatible:
> >> > +   - "fsl,imx6q-pcie"
> >> > +   - "fsl,imx6sx-pcie",
> >> > +   - "fsl,imx6qp-pcie"
> >> > +   - "fsl,imx7d-pcie"
> >> >  - reg: base address and length of the PCIe controller
> >> >  - interrupts: A list of interrupt outputs of the controller. Must contain an
> >> >    entry for each entry in the interrupt-names property.
> >> > @@ -34,6 +38,13 @@ Additional required properties for imx6sx-pcie:
> >> >  - clock names: Must include the following additional entries:
> >> >     - "pcie_inbound_axi"
> >> >
> >> > +Additional required properties for imx7d-pcie:
> >> > +- power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
> >>
> >> This domain is just the PHY? Seems like this needs a separate PHY
> >> driver.
> >>
> > No, it's called the PHY power domain, as that is probably the part that
> > draws the most power, but the PCIe core also looses it's state when this
> > domain is powered down. So it's probably the complete core that is
> > inside this domain.
> 
> A shared domain doesn't mean the phy and core should be 1 node. It is
> the separate reset and clock for the PHY that tell me they should be
> separate. And I'm pretty sure the DW block and PHY are separate. If
> the PHY registers were part of the same register range, then I'd say
> they should be one.

Then we are on the same page of _not_ splitting out the PHY. :)
The DW PCIe PHY has no separate register range on i.MX. In fact the PHY
registers are only accessible through a indirection register in the PCIe
host controller register range.

Regards,
Lucas
