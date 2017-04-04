From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Apr 2017 11:28:39 -0700
Subject: [PATCH v6 1/4] dt-bindings: phy: Add support for QUSB2 phy
In-Reply-To: <1490018046-8549-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
 <1490018046-8549-2-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20170404182839.GE18246@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20, Vivek Gautam wrote:
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> new file mode 100644
> index 000000000000..a6d19acde9e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> @@ -0,0 +1,45 @@
> +Qualcomm QUSB2 phy controller
> +=============================
> +
> +QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> +
> +Required properties:
> + - compatible: compatible list, contains "qcom,msm8996-qusb2-phy".
> + - reg: offset and length of the PHY register set.
> + - #phy-cells: must be 0.
> +
> + - clocks: a list of phandles and clock-specifier pairs,
> +	   one for each entry in clock-names.
> + - clock-names: must be "cfg_ahb" for phy config clock,
> +			"ref" for 19.2 MHz ref clk,
> +			"iface" for phy interface clock (Optional).
> +
> + - vdd-phy-supply: Phandle to a regulator supply to PHY core block.
> + - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> + - vdda-phy-dpdm-supply: Phandle to 3.1V regulator supply to Dp/Dm port signals.
> +
> + - resets: Phandle to reset to phy block.
> +
> +Optional properties:
> + - nvmem-cells: Phandle to nvmem cell that contains 'HS Tx trim'
> +		tuning parameter value for qusb2 phy.
> +
> + - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
> +
> +Example:
> +	hsusb_phy: phy at 7411000 {
> +		compatible = "qcom,msm8996-qusb2-phy";
> +		reg = <0x7411000 0x180>;
> +		#phy-cells = <0>;
> +
> +		clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +			<&gcc GCC_RX1_USB2_CLKREF_CLK>,
> +		clock-names = "cfg_ahb", "ref";
> +
> +		vdd-phy-supply = <&pm8994_s2>;

pm8994_s2 is a "corner" regulator. I'm not sure how we're going
to have it listed here as something like a regulator supply in
the binding. We probably should leave it out for now and let the
power domain + pm_qos stuff for corners work out. From what I see
in the downstream driver the code is setting the corner to '4'
when active, and '1' when inactive.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
