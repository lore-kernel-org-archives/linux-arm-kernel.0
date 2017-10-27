From: robh@kernel.org (Rob Herring)
Date: Thu, 26 Oct 2017 22:47:27 -0500
Subject: [RFC 1/3] USB: Add document for usb of Hikey960
In-Reply-To: <20171024060610.10712-2-chenyu56@huawei.com>
References: <20171024060610.10712-1-chenyu56@huawei.com>
 <20171024060610.10712-2-chenyu56@huawei.com>
Message-ID: <20171027034727.ssjes3u5ylzkm2pd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 02:06:08PM +0800, Yu Chen wrote:
> DT bindings for usb of Hikey960.
> 
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Ning Fan <fanning4@hisilicon.com>
> Signed-off-by: Di Yang <yangdi10@hisilicon.com>
> Signed-off-by: Rui Li <lirui39@hisilicon.com>
> 
> ---
>  .../devicetree/bindings/usb/hisilicon-usb.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hisilicon-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/hisilicon-usb.txt b/Documentation/devicetree/bindings/usb/hisilicon-usb.txt
> new file mode 100644
> index 000000000000..dc4c460885d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hisilicon-usb.txt

Should be 3660 specific?

> @@ -0,0 +1,38 @@
> +* HISILICON USB HUB

Looks like a controller, not a hub?

> +
> +Required properties:
> +- compatible: One of the specific types :"hisilicon,hi3660-dwc3",

> +			"hisilicon,gpio_hubv1","hisilicon,gpio_hubv2"

What are these?

> +
> +Optional properties of devices using ISP1301:
> +- transceiver: phandle of isp1301 - this helps the ISP1301 driver to find the
> +               ISP1301 instance associated with the respective USB driver

Really? A full-speed transceiver?

> +
> +Example:
> +
> +	hisi_usb at ff200000 {

usb at ...

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "hisilicon,hi3660-dwc3";
> +		reg = <0x0 0xff200000 0x0 0x1000
> +			 0x0 0xff100000 0x0 0x100000>;
> +		ranges;
> +		bc_again_flag = <0>;

Not documented. Don't use '_' in property names.

> +
> +		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +		eye_diagram_param = <0x1c466e3>;
> +		eye_diagram_host_param = <0x1c466e3>;
> +		usb3_phy_cr_param = <0xb80>;
> +		usb3_phy_host_cr_param = <0x980>;
> +		usb3_phy_tx_vboost_lvl = <0x5>;

All of these have to be documented.

> +
> +		dwc3 at ff100000 {

Ah, it's a DWC3 controller. No references to the common binding?

> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xff100000 0x0 0x100000>;
> +			interrupts = <0 159 4>, <0 161 4>;
> +			dr_mode = "otg";
> +			maximum-speed = "super-speed";
> +		};
> +	};
> \ No newline at end of file

Fix what it says here.

Rob
