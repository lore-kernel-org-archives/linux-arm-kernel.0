From: george.cherian@ti.com (George Cherian)
Date: Wed, 27 Nov 2013 15:29:26 +0530
Subject: [PATCH 2/3] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <1385410581-12148-3-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-3-git-send-email-w-kwok2@ti.com>
Message-ID: <5295C27E.3010805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 1:46 AM, WingMan Kwok wrote:
> Added device tree support for TI's Keystone USB driver and updated the
> Documentation with device tree binding information.
>
> On Keystone II platforms, we use no-op phy driver.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>   .../devicetree/bindings/usb/keystone-usb.txt       |   43 ++++++++++++++++++++
>   arch/arm/boot/dts/keystone.dtsi                    |   27 ++++++++++++
>   2 files changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
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
>   			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>   			clocks = <&clkspi>;
>   		};
> +
> +		usb2_phy: usb2_phy {
> +			compatible = "usb-nop-xceiv";
> +		};
> +
> +		usb3_phy: usb3_phy {
> +			compatible = "usb-nop-xceiv";
> +		};
> +
> +		usb: usb at 2680000 {
> +			compatible = "ti,keystone-dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x2680000 0x10000
> +			       0x2620738 32>;
> +			clocks = <&clkusb>;
> +			clock-names = "usb";
> +			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;

You don't have seperate interrrupt for wrapper and core?
Is it the same interrupt shared between XHCI,DWC3 and wrapper?

> +			ranges;
> +
> +			dwc3 at 2690000 {
> +				compatible = "synopsys,dwc3";
> +				reg = <0x2690000 0x70000>;
> +				interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +			};
> +		};
>   	};
>   };


-- 
-George
