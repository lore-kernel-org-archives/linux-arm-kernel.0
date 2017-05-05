From: robh@kernel.org (Rob Herring)
Date: Fri, 5 May 2017 15:04:45 -0500
Subject: [PATCH 1/3] dt-bindings: phy: Add documentation for NS2 USB3 PHY
In-Reply-To: <1493411381-16833-2-git-send-email-jon.mason@broadcom.com>
References: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
 <1493411381-16833-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170505200445.zjlsihpdh5yhtwpk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 04:29:39PM -0400, Jon Mason wrote:
> From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> 
> Add documentation for USB3 PHY available in NS2 SoC
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,ns2-usb3-phy.txt  | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt b/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> new file mode 100644
> index 0000000..5bb8d53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> @@ -0,0 +1,82 @@
> +Broadcom USB3 dual port phy for Northstar2 SoC
> +This is a child bus node of "brcm,mdio-mux-iproc" node.
> +
> +Required mdio bus properties:
> +- reg: MDIO Bus number for the MDIO interface
> +- #address-cells: must be 1
> +- #size-cells: must be 0
> +
> +Required PHY properties:
> +- compatible: should be "brcm,ns2-usb3-phy"
> +- reg: Phy address in the MDIO interface
> +- usb3-ctrl-syscon: handler of syscon node defining physical address
> +  of usb3 control register.
> +- usb3-phy-cfg-syscon: handler of syscon node defining physical base
> +  address and length of usb3 phy config region.
> +- usb3-rst-ctrl-syscon: handler of syscon node defining physical base
> +  address and length of idm reset control of two ports.

Can't you use the reset binding here?

> +- #phy-cells: must be 0
> +- #address-cells: must be 1
> +- #size-cells: must be 0
> +
> +Sub-nodes:
> +  Each port's PHY should be represented as a sub-node.
> +
> +Sub-nodes required properties:
> + - reg: the PHY number
> + - phy-cells: from the generic PHY bindings, must be 0
> +
> +Required usb3 control properties:
> +- compatible: should be "brcm,ns2-usb3-ctrl"
> +- reg: offset and length of the control registers
> +
> +Required usb3 phy config properties:
> +- compatible: should be "brcm,ns2-usb3-phy-cfg"
> +- reg: offset and length of the phy config registers
> +
> +Required usb3 reset control properties:
> +- compatible: should be "brcm,ns2-usb3-rst-ctrl"
> +- reg: offset and length of the reset control registers

Is there more than one or other registers besides the phy controls in 
these? If not, you don't need the phandles to these nodes. Just find 
them by compatible.

> +
> +Example:
> +
> +mdio at 1 {
> +	reg = <0x1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	usb3phy: usb3phy at 0 {
> +		compatible = "brcm,ns2-usb3-phy";
> +		reg = <0x0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		usb3-ctrl-syscon = <&usb3_ctrl>;
> +		usb3-phy-cfg-syscon = <&usb3_phy_cfg>;

The description says it has register address and length.

> +		usb3-rst-ctrl-syscon = <&usb3_rst_ctrl>;
> +
> +		usb3phy0: usbphy at 0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +		};
> +
> +		usb3phy1: usbphy at 1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +};
> +
> +usb3_ctrl: syscon at 6501d144 {
> +	compatible = "brcm,ns2-usb3-ctrl", "syscon";
> +	reg = <0x6501d144 0x4>;

This isn't part of some larger syscon block? We don't really want to see 
a node per register.

> +};
> +
> +usb3_phy_cfg: syscon at 66000910 {
> +	compatible = "brcm,ns2-usb3-phy-cfg", "syscon";
> +	reg = <0x66000910 0x14>;
> +};
> +
> +usb3_rst_ctrl: syscon at 67000800 {
> +	compatible = "brcm,ns2-usb3-rst-ctrl", "syscon";
> +	reg = <0x67000800 0x1808>;
> +};
> -- 
> 2.7.4
> 
