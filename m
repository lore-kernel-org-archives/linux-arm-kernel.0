From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 11:29:50 +0100
Subject: [PATCH 09/11] ARM: berlin: rework chip and system controller
 nodes for BG2
In-Reply-To: <1423671332-24580-10-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-10-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <54E4699E.4010909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.02.2015 17:15, Antoine Tenart wrote:
> The chip and system controller nodes are now handled by the Berlin
> controller mfd driver. Its sub-devices are then registered by the mfd
> driver and let the drivers be probed properly, using their own
> sub-nodes.
>
> Rework the device tree to take this changes into account.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
[...]
> -		chip: chip-control at ea0000 {
> -			compatible = "marvell,berlin2-chip-ctrl";
> -			#clock-cells = <1>;
> -			#reset-cells = <2>;
> +		chip: chip-controller at ea0000 {
> +			compatible = "marvell,berlin2-chip-ctrl", "syscon";
>   			reg = <0xea0000 0x400>;
> +			#clock-cells = <1>;

Antoine,

I noticed just now, but we should either have all of clock, reset,
pinctrl as sub-nodes or none. Currently, this has pinctrl and reset
as sub-nodes but clock hooked up to chip-controller.

Sebastian

>   			clocks = <&refclk>;
>   			clock-names = "refclk";
>
> -			emmc_pmux: emmc-pmux {
> -				groups = "G26";
> -				function = "emmc";
> +			soc_pinctrl: pin-controller {
> +				compatible = "marvell,berlin2-soc-pinctrl";
> +
> +				emmc_pmux: emmc-pmux {
> +					groups = "G26";
> +					function = "emmc";
> +				};
> +			};
> +
> +			chip_rst: reset {
> +				compatible = "marvell,berlin2-reset";
> +				#reset-cells = <2>;
>   			};
>   		};
>
> @@ -442,22 +450,26 @@
>   			};
>
>   			sysctrl: system-controller at d000 {
> -				compatible = "marvell,berlin2-system-ctrl";
> +				compatible = "marvell,berlin2-system-ctrl", "syscon";
>   				reg = <0xd000 0x100>;
>
> -				uart0_pmux: uart0-pmux {
> -					groups = "GSM4";
> -					function = "uart0";
> -				};
> +				sys_pinctrl: pin-controller {
> +					compatible = "marvell,berlin2-system-pinctrl";
>
> -				uart1_pmux: uart1-pmux {
> -					groups = "GSM5";
> -					function = "uart1";
> -				};
> +					uart0_pmux: uart0-pmux {
> +						groups = "GSM4";
> +						function = "uart0";
> +					};
> +
> +					uart1_pmux: uart1-pmux {
> +						groups = "GSM5";
> +						function = "uart1";
> +					};
>
> -				uart2_pmux: uart2-pmux {
> -					groups = "GSM3";
> -					function = "uart2";
> +					uart2_pmux: uart2-pmux {
> +						groups = "GSM3";
> +						function = "uart2";
> +					};
>   				};
>   			};
>
>
