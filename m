From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 8 Apr 2014 15:38:18 +0200
Subject: [PATCH 1/3] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <1396907649-20212-2-git-send-email-tthayer@altera.com>
References: <1396907649-20212-1-git-send-email-tthayer@altera.com>
 <1396907649-20212-2-git-send-email-tthayer@altera.com>
Message-ID: <20140408133818.GB16054@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Apr 07, 2014 at 04:54:07PM -0500, tthayer at altera.com wrote:
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
> +- reg : Should contain 1 register ranges(address and length)

I haven't really thought this through, but why would the FPGA bridge driver
access the sdram controller? For releasing the resets in fpgaportrst ? Or is
there more?
Wouldn't it be more appropriate to represent those bits as a reset-controller to
some hypothetical IP core driver?
Then you could have something like

	hps2fpga at c0000000 {
		ipcore at 0 {
			resets = <&sdr 1>;
			reset-names = "foo";
			resets = <&rst 96>;
			reset-names = "bar";
			(...)
		};

		ipcore at 1000 {
			resets = <&rst 96>;
			reset-names = "baz";
			(...)
		};
	};

And you would always have the correct bridges released out of reset for your
IP core. Does the FPGA bridge driver do more? I think that is basically it.
Where we maybe could run into problems though is the early_init stuff.

I think syscon is nice for some things, but we should try not to overuse it.

Regards,
Steffen

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

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
