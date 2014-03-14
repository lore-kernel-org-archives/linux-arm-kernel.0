From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 14 Mar 2014 10:31:55 +0100
Subject: [PATCH v2 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <1394719607-25018-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1394719607-25018-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394719607-25018-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5322CC8B.6010905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 03:06 PM, Antoine T?nart wrote:
> Adds initial support for the Marvell Armada 1500 pro (BG2Q) SoC (Berlin family).
> The SoC has nodes for cpu, l2 cache controller, interrupt controllers, local
> timer, apb timers and uarts for now.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 167 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 167 insertions(+)
>   create mode 100644 arch/arm/boot/dts/berlin2q.dtsi
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> new file mode 100644
> index 000000000000..1cb76031dfe6
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
[...]
> +	clocks {
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +
> +		smclk: sysmgr-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;
> +		};
> +
> +		sysclk: system-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
> +	};
> +
> +	soc {
[...]
> +		local-timer at ad0600 {
> +			compatible = "arm,cortex-a9-twd-timer";
> +			reg = <0xad0600 0x20>;
> +			clocks = <&sysclk>;

If I understand Jisheng correctly, this should be cpuclk/3. When
removing the clocks {} container above, please also take care of
it.

You can do

cpuclk: cpu-clock {
	compatible = "fixed-clock";
	#clock-cells = <0>;
	clock-frequency = <1200000000>; /* <- put correct freq here */
};

sysclk: system-clock {
	compatible = "fixed-factor-clock";
	#clock-cells = <0>;
	clocks = <&cpuclk>;
	clock-multi = <1>;
	clock-div = <3>;
};

Hopefully, we'll have proper clock drivers soon so we can just replace
referenced "fixed-*" clocks.

> +			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";

As Mark Rutland mentioned, get rid of status = "okay" in dtsi.

> +		};
> +
[...]
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
> +				status = "okay";
> +			};
> +
> +			timer1: timer at 2c14 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c14 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};

Please also add the remaining 6 apb timers.

Sebastian
