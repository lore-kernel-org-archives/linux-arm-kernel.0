From: sean.wang@mediatek.com (Sean Wang)
Date: Sun, 15 Jul 2018 13:10:49 +0800
Subject: [PATCH v5 1/7] dt-bindings: net: bluetooth: Add mediatek-bluetooth
In-Reply-To: <7E55939D-7F8A-4832-9DD5-EFB3B19ACF0B@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d8a5b34513cf2187a2b23a513feaa358d719bc14.1531150733.git.sean.wang@mediatek.com>
 <7E55939D-7F8A-4832-9DD5-EFB3B19ACF0B@holtmann.org>
Message-ID: <1531631449.26214.28.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-07-14 at 18:26 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Add binding document for a SoC built-in device using MediaTek protocol.
> > Which could be found on MT7622 SoC or other similar MediaTek SoCs.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
> > 1 file changed, 35 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > new file mode 100644
> > index 0000000..1335429
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > @@ -0,0 +1,35 @@
> > +MediaTek SoC built-in Bluetooth Devices
> > +==================================
> > +
> > +This device is a serial attached device to BTIF device and thus it must be a
> > +child node of the serial node with BTIF. The dt-bindings details for BTIF
> > +device can be known via Documentation/devicetree/bindings/serial/8250.txt.
> > +
> > +Required properties:
> > +
> > +- compatible:	Must be one of
> > +		  "mediatek,mt7622-bluetooth"": for MT7622 SoC
> 
> this does not match with the example below. And one of, should be normally be a list.
> 

Thanks! I'll remove the words "one of" from the compatible description,
and the extra " being added accidentally.

And the below example fully shows the bluetooth device and its attached
bus (mediatek,mt7622-btif) to let people know clearly how to enable the
bluetooth device.

The current document just describes the bluetooth device and as for the
attached bus, it is already present at
Documentation/devicetree/bindings/serial/8250.txt.

	Sean


> > +- clocks:	Should be the clock specifiers corresponding to the entry in
> > +		clock-names property.
> > +- clock-names:	Should contain "ref" entries.
> > +- power-domains: Phandle to the power domain that the device is part of
> > +
> > +Example:
> > +
> > +	btif: serial at 1100c000 {
> > +		compatible = "mediatek,mt7622-btif",
> > +			     "mediatek,mtk-btif";
> > +		reg = <0 0x1100c000 0 0x1000>;
> > +		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&pericfg CLK_PERI_BTIF_PD>;
> > +		clock-names = "main";
> > +		reg-shift = <2>;
> > +		reg-io-width = <4>;
> > +
> > +		bluetooth {
> > +			compatible = "mediatek,mt7622-bluetooth";
> > +			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
> > +			clocks = <&clk25m>;
> > +			clock-names = "ref";
> > +		};
> > +	};
> 
> Regards
> 
> Marcel
> 
