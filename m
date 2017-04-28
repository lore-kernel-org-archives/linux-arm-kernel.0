From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 12:52:00 -0500
Subject: [PATCH 2/2] dt-bindings: phy: Add documentation for Mediatek
 PCIe PHY
In-Reply-To: <1492935453-17373-3-git-send-email-ryder.lee@mediatek.com>
References: <1492935453-17373-1-git-send-email-ryder.lee@mediatek.com>
 <1492935453-17373-3-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20170428175200.laakck7ill2lxtxc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 23, 2017 at 04:17:33PM +0800, Ryder Lee wrote:
> Add documentation for PCIe PHY available in MT7623 series SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mt7623-pcie.txt    | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt b/Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
> new file mode 100644
> index 0000000..27a9253
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
> @@ -0,0 +1,67 @@
> +Mediatek MT7623 PCIe PHY
> +-----------------------
> +
> +Required properties:
> + - compatible: Should contain "mediatek,mt7623-pcie-phy"
> + - #phy-cells: must be 0
> + - clocks: Must contain an entry in clock-names.
> +	See ../clocks/clock-bindings.txt for details.
> + - clock-names: Must be "refclk"
> + - resets: Must contain an entry in reset-names.
> +	See ../reset/reset.txt for details.
> + - reset-names: Must be "phy"
> +
> +Optional properties:
> + - phy-switch: The PHY on PCIe port2 is shared with USB u3phy2. If you
> +	want to enable port2, you should contain it.

Need to state what the value is (i.e. a phandle to ?). Also needs a 
vendor prefix.

> +
> +Example:
> +
> +	pcie0_phy: pciephy at 1a149000 {

pcie-phy at ...

> +		compatible = "mediatek,mt7623-pcie-phy";
> +		reg = <0 0x1a149000 0 0x1000>;
> +		clocks = <&clk26m>;
> +		clock-names = "pciephya_ref";
> +		#phy-cells = <0>;
> +		status = "disabled";

Don't show status in examples.

> +	};
> +
> +	pcie1_phy: pciephy at 1a14a000 {
> +		compatible = "mediatek,mt7623-pcie-phy";
> +		reg = <0 0x1a14a000 0 0x1000>;
> +		clocks = <&clk26m>;
> +		clock-names = "pciephya_ref";
> +		#phy-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	pcie2_phy: pciephy at 1a244000 {
> +		compatible = "mediatek,mt7623-pcie-phy";
> +		reg = <0 0x1a244000 0 0x1000>;
> +		clocks = <&clk26m>;
> +		clock-names = "pciephya_ref";
> +		#phy-cells = <0>;
> +
> +		phy-switch = <&hifsys>;
> +		status = "disabled";
> +	};
> +
> +Specifying phy control of devices
> +---------------------------------
> +
> +Device nodes should specify the configuration required in their "phys"
> +property, containing a phandle to the phy node and phy-names.
> +
> +Example:
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +pcie: pcie at 1a140000 {
> +	...
> +	pcie at 1,0 {
> +		...
> +		phys = <&pcie0_phy>;
> +		phy-names = "pcie-phy0";
> +	}
> +	...
> +};
> -- 
> 1.9.1
> 
