From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 07:47:09 -0500
Subject: [PATCH v2 4/5] ARM: SPMP8000: Add SPMP8000 SoC and Letcool board
	dts descriptions
In-Reply-To: <1319040118-29773-5-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
	<1319040118-29773-5-git-send-email-zoss@devai.org>
Message-ID: <4EA55E4D.3000106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2011 11:01 AM, Zoltan Devai wrote:
> This adds the DT description of the SPMP8000 SoC, the Letcool
> N350JP board and documentation of required bindings
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> CC: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---

Only a couple of minor things below. Otherwise looks good.

Acked-by: Rob Herring <rob.herring@calxeda.com>

>  Documentation/devicetree/bindings/arm/spmp8000.txt |   25 +++++
>  arch/arm/boot/dts/spmp8000-letcool.dts             |   20 ++++
>  arch/arm/boot/dts/spmp8000.dtsi                    |   93 ++++++++++++++++++++
>  3 files changed, 138 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/spmp8000.txt
>  create mode 100644 arch/arm/boot/dts/spmp8000-letcool.dts
>  create mode 100644 arch/arm/boot/dts/spmp8000.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/spmp8000.txt b/Documentation/devicetree/bindings/arm/spmp8000.txt
> new file mode 100644
> index 0000000..c392b09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/spmp8000.txt
> @@ -0,0 +1,25 @@
> +Sunplus SPMP8000 device tree bindings
> +=====================================
> +
> +Required root node properties:
> +	- compatible:
> +		- "gameware,letcool" : Letcool N350JO handheld game console board
> +		- "sunplus,spmp8000" : A board based on the SPMP8000 SoC
> +
> +Timer required properties:
> +	- compatible = "sunplus,spmp8000-timer"
> +	- interrupt-parent : The interrupt controller node this timer belongs to
> +	- interrupts : IRQs of the timer
> +	- clock-freq : The frequency in HZ of the timer.

"clock-frequency" is what is commonly used.

> +	- reg : The register bank for the timer.
> +
> +Watchdog required properties:
> +	- compatible = "sunplus,spmp8000-watchdof"

s/watchdof/watchdog/

> +	- interrupt-parent : The interrupt controller node this timer belongs to
> +	- interrupts : IRQs of the watchdog
> +	- reg : The register bank for the watchdog controller
> +
> +SCU required properties:
> +	- compatible: "sunplus,spmp8000-scua" or "sunplus,spmp8000-scuab" or
> +		      "sunplus,spmp8000-scuc"
> +	- reg: The register bank of the System Control Unit
> diff --git a/arch/arm/boot/dts/spmp8000-letcool.dts b/arch/arm/boot/dts/spmp8000-letcool.dts
> new file mode 100644
> index 0000000..424f2aa
> --- /dev/null
> +++ b/arch/arm/boot/dts/spmp8000-letcool.dts
> @@ -0,0 +1,20 @@
> +/dts-v1/;
> +/include/ "spmp8000.dtsi"
> +/ {
> +	model = "Letcool N350JP handheld game console";
> +	compatible = "gameware,letcool", "sunplus,spmp8000";
> +
> +	memory {
> +		reg = <0x00000000 0x02000000>;
> +	};
> +
> +	chosen {
> +		linux,stdout-path = &uart0;
> +	};
> +
> +	armapb {
> +		timer at 90000000 {
> +			clock-freq = <15187500>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/spmp8000.dtsi b/arch/arm/boot/dts/spmp8000.dtsi
> new file mode 100644
> index 0000000..15b25fa
> --- /dev/null
> +++ b/arch/arm/boot/dts/spmp8000.dtsi
> @@ -0,0 +1,93 @@
> +/ {
> +	compatible = "sunplus,spmp8000";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	armapb {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x90000000 0x10000>;
> +
> +		timer at 90000000 {
> +			compatible = "sunplus,spmp8000-timer";
> +			reg = <0x0 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <7 8 9>;
> +		};
> +
> +		watchdog at 90001000 {
> +			compatible = "sunplus,spmp8000-wdt";
> +			reg = <0x1000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <10 11 12>;
> +		};
> +
> +		scu-b at 90005000 {
> +			compatible = "sunplus,spmp8000-scub";
> +			reg = <0x5000 0x1000>;
> +		};
> +	};
> +
> +	armahb {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x90010000 0x20000>;
> +
> +		vic0: interrupt-controller at 90010000 {
> +			compatible = "arm,pl192";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0x0 0x1000>;
> +		};
> +
> +		vic1: interrupt-controller at 900020000 {
> +			compatible = "arm,pl192";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0x10000 0x1000>;
> +		};
> +	};
> +
> +	plat {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x92000000 0x1000000>;
> +
> +		scu-c at 92005000 {
> +			compatible = "sunplus,spmp8000-scuc";
> +			reg = <0x5000 0x1000>;
> +		};
> +
> +		plat-apb {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xB00000 0x10000>;

lower case for hex is preferred.

> +
> +			uart0: uart-c0 at 92B04000 {
> +				compatible = "ns16550a";
> +				reg = <0x4000 0x1000>;
> +				clock-frequency = <2076923>;
> +				interrupt-parent = <&vic1>;
> +				interrupts = <24>;
> +				current-speed = <115200>;
> +				reg-shift = <2>;
> +			};
> +		};
> +	};
> +
> +	axi {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x93000000 0x20000>;
> +
> +		scu-a at 93007000 {
> +			compatible = "sunplus,spmp8000-scua";
> +			reg = <0x7000 0x1000>;
> +		};
> +	};
> +};
