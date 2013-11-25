From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 14:42:32 -0600
Subject: [PATCH 2/3] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <1385410581-12148-3-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-3-git-send-email-w-kwok2@ti.com>
Message-ID: <20131125204232.GJ18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 03:16:20PM -0500, WingMan Kwok wrote:
> Added device tree support for TI's Keystone USB driver and updated the
> Documentation with device tree binding information.
> 
> On Keystone II platforms, we use no-op phy driver.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  .../devicetree/bindings/usb/keystone-usb.txt       |   43 ++++++++++++++++++++
>  arch/arm/boot/dts/keystone.dtsi                    |   27 ++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> new file mode 100644
> index 0000000..a67de8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> @@ -0,0 +1,43 @@
> +TI Keystone Soc USB Controller
> +
> +DWC3 GLUE
> +
> +Required properties:
> + - compatible: should be "ti,keystone-dwc3".
> + - #address-cells, #size-cells : should be '1' if the device has sub-nodes
> +   with 'reg' property.
> + - reg : Address and length of the register set for the device. First pair
> +   is the USB subsystem specific register set.  Second pair is the
> +   USB subsystem PHY control register set.
> + - interrupts : The irq number of this device that is used to interrupt the
> +   MPU.
> + - ranges: allows valid 1:1 translation between child's address space and
> +   parent's address space.
> + - clocks: Clock IDs array as required by the controller.
> + - clock-names: names of clocks correseponding to IDs in the clock property.
> +
> +Sub-nodes:
> +The dwc3 core should be added as subnode to Keystone DWC3 glue.
> +- dwc3 :
> +   The binding details of dwc3 can be found in:
> +   Documentation/devicetree/bindings/usb/dwc3.txt
> +
> +Example:
> +	usb: usb at 2680000 {
> +		compatible = "ti,keystone-dwc3";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x2680000 0x10000
> +		       0x2620738 32>;
> +		clocks = <&clkusb>;
> +		clock-names = "usb";
> +		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +		ranges;
> +
> +		dwc3 at 2690000 {
> +			compatible = "synopsys,dwc3";
> +			reg = <0x2690000 0x70000>;
> +			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +			usb-phy = <&usb2_phy>, <&usb3_phy>;
> +		};
> +	};
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index f6d6d9e..1e1049c 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -181,5 +181,32 @@
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkspi>;
>  		};
> +
> +		usb2_phy: usb2_phy {
> +			compatible = "usb-nop-xceiv";
> +		};
> +
> +		usb3_phy: usb3_phy {
> +			compatible = "usb-nop-xceiv";
> +		};

you actually have some phy registers which need to be fiddled with. I'd
suggest implementing this the same way phy-am335x.c is implemented. It
still reuses most of phy-generic.c, but it has some hooks to implement
->init() and ->shutdown(), which seem to be the only methods you need.

BTW, some preliminary TRM coming my way would be cool, so I can better
understand how this HW behaves. A board would also go a long way, so I
could test this myself (we are part of the same company anyway).

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/34301f12/attachment.sig>
