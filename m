From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Sep 2017 10:53:19 -0500
Subject: [PATCH v3 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
In-Reply-To: <20170829084116.106695-3-liwei213@huawei.com>
References: <20170829084116.106695-1-liwei213@huawei.com>
 <20170829084116.106695-3-liwei213@huawei.com>
Message-ID: <20170901155319.zk7wdvysqzit7mog@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 04:41:13PM +0800, Li Wei wrote:
> add ufs node document for Hisilicon
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> new file mode 100644
> index 000000000000..cfc84c821d50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,35 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +			"hisilicon,hi3660-ufs" for hisi ufs host controller
> +			 present on Hi3660 chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks	        : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +		      order as the clocks property. "clk_ref", "clk_phy" is optional
> +
> +Optional properties for board device:
> +- reset-gpio			: specifies to reset devices

reset-gpios

Really, this is should be in a sub node representing the device. It's 
fine if this is it, but if we start adding power supplies and other 
properties it should be a separate node.

> +
> +Example:
> +
> +	ufs: ufs at ff3b0000 {
> +		compatible = "jedec,ufs-1.1", "hisilicon,hi3660-ufs";

Need to reverse the order here. Most specific first.

> +		/* 0: HCI standard */
> +		/* 1: UFS SYS CTRL */
> +		reg = <0x0 0xff3b0000 0x0 0x1000>,
> +			<0x0 0xff3b1000 0x0 0x1000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
> +			<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
> +		clock-names = "clk_ref", "clk_phy";
> +		freq-table-hz = <0 0>, <0 0>;
> +		reset-gpio = <&gpio18 1 0>;
> +	}
> -- 
> 2.11.0
> 
