From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 16:34:33 +0200
Subject: [PATCH v3 9/9] arm64: dts: marvell: add gpio support for Armada
 7K/8K
In-Reply-To: <dfe7cb1d616169bdf96e88aef7bfc46e668dba5a.1497281623.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 12 Jun 2017 17:35:00 +0200")
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <dfe7cb1d616169bdf96e88aef7bfc46e668dba5a.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <87y3sm3eyu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., juin 12 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Enable gpio support for CP and AP on the Marvell Armada 7K/8K SoCs.
>
> The Armada 8K has two CP110 blocks, each having two GPIO controllers.
> However, in each CP110 block, one of the GPIO controller cannot be
> used: in the master CP110, only the second GPIO controller can be used,
> while on the slave CP110, only the first GPIO controller can be used.
>
> On the other side, the Armada 7K has only one CP110, but both its GPIO
> controllers can be used.
>
> For this reason, the GPIO controllers are marked as "disabled" in the
> armada-cp110-master.dtsi and armada-cp110-slave.dtsi files, and only
> enabled in the per-SoC dtsi files.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi         | 15 +++++++++-
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi         | 16 +++++++++-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 10 ++++++-
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 21 ++++++++++++-
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 22 +++++++++++++-
>  5 files changed, 84 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> index f6c22665d091..860b6ae9dcc5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> @@ -46,6 +46,21 @@
>  
>  #include "armada-cp110-master.dtsi"
>  
> +/ {
> +	aliases {
> +		gpio1 = &cpm_gpio1;
> +		gpio2 = &cpm_gpio2;
> +	};
> +};
> +
> +&cpm_gpio1 {
> +	status = "okay";
> +};
> +
> +&cpm_gpio2 {
> +	status = "okay";
> +};
> +
>  &cpm_syscon0 {
>  	cpm_pinctrl: pinctrl {
>  		compatible = "marvell,armada-7k-pinctrl";
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> index 93d1de03b39a..666ebe96ba0d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -47,6 +47,22 @@
>  #include "armada-cp110-master.dtsi"
>  #include "armada-cp110-slave.dtsi"
>  
> +/ {
> +	aliases {
> +		gpio1 = &cps_gpio1;
> +		gpio2 = &cpm_gpio2;
> +	};
> +};
> +
> +/* The 80x0 has two CP blocks, but uses only one block from each. */
> +&cps_gpio1 {
> +	status = "okay";
> +};
> +
> +&cpm_gpio2 {
> +	status = "okay";
> +};
> +
>  &cpm_syscon0 {
>  	cpm_pinctrl: pinctrl {
>  		compatible = "marvell,armada-8k-cpm-pinctrl";
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 4a1b6e0a604a..64608658de5a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -57,6 +57,7 @@
>  	aliases {
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> +		gpio0 = &ap_gpio;
>  	};
>  
>  	psci {
> @@ -252,6 +253,15 @@
>  				ap_pinctrl: pinctrl {
>  					compatible = "marvell,ap806-pinctrl";
>  				};
> +
> +				ap_gpio: gpio {
> +					compatible = "marvell,armada-8k-gpio";
> +					offset = <0x1040>;
> +					ngpios = <19>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&ap_pinctrl 0 0 19>;
> +				};
>  			};
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 96a4ff75b3b0..f88618185d58 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -104,6 +104,27 @@
>  					compatible = "marvell,cp110-clock";
>  					#clock-cells = <2>;
>  				};
> +
> +				cpm_gpio1: gpio at 100 {
> +					compatible = "marvell,armada-8k-gpio";
> +					offset = <0x100>;
> +					ngpios = <32>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&cpm_pinctrl 0 0 32>;
> +					status = "disabled";
> +
> +				};
> +
> +				cpm_gpio2: gpio at 140 {
> +					compatible = "marvell,armada-8k-gpio";
> +					offset = <0x140>;
> +					ngpios = <31>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&cpm_pinctrl 0 32 31>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			cpm_rtc: rtc at 284000 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 48a658aa5b32..f3a6e6742442 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -111,6 +111,28 @@
>  					compatible = "marvell,cp110-clock";
>  					#clock-cells = <2>;
>  				};
> +
> +				cps_gpio1: gpio at 100 {
> +					compatible = "marvell,armada-8k-gpio";
> +					offset = <0x100>;
> +					ngpios = <32>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&cps_pinctrl 0 0 32>;
> +					status = "disabled";
> +
> +				};
> +
> +				cps_gpio2: gpio at 140 {
> +					compatible = "marvell,armada-8k-gpio";
> +					offset = <0x140>;
> +					ngpios = <31>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					gpio-ranges = <&cps_pinctrl 0 32 31>;
> +					status = "disabled";
> +				};
> +
>  			};
>  
>  			cps_sata0: sata at 540000 {
> -- 
> git-series 0.9.1
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
