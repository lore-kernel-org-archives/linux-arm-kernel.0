From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 28 Sep 2017 09:07:10 +0200
Subject: [PATCH v6 05/11] dt-bindings: net: dwmac-sun8i: update
 documentation about integrated PHY
In-Reply-To: <25e44368-2c07-9b7e-a0d3-a2a642286e5d@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-6-clabbe.montjoie@gmail.com>
 <25e44368-2c07-9b7e-a0d3-a2a642286e5d@gmail.com>
Message-ID: <20170928070710.GA32676@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 09:53:15PM -0700, Florian Fainelli wrote:
> 
> 
> On 09/27/2017 12:34 AM, Corentin Labbe wrote:
> > This patch add documentation about the MDIO switch used on sun8i-h3-emac
> > for integrated PHY.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  .../devicetree/bindings/net/dwmac-sun8i.txt        | 138 +++++++++++++++++++--
> >  1 file changed, 126 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > index 725f3b187886..e2ef4683df08 100644
> > --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > @@ -4,18 +4,18 @@ This device is a platform glue layer for stmmac.
> >  Please see stmmac.txt for the other unchanged properties.
> >  
> >  Required properties:
> > -- compatible: should be one of the following string:
> > +- compatible: must be one of the following string:
> >  		"allwinner,sun8i-a83t-emac"
> >  		"allwinner,sun8i-h3-emac"
> >  		"allwinner,sun8i-v3s-emac"
> >  		"allwinner,sun50i-a64-emac"
> >  - reg: address and length of the register for the device.
> >  - interrupts: interrupt for the device
> > -- interrupt-names: should be "macirq"
> > +- interrupt-names: must be "macirq"
> >  - clocks: A phandle to the reference clock for this device
> > -- clock-names: should be "stmmaceth"
> > +- clock-names: must be "stmmaceth"
> >  - resets: A phandle to the reset control for this device
> > -- reset-names: should be "stmmaceth"
> > +- reset-names: must be "stmmaceth"
> >  - phy-mode: See ethernet.txt
> >  - phy-handle: See ethernet.txt
> >  - #address-cells: shall be 1
> > @@ -39,23 +39,38 @@ Optional properties for the following compatibles:
> >  - allwinner,leds-active-low: EPHY LEDs are active low
> >  
> >  Required child node of emac:
> > -- mdio bus node: should be named mdio
> > +- mdio bus node: with compatible "snps,dwmac-mdio"
> >  
> >  Required properties of the mdio node:
> >  - #address-cells: shall be 1
> >  - #size-cells: shall be 0
> >  
> > -The device node referenced by "phy" or "phy-handle" should be a child node
> > +The device node referenced by "phy" or "phy-handle" must be a child node
> >  of the mdio node. See phy.txt for the generic PHY bindings.
> >  
> > -Required properties of the phy node with the following compatibles:
> > +The following compatibles require that the mdio node have a mdio-mux child
> > +node called "mdio-mux":
> > +  - "allwinner,sun8i-h3-emac"
> > +  - "allwinner,sun8i-v3s-emac":
> > +Required properties for the mdio-mux node:
> > +  - compatible = "mdio-mux"
> > +  - one child mdio for the integrated mdio
> > +  - one child mdio for the external mdio if present (V3s have none)
> > +Required properties for the mdio-mux children node:
> > +  - reg: 1 for internal MDIO bus, 2 for external MDIO bus
> > +
> > +The following compatibles require a PHY node representing the integrated
> > +PHY, under the integrated MDIO bus node if an mdio-mux node is used:
> >    - "allwinner,sun8i-h3-emac",
> >    - "allwinner,sun8i-v3s-emac":
> > +
> > +Required properties of the integrated phy node:
> >  - clocks: a phandle to the reference clock for the EPHY
> >  - resets: a phandle to the reset control for the EPHY
> > +- phy-is-integrated
> > +- Must be a child of the integrated mdio
> >  
> > -Example:
> > -
> > +Example with integrated PHY:
> >  emac: ethernet at 1c0b000 {
> >  	compatible = "allwinner,sun8i-h3-emac";
> >  	syscon = <&syscon>;
> > @@ -72,13 +87,112 @@ emac: ethernet at 1c0b000 {
> >  	phy-handle = <&int_mii_phy>;
> >  	phy-mode = "mii";
> >  	allwinner,leds-active-low;
> > +
> > +	mdio0: mdio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "snps,dwmac-mdio";
> > +
> > +		mdio-mux {
> > +			compatible = "mdio-mux";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> Sorry for chiming in so late, but why don't we have the mdio-mux be the
> root node here in the mdio bus hierarchy? I understand that with this
> binding proposed here, we need to have patch 11 included (which btw,
> should come before any DTS change), but this does not seem to accurately
> model the HW.
> 
> The mux itself is not a child node of the MDIO bus controller, it does
> not really belong in that address space although it does mangle the MDIO
> bus controller address space between the two ends of the mux.
> 
> If this has been debated before, apologies for missing that part of the
> discussion.
> 

I have done it as asked by Rob.
https://lkml.org/lkml/2017/9/13/422
https://lkml.org/lkml/2017/9/19/849

Regards
