From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Aug 2016 10:42:28 -0500
Subject: [PATCH 1/3] Documentation: dtb: xgene: Add PMD clock binding
In-Reply-To: <1471967561-23634-2-git-send-email-hotran@apm.com>
References: <1471967561-23634-1-git-send-email-hotran@apm.com>
 <1471967561-23634-2-git-send-email-hotran@apm.com>
Message-ID: <20160829154228.GA23350@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 08:52:39AM -0700, Hoan Tran wrote:
> Add APM X-Gene clock binding documentation for PMD clock.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  Documentation/devicetree/bindings/clock/xgene.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/xgene.txt b/Documentation/devicetree/bindings/clock/xgene.txt
> index 82f9638..c381733 100644
> --- a/Documentation/devicetree/bindings/clock/xgene.txt
> +++ b/Documentation/devicetree/bindings/clock/xgene.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible : shall be one of the following:
>  	"apm,xgene-socpll-clock" - for a X-Gene SoC PLL clock
>  	"apm,xgene-pcppll-clock" - for a X-Gene PCP PLL clock
> +	"apm,xgene-pmd-clock" - for a X-Gene PMD clock
>  	"apm,xgene-device-clock" - for a X-Gene device clock
>  	"apm,xgene-socpll-v2-clock" - for a X-Gene SoC PLL v2 clock
>  	"apm,xgene-pcppll-v2-clock" - for a X-Gene PCP PLL v2 clock
> @@ -22,6 +23,17 @@ Required properties for SoC or PCP PLL clocks:
>  Optional properties for PLL clocks:
>  - clock-names : shall be the name of the PLL. If missing, use the device name.
>  
> +Required properties for PMD clocks:
> +- reg : shall be the physical register address for the pmd clock.
> +- clocks : shall be the input parent clock phandle for the clock.
> +- #clock-cells : shall be set to 1.
> +- clock-output-names : shall be the name of the clock referenced by derive
> +  clock.
> +- clock-shift: Bit shift of the clock register. Default is 0.
> +- clock-width: Width of the clock register. Default is 32.
> +Optional properties for PLL clocks:
> +- clock-names : shall be the name of the clock. If missing, use the device name.
> +
>  Required properties for device clocks:
>  - reg : shall be a list of address and length pairs describing the CSR
>           reset and/or the divider. Either may be omitted, but at least
> @@ -59,6 +71,16 @@ For example:
>  		type = <0>;
>  	};
>  
> +	pmd0clk: pmd0clk {
> +		compatible = "apm,xgene-pmd-clock";
> +		#clock-cells = <1>;
> +		clocks = <&pmdpll 0>;
> +		reg = <0x0 0x7E200200 0x0 0x10>;
> +		clock-shift = <8>;
> +		clock-width = <3>;

These should be implied by the compatible string. It's not a big deal 
for just adding this clock, but if you have lots more clocks to add then 
it is a problem. We only want leaf clocks (the ones going to devices) in 
DT unless there is only a few clocks.

Rob
