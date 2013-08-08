From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 14:14:18 -0600
Subject: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
Message-ID: <5203FC1A.3090903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 02:43 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> new file mode 100644
> index 0000000..dc14922
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> @@ -0,0 +1,48 @@
> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +	  specific extensions.
> +
> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which means parent_clock/4.

This feels like something that should be represented using the common
clock API; a driver should query the rate of its input clock, and then
calculate the MMC block's internal divider based on that (perhaps also
call clk_set_rate() on the input clock?).

> +Example:
> +	dwmmc0 at ff704000 {
> +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 139 4>;

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		num-slots = <1>;
> +		supports-highspeed;
> +		fifo-depth = <0x400>;

Those properties aren't defined in this document anywhere. I guess this
binding is meant to "inherit" from that described in
"synopsis-dw-mshc.txt"? If so, that should be stated explicitly.

A similar comment applies to the clocks properties in the *.dtsi changes.

> +		altr,dw-mshc-ciu-div = <3>;
> +      		altr,dw-mshc-sdr-timing = <0 3>;

Indentation issue.
