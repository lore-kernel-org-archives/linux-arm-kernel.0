From: robh@kernel.org (Rob Herring)
Date: Fri, 22 Jan 2016 20:35:13 -0600
Subject: [PATCHv8 2/4] ARM: dts: Add Altera L2 Cache and OCRAM EDAC entries
In-Reply-To: <1453397668-32094-2-git-send-email-tthayer@opensource.altera.com>
References: <1453397668-32094-1-git-send-email-tthayer@opensource.altera.com>
 <1453397668-32094-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160123023513.GA2081@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 11:34:26AM -0600, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Adding the device tree entries and bindings needed to support
> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
> an earlier patch to declare and setup On-chip RAM properly.
> http://www.spinics.net/lists/devicetree/msg51117.html
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v8: Fix node names to include chip family and use ecc manager
>     to better describe the driver. Rename socfpga-edac.txt to
>     socfpga-eccmgr.txt.
> v7: No Change
> v6: Change to nested EDAC device nodes based on community
>     feedback. Remove L2 syscon. Use consolidated binding.
> v3-5: No Change
> v2: Remove OCRAM declaration and reference prior patch.
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   49 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   20 ++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt

A couple of nits, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> new file mode 100644
> index 0000000..4f45690
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> @@ -0,0 +1,49 @@
> +Altera SoCFPGA ECC Manager
> +This driver uses the EDAC framework to implement the SOCFPGA ECC Manager.
> +The ECC Manager counts and corrects single bit errors and counts/handles
> +double bit errors which are uncorrectable.
> +
> +Required Properties:
> +- compatible : Should be "altr,socfpga-ecc-manager"
> +- #address-cells: must be 1
> +- #size-cells: must be 1
> +- ranges : standard definition, should translate from local addresses
> +
> +Subcomponents:
> +
> +L2 Cache ECC
> +Required Properties:
> +- compatible : Should be "altr,socfpga-l2-ecc"
> +- reg : Address and size for ECC error interrupt clear registers.
> +- interrupts : Should be single bit error interrupt, then double bit error
> +	interrupt. Note the rising edge type.
> +
> +On Chip RAM ECC
> +Required Properties:
> +- compatible : Should be "altr,socfpga-ocram-ecc"
> +- reg : Address and size for ECC error interrupt clear registers.
> +- iram : phandle to On-Chip RAM definition.
> +- interrupts : Should be single bit error interrupt, then double bit error
> +	interrupt. Note the rising edge type.
> +
> +Example:
> +
> +	eccmgr: eccmgr at 0xffd08140 {

drop the '0x'

> +		compatible = "altr,socfpga-ecc-manager";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		l2-ecc at ffd08140 {
> +			compatible = "altr,socfpga-l2-ecc";
> +			reg = <0xffd08140 0x4>;
> +			interrupts = <0 36 1>, <0 37 1>;
> +		};
> +
> +		ocram-ecc at ffd08144 {
> +			compatible = "altr,socfpga-ocram-ecc";
> +			reg = <0xffd08144 0x4>;
> +			iram = <&ocram>;
> +			interrupts = <0 178 1>, <0 179 1>;
> +		};
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 39c470e..9bb383e 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -656,6 +656,26 @@
>  			status = "disabled";
>  		};
>  
> +		eccmgr: eccmgr at 0xffd08140 {

and here.

> +			compatible = "altr,socfpga-ecc-manager";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			l2-ecc at ffd08140 {
> +				compatible = "altr,socfpga-l2-ecc";
> +				reg = <0xffd08140 0x4>;
> +				interrupts = <0 36 1>, <0 37 1>;
> +			};
> +
> +			ocram-ecc at ffd08144 {
> +				compatible = "altr,socfpga-ocram-ecc";
> +				reg = <0xffd08144 0x4>;
> +				iram = <&ocram>;
> +				interrupts = <0 178 1>, <0 179 1>;
> +			};
> +		};
> +
>  		L2: l2-cache at fffef000 {
>  			compatible = "arm,pl310-cache";
>  			reg = <0xfffef000 0x1000>;
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
