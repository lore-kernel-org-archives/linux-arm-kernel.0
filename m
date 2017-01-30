From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 22:51:33 +0000
Subject: [PATCH v3 06/24] ARM: dts: imx6-sabrelite: add OV5642 and OV5640
 camera sensors
In-Reply-To: <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170130225133.GF27898@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:24PM -0800, Steve Longerbeam wrote:
> +	ov5640: camera at 40 {
> +		compatible = "ovti,ov5640";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ov5640>;
> +		clocks = <&mipi_xclk>;
> +		clock-names = "xclk";
> +		reg = <0x40>;
> +		xclk = <22000000>;
> +		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* NANDF_D5 */
> +		pwdn-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* NANDF_WP_B */
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ov5640_to_mipi_csi: endpoint at 1 {
> +				reg = <1>;
> +				remote-endpoint = <&mipi_csi_from_mipi_sensor>;
> +				data-lanes = <0 1>;
> +				clock-lanes = <2>;

How do you envision a four-lane sensor being described?

	data-lanes = <0 1 3 4>;
	clock-lanes = <2>;

?

The binding document for video-interfaces.txt says:

- clock-lanes: an array of physical clock lane indexes. Position of an entry
  determines the logical lane number, while the value of an entry indicates
  physical lane, e.g. for a MIPI CSI-2 bus we could have "clock-lanes = <0>;",
  which places the clock lane on hardware lane 0. This property is valid for
  serial busses only (e.g. MIPI CSI-2). Note that for the MIPI CSI-2 bus this
  array contains only one entry.

So I think you need to have a good reason to make the clock lane non-zero.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
