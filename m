From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 17 Jul 2018 19:55:32 +0900
Subject: [PATCH 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3
 PHY driver
In-Reply-To: <20180716205049.GA3663@rob-hp-laptop>
References: <1530261541-23104-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20180716205049.GA3663@rob-hp-laptop>
Message-ID: <20180717195531.8587.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
Thank you for your comments.

On Mon, 16 Jul 2018 14:50:49 -0600 <robh@kernel.org> wrote:

> On Fri, Jun 29, 2018 at 05:38:58PM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PHY interface built into USB3 controller
> > implemented in UniPhier SoCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 +++++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > new file mode 100644
> > index 0000000..3df4a486
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
> > @@ -0,0 +1,118 @@
> > +Socionext UniPhier USB3 PHY
> > +
> > +This describes the devicetree bindings for PHY interfaces built into
> > +USB3 controller implemented on Socionext UniPhier SoCs.
> > +The controller includes High-Speed PHY and Super-Speed PHY.
> > +
> > +USB3 High-Speed (HS) PHY
> > +------------------------
> > +
> > +Required properties:
> > +- compatible: Should contain one of the following:
> > +    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
> > +    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
> > +    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
> > +    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
> > +- reg: Specifies offset and length of the register set for the device.
> > +- #phy-cells: Should be 0.
> > +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> > +	According to the clock-names, appropriate clocks are required.
> > +- clock-names: Should contain the following:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> > +    "link", "phy" - for others
> 
> Can't you make 'link' always first.

I see. I'll change the order.

> > +- resets: A list of phandles to the reset control for USB3 glue layer.
> > +	According to the reset-names, appropriate resets are required.
> > +- reset-names: Should contain the following:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy" - for others
> > +
> > +Optional properties:
> > +- phy-supply: A phandle to the regulator for USB VBUS.
> 
> The phy actually needs Vbus or you just want to control Vbus from the 
> phy driver?

To enable each USB port correspond with phy, we must enable Vbus for each port.
However, the host driver doesn't have the way to control regulators directly,
then I think it is reasonable to control Vbus by using phy regulator.


> > +- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
> > +	Available only for HS-PHY implemented on LD20 and PXs3, and
> > +	if unspecified, default value is used.
> > +- nvmem-cell-names: Should be the following names, which correspond to
> > +	each nvmem-cells.
> > +	All of the 3 parameters associated with the following names are
> > +	required for each port, if any one is omitted, the trimming data
> > +	of the port will not be set at all.
> > +    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +
> > +Example:
> > +
> > +	usb-glue at 65b00000 {
> > +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> > +			     "simple-mfd";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x65b00000 0x400>;
> > +
> > +		usb_hsphy0: hs-phy at 200 {
> > +			compatible = "socionext,uniphier-ld20-usb3-hsphy";
> > +			reg = <0x200 0x10>;
> > +			#phy-cells = <0>;
> > +			clock-names = "link", "phy";
> > +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> > +			reset-names = "link", "phy";
> > +			resets = <&sys_rst 14>, <&sys_rst 16>;
> > +			phy-supply = <&usb_vbus0>;
> > +			nvmem-cell-names = "rterm", "sel_t", "hs_i";
> > +			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
> > +				      <&usb_hs_i0>;
> > +		};
> > +	};
> > +
> > +
> > +USB3 Super-Speed (SS) PHY
> > +-------------------------
> 
> Nothing seems to be shared here. Make this 2 docs.

I see. I'll split it.

> 
> > +
> > +Required properties:
> > +- compatible: Should contain one of the following:
> > +    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
> > +    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
> > +    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
> > +    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
> > +- reg: Specifies offset and length of the register set for the device.
> > +- #phy-cells: Should be 0.
> > +- clocks: A list of phandles to the clock gate for USB3 glue layer.
> > +	According to the clock-names, appropriate clocks are required.
> > +- clock-names:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy", "phy-ext" - for PXs3 SoC, "phy-ext" is optional.
> > +    "link", "phy" - for others
> 
> Can't you make 'link' always first.

ditto.

> > +- resets: A list of phandles to the reset control for USB3 glue layer.
> > +	According to the reset-names, appropriate resets are required.
> > +- reset-names:
> > +    "gio", "link" - for Pro4 SoC
> > +    "link", "phy" - for others
> 
> And here.
> 
> > +
> > +Optional properties:
> > +- phy-supply: A phandle to the regulator for USB VBUS.
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +
> > +Example:
> > +
> > +	usb-glue at 65b00000 {
> > +		compatible = "socionext,uniphier-ld20-dwc3-glue",
> > +			     "simple-mfd";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x65b00000 0x400>;
> > +
> > +		usb_ssphy0: ss-phy at 300 {
> > +			compatible = "socionext,uniphier-ld20-usb3-ssphy";
> > +			reg = <0x300 0x10>;
> > +			#phy-cells = <0>;
> > +			clock-names = "link", "phy";
> > +			clocks = <&sys_clk 14>, <&sys_clk 16>;
> > +			reset-names = "link", "phy";
> > +			resets = <&sys_rst 14>, <&sys_rst 16>;
> > +			phy-supply = <&usb_vbus0>;
> > +		};
> > +
> > +		other nodes ...
> > +	};
> > -- 
> > 2.7.4
> > 

Thank you,

---
Best Regards,
Kunihiko Hayashi
