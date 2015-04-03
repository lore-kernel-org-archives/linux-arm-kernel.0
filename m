From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 3 Apr 2015 19:37:12 +0530
Subject: [PATCH v2 2/3] Phy: DT binding documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <1427921457-18235-3-git-send-email-arun.ramamurthy@broadcom.com>
References: <1427921457-18235-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1427921457-18235-3-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <551E9E90.3080406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 02 April 2015 02:20 AM, Arun Ramamurthy wrote:
> Broadcom's Cygnus chip has a USB 2.0 host controller connected to
> three separate phys. One of the phs (port 2) is also connectd to
> a usb 2.0 device controller
>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   .../bindings/phy/brcm,cygnus-usb-phy.txt           | 69 ++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> new file mode 100644
> index 0000000..d1a9a65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> @@ -0,0 +1,69 @@
> +BROADCOM CYGNUS USB PHY
> +
> +Required Properties:
> +	- compatible:  brcm,cygnus-usb-phy
> +	- reg : usbphy_regs - Base address of phy registers
> +			usb2h_idm_regs - Base address of host idm registers
> +			usb2d_idm_regs - Base address of device idm registers
> +	- phy-cells - must be 1 for each port declared. This is because the node
> +		      that uses the phy must provide one integers, 0 for device
> +		      and 1 for host

Try to define standard constants in include/dt-bindings/phy/phy.h
> +
> +NOTE: port 0 and port 1 are host only and port 2 can be configured for host or
> +device.
> +
> +Example of phy :
> +	usbphy0: usbphy at 0x0301c000 {
> +		compatible = "brcm,cygnus-usb-phy";
> +		reg = <0x0301c000 0x2000>,
> +		      <0x18115000 0x1000>,
> +		      <0x18111000 0x1000>;
> +		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		usbphy0_0: usbphy0 at 0 {
> +			#phy-cells = <1>;
> +			reg = <0>;
> +			status = "okay";
> +			phy-supply = <&vbus_p0>;
> +		};
> +
> +		usbphy0_1: usbphy0 at 1 {
> +			#phy-cells = <1>;
> +			reg = <1>;
> +			status = "okay";
> +		};
> +
> +		usbphy0_2: usbphy0 at 2 {
> +			#phy-cells = <1>;
> +			reg = <2>;
> +			status = "okay";
> +			phy-supply = <&vbus_p2>;
> +		};
> +	};
> +
> +Example of node using the phy:
> +
> +	/* This nodes declares all three ports as host */
> +
> +	ehci0: usb at 0x18048000 {
> +		compatible = "generic-ehci";
> +		reg = <0x18048000 0x100>;
> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&usbphy0_0 1 &usbphy0_1 1 &usbphy0_2 1>;

And use the constants here instead of numbers.

Regards
Kishon
