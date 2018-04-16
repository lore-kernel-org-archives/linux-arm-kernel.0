From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 16:28:12 -0500
Subject: [PATCH v6 10/11] dt-bindings: clock: Add bindings for ZynqMP
 clock driver
In-Reply-To: <1523389127-14243-11-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-11-git-send-email-jollys@xilinx.com>
Message-ID: <20180416212812.abmxy23r5peiwbik@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 12:38:46PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP clock driver
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

One nit, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index 1b431d9..ee8d0b0 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -17,6 +17,53 @@ Required properties:
>  		  - "smc" : SMC #0, following the SMCCC
>  		  - "hvc" : HVC #0, following the SMCCC
>  
> +--------------------------------------------------------------------------
> +Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
> +Zynq MPSoC firmware interface
> +--------------------------------------------------------------------------
> +The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
> +tree. It reads required input clock frequencies from the devicetree and acts
> +as clock provider for all clock consumers of PS clocks.
> +
> +See clock_bindings.txt for more information on the generic clock bindings.
> +
> +Required properties:
> + - #clock-cells:	Must be 1
> + - compatible:		Must contain:	"xlnx,zynqmp-clk"
> + - clocks:		List of clock specifiers which are external input
> +			clocks to the given clock controller. Please refer
> +			the next section to find the input clocks for a
> +			given controller.
> + - clock-names:		List of clock names which are exteral input clocks
> +			to the given clock controller. Please refer to the
> +			clock bindings for more details.
> +
> +Input clocks for zynqmp Ultrascale+ clock controller:
> +
> +The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
> +inputs. These required clock inputs are:
> + - pss_ref_clk (PS reference clock)
> + - video_clk (reference clock for video system )
> + - pss_alt_ref_clk (alternative PS reference clock)
> + - aux_ref_clk
> + - gt_crx_ref_clk (transceiver reference clock)
> +
> +The following strings are optional parameters to the 'clock-names' property in
> +order to provide an optional (E)MIO clock source:
> + - swdt0_ext_clk
> + - swdt1_ext_clk
> + - gem0_emio_clk
> + - gem1_emio_clk
> + - gem2_emio_clk
> + - gem3_emio_clk
> + - mio_clk_XX		# with XX = 00..77
> + - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
> +
> +
> +Output clocks are registered based on clock information received
> +from firmware. Output clocks indexes are mentioned in
> +include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> +
>  -------
>  Example
>  -------
> @@ -25,5 +72,11 @@ firmware {
>  	zynqmp_firmware: zynqmp-firmware {
>  		compatible = "xlnx,zynqmp-firmware";
>  		method = "smc";
> +		clk: clk {

clock-controller {

> +			#clock-cells = <1>;
> +			compatible = "xlnx,zynqmp-clk";
> +			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> +			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> +		};
>  	};
>  };
