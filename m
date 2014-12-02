From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Dec 2014 14:57:35 +0000
Subject: [PATCHv5 5/5] arm: dts: Add Altera L2 Cache and OCRAM EDAC
In-Reply-To: <1415751263-1830-6-git-send-email-tthayer@opensource.altera.com>
References: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
 <1415751263-1830-6-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20141202145735.GL23671@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 12:14:23AM +0000, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Adding the device tree entries and bindings needed to support
> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
> an earlier patch to declare and setup On-chip RAM properly.
> http://www.spinics.net/lists/devicetree/msg51117.html
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Remove OCRAM declaration and reference prior patch.
> 
> v3-5: No Change
> ---
>  .../bindings/arm/altera/socfpga-l2-edac.txt        |   15 +++++++++++++++
>  .../bindings/arm/altera/socfpga-ocram-edac.txt     |   16 ++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   15 ++++++++++++++-
>  3 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt
> new file mode 100644
> index 0000000..35b19e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt
> @@ -0,0 +1,15 @@
> +Altera SoCFPGA L2 cache Error Detection and Correction [EDAC]
> +
> +Required Properties:
> +- compatible : Should be "altr,l2-edac"
> +- reg : Address and size for ECC error interrupt clear registers.
> +- interrupts : Should be single bit error interrupt, then double bit error
> +	interrupt. Note the rising edge type.
> +
> +Example:
> +
> +	l2edac at ffd08140 {
> +		compatible = "altr,l2-edac";
> +		reg = <0xffd08140 0x4>;
> +		interrupts = <0 36 1>, <0 37 1>;
> +	};

Judging by the size of the reg entry, this is part of a larger block
(the same one the OCRAM EDAC lives in). Why isn't that larger block
described?

EDAC is a Linux subsystem name, but typically not the HW block name.
What HW block does this live in?

> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt
> new file mode 100644
> index 0000000..31ab205
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt
> @@ -0,0 +1,16 @@
> +Altera SoCFPGA On-Chip RAM Error Detection and Correction [EDAC]
> +
> +OCRAM ECC Required Properties:
> +- compatible : Should be "altr,ocram-edac"
> +- reg : Address and size for ECC error interrupt clear registers.
> +- iram : phandle to On-Chip RAM definition.
> +- interrupts : Should be single bit error interrupt, then double bit error
> +	interrupt. Note the rising edge type.
> +
> +Example:
> +	ocramedac at ffd08144 {
> +		compatible = "altr,ocram-edac";
> +		reg = <0xffd08144 0x4>;
> +		iram = <&ocram>;
> +		interrupts = <0 178 1>, <0 179 1>;
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 6af96ed..32c63a3 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -618,8 +618,21 @@
>  			interrupts = <0 39 4>;
>  		};
>  
> +		l2edac at ffd08140 {
> +			compatible = "altr,l2-edac";
> +			reg = <0xffd08140 0x4>;
> +			interrupts = <0 36 1>, <0 37 1>;
> +		};
> +
> +		ocramedac at ffd08144 {
> +			compatible = "altr,ocram-edac";
> +			reg = <0xffd08144 0x4>;
> +			iram = <&ocram>;
> +			interrupts = <0 178 1>, <0 179 1>;
> +		};
> +
>  		L2: l2-cache at fffef000 {
> -			compatible = "arm,pl310-cache";
> +			compatible = "arm,pl310-cache", "syscon";

NAK. 

Why are you marking the PL310 as a syscon device? It is most definitely
_NOT_ a shared set of registers lumped together.

Thanks,
Mark.
