From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Nov 2017 15:19:06 -0600
Subject: [PATCH v2 1/3] drivers: usb: phy: Add qoriq usb 3.0 phy driver
 support
In-Reply-To: <20171107072055.26945-1-ran.wang_1@nxp.com>
References: <20171107072055.26945-1-ran.wang_1@nxp.com>
Message-ID: <20171110211906.3xxmquoz74nl4zdc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 03:20:53PM +0800, Ran Wang wrote:
> Adds qoriq usb 3.0 phy driver to implement erratum related workaround
> for qoriq SoC.
> 
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v2:
> 	- Replace funciont __raw_writel() by iowrite32be()
> 	- Remove qoriq_usb3_phy_read() and qoriq_usb3_phy_write()
> 	- Remove USB3PRM1CR_VAL define, use numbers directly
> 	- Use C-style numeric constants on 32'h27672B2A in annotation
> 	- Add prefix 'static' to struct qoriq_usb3_phy_erratum
> 
>  .../devicetree/bindings/phy/phy-qoriq-usb3.txt     |  36 ++++

Please split bindings to separate patch.

>  drivers/phy/Kconfig                                |   9 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qoriq-usb3.c                       | 191 +++++++++++++++++++++
>  4 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>  create mode 100644 drivers/phy/phy-qoriq-usb3.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
> new file mode 100644
> index 000000000000..d956f9c89fbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
> @@ -0,0 +1,36 @@
> +Driver for Freescale USB 3.0 PHY
> +
> +Required properties:
> +
> +- compatible :	fsl,qoriq-usb3-phy
> +- reg :		register mappings for Parameter Configuration Register
> +		and Phy base offset.
> +- reg-names :	"param_ctrl" and "phy_base"
> +- phy_type :	For multi port host USB controllers, should be one of
> +		"ulpi", or "serial". For dual role USB controllers,
> +		should be one of "ulpi", "utmi", "utmi_wide", or "serial".
> +
> +Example:
> +		usbphy0: usb-phy at 084F0000 {

Drop leading 0s and use lower case hex. Building dts with W=2 will tell 
you this.

> +				compatible = "fsl,qoriq-usb3-phy";
> +                reg = <0x0 0x01570070 0x0 0xC>, <0x0 0x084F0000 0x0 0x5000>;
> +                reg-names = "param_ctrl", "phy_base";
> +                #phy-cells = <0>;
> +                phy_type = "utmi";
> +		};
> +
> +        usbphy1: usb-phy at 08500000 {
> +                compatible = "fsl,qoriq-usb3-phy";
> +                reg = <0x0 0x0157007C 0x0 0xC>, <0x0 0x08500000 0x0 0x5000>;
> +                reg-names = "param_ctrl", "phy_base";
> +                #phy-cells = <0>;
> +                phy_type = "utmi";
> +        };
> +
> +        usbphy2: usb-phy at 08510000 {
> +                compatible = "fsl,qoriq-usb3-phy";
> +                reg = <0x0 0x01570088 0x0 0xC>, <0x0 0x08510000 0x0 0x5000>;
> +                reg-names = "param_ctrl", "phy_base";
> +                #phy-cells = <0>;
> +                phy_type = "utmi";
> +        };
