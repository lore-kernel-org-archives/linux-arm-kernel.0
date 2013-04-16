From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Apr 2013 08:09:10 -0500
Subject: [PATCH v5 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <1366060483-20342-6-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <516D4D76.2010409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 04:14 PM, Tomasz Figa wrote:
> This patch adds basic device tree definitions for Samsung S3C64xx SoCs.
> 
> Since all the SoCs in the series are very similar, the files are created
> hierarchically - one file for the whole series and then separate files
> for particular SoCs including the common one.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/boot/dts/s3c6400.dtsi         |  33 ++
>  arch/arm/boot/dts/s3c6410.dtsi         |  33 ++
>  arch/arm/boot/dts/s3c64xx-pinctrl.dtsi | 683 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/s3c64xx.dtsi         | 136 +++++++
>  4 files changed, 885 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
> 

[...]

> +
> +	vic0: interrupt-controller at 71200000 {

These nodes should be off a "simple-bus" node.

Rob

> +		compatible = "arm,pl192-vic";
> +		interrupt-controller;
> +		reg = <0x71200000 0x1000>;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	vic1: interrupt-controller at 71300000 {
> +		compatible = "arm,pl192-vic";
> +		interrupt-controller;
> +		reg = <0x71300000 0x1000>;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	pinctrl0: pinctrl at 7f008000 {
> +		compatible = "samsung,s3c64xx-pinctrl";
> +		reg = <0x7f008000 0x1000>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <21>;
> +
> +		pctrl_int_map: pinctrl-interrupt-map {
> +			interrupt-map = <0 &vic0 0>,
> +					<1 &vic0 1>,
> +					<2 &vic1 0>,
> +					<3 &vic1 1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		wakeup-interrupt-controller {
> +			compatible = "samsung,s3c64xx-wakeup-eint";
> +			interrupts = <0>, <1>, <2>, <3>;
> +			interrupt-parent = <&pctrl_int_map>;
> +		};
> +	};
> +
> +	pwm: pwm at 7f006000 {
> +		compatible = "samsung,s3c6400-pwm";
> +		reg = <0x7f006000 0x1000>;
> +		interrupt-parent = <&vic0>;
> +		interrupts = <23>, <24>, <25>, <27>, <28>;
> +		samsung,pwm-outputs = <0>, <1>;
> +		#pwm-cells = <3>;
> +		status = "disabled";
> +	};
> +
> +	uart0: serial at 7f005000 {
> +		compatible = "samsung,s3c6400-uart";
> +		reg = <0x7f005000 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <5>;
> +		status = "disabled";
> +	};
> +
> +	uart1: serial at 7f005400 {
> +		compatible = "samsung,s3c6400-uart";
> +		reg = <0x7f005400 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <6>;
> +		status = "disabled";
> +	};
> +
> +	uart2: serial at 7f005800 {
> +		compatible = "samsung,s3c6400-uart";
> +		reg = <0x7f005800 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <7>;
> +		status = "disabled";
> +	};
> +
> +	uart3: serial at 7f005c00 {
> +		compatible = "samsung,s3c6400-uart";
> +		reg = <0x7f005c00 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <8>;
> +		status = "disabled";
> +	};
> +
> +	sdhci0: sdhci at 7c200000 {
> +		compatible = "samsung,s3c6410-sdhci";
> +		reg = <0x7c200000 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <24>;
> +		status = "disabled";
> +	};
> +
> +	sdhci1: sdhci at 7c300000 {
> +		compatible = "samsung,s3c6410-sdhci";
> +		reg = <0x7c300000 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <25>;
> +		status = "disabled";
> +	};
> +
> +	sdhci2: sdhci at 7c400000 {
> +		compatible = "samsung,s3c6410-sdhci";
> +		reg = <0x7c400000 0x100>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <17>;
> +		status = "disabled";
> +	};
> +};
> +
> +/include/ "s3c64xx-pinctrl.dtsi"
> 
