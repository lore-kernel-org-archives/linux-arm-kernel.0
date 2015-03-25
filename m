From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 26 Mar 2015 03:46:58 +0530
Subject: [PATCH v1 2/3] Phy: DT binding documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <1426886727-537-3-git-send-email-arun.ramamurthy@broadcom.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426886727-537-3-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <551333DA.6080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
> Broadcom's Cygnus chip has a USB 2.0 host controller connected to
> three separate phys. One of the phs (port 2) is also connectd to
> a usb 2.0 device controller
> 
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> 
> ---
>  .../bindings/phy/brcm,cygnus-usb-phy.txt           | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> new file mode 100644
> index 0000000..002bd59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> @@ -0,0 +1,65 @@
> +BROADCOM CYGNUS USB PHY
> +
> +Required Properties:
> +	- compatible:  brcm,cygnus-usb-phy
> +	- reg : usbphy_regs - Base address of phy registers
> +			usb2h_idm_regs - Base address of host idm registers
> +			usb2d_idm_regs - Base address of device idm registers

where is #phy-cells documented?
> +The node that uses the phy must provide one integers, 0 for device and 1 for host

> +
> +NOTE: port 0 and port 1 are host only and port 2 can be configured for host or device.
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
> +		phy-names = "usb","usb","usb";

is it on purpose you use the same name for phy-names? it is wrong though.
> +		status = "okay";
> +	};
> +
> +	/* This node declares port 2 phy
> +	and configures it for device */

please use standard multi-line comment format.

Thanks
Kishon
