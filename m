From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Apr 2014 11:48:39 +0100
Subject: [PATCH 1/3] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <1396907649-20212-2-git-send-email-tthayer@altera.com>
References: <1396907649-20212-1-git-send-email-tthayer@altera.com>
 <1396907649-20212-2-git-send-email-tthayer@altera.com>
Message-ID: <20140408104839.GB11876@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:54:07PM +0100, tthayer at altera.com wrote:
> From: Thor Thayer <tthayer@altera.com>
> 
> Addition of the Altera SDRAM controller bindings and device
> tree changes to the Altera SoC project.
> 
> Signed-off-by: Thor Thayer <tthayer@altera.com>
> To: Rob Herring <robherring2@gmail.com>
> To: Pawel Moll <pawel.moll@arm.com>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Ian Campbell <ijc+devicetree@hellion.org.uk>
> To: Kumar Gala <galak@codeaurora.org>
> To: Rob Landley <rob@landley.net>
> To: Russell King <linux@arm.linux.org.uk>
> To: Dinh Nguyen <dinguyen@altera.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  .../bindings/arm/altera/socfpga-sdram.txt          |   14 ++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> new file mode 100644
> index 0000000..525cb76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> @@ -0,0 +1,14 @@
> +Altera SOCFPGA SDRAM Controller
> +
> +Required properties:
> +- compatible : "altr,sdr-ctl", "syscon";
> +                Note that syscon is invoked for this device to support the FPGA
> +		bridge driver, EDAC driver and other devices that share the
> +		registers.

Is the SDRAM controller really a bag of bits that necessitates the use
of syscon? Or are the "other devices" just sub-components of the SDRAM
controller?

If they are, just describe the SDRAM controller and related interrupts
as a single node, and only use the EDAC portion in the Linux driver.

Cheers,
Mark.

> +- reg : Should contain 1 register ranges(address and length)
> +
> +Example:
> +	sdrctl at ffc25000 {
> +		compatible = "altr,sdr-ctl", "syscon";
> +		reg = <0xffc25000 0x1000>;
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index df43702..6ce912e 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -676,6 +676,11 @@
>  			clocks = <&l4_sp_clk>;
>  		};
>  
> +		sdrctl at ffc25000 {
> +			compatible = "altr,sdr-ctl", "syscon";
> +			reg = <0xffc25000 0x1000>;
> +		};
> +
>  		rstmgr at ffd05000 {
>  			compatible = "altr,rst-mgr";
>  			reg = <0xffd05000 0x1000>;
> -- 
> 1.7.9.5
> 
> 
