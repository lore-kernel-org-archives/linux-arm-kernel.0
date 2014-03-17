From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 17 Mar 2014 16:28:46 +0100
Subject: [PATCH v3 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <1395068788-19786-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1395068788-19786-1-git-send-email-antoine.tenart@free-electrons.com>
 <1395068788-19786-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <532714AE.2040206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2014 04:06 PM, Antoine T?nart wrote:
> Adds initial support for the Marvell Armada 1500 pro (BG2Q) SoC (Berlin family).
> The SoC has nodes for cpu, l2 cache controller, interrupt controllers, local
> timer, apb timers and uarts for now.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 210 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 210 insertions(+)
>   create mode 100644 arch/arm/boot/dts/berlin2q.dtsi
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> new file mode 100644
> index 000000000000..7a50267b1044
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
[...]
> +
> +	smclk: sysmgr-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +

Antoine,

sorry I missed it the first time. Please add:

+	cfgclk: config-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+

> +	cpuclk: cpu-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1200000000>;
> +	};
> +
> +	sysclk: system-clock {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&cpuclk>;
> +		clock-multi = <1>;
> +		clock-div = <3>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		ranges = <0 0xf7000000 0x1000000>;
> +		interrupt-parent = <&gic>;
> +
> +		l2: l2-cache-controller at ac0000 {
> +			compatible = "arm,pl310-cache";
> +			reg = <0xac0000 0x1000>;
> +			cache-level = <2>;
> +		};
> +
> +		local-timer at ad0600 {
> +			compatible = "arm,cortex-a9-twd-timer";
> +			reg = <0xad0600 0x20>;
> +			clocks = <&sysclk>;
> +			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gic: interrupt-controller at ad1000 {
> +			compatible = "arm,cortex-a9-gic";
> +			reg = <0xad1000 0x1000>, <0xad0100 0x100>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +
> +		apb at e80000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0xe80000 0x10000>;
> +			interrupt-parent = <&aic>;
> +
> +			timer0: timer at 2c00 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c00 0x14>;
> +				interrupts = <8>;
> +				clock-freq = <100000000>;

replace this and all below with:

clocks = <&cfgclk>;

> +			};
> +
> +			timer1: timer at 2c14 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c14 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer2: timer at 2c28 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c28 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer3: timer at 2c3c {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c3c 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer4: timer at 2c50 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c50 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer5: timer at 2c64 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c64 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer6: timer at 2c78 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c78 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
> +			timer7: timer at 2c8c {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c8c 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};
> +
[...]
> +
> +			uart0: uart at 9000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x9000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <8>;
> +				clock-frequency = <25000000>;

and clocks = <&smclk> here and below.

> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			uart1: uart at a000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0xa000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <9>;
> +				clock-frequency = <25000000>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};

Apart from it, this really looks good and I'll pick it up
as soon as I have setup git branches.

Sebastian
