From: huangtao@rock-chips.com (Huang, Tao)
Date: Tue, 7 Mar 2017 15:20:28 +0800
Subject: [PATCH] arm64: dts: rockchip: remove wrongly added idle states on
 rk3368
In-Reply-To: <20170301223849.13401-1-heiko@sntech.de>
References: <20170301223849.13401-1-heiko@sntech.de>
Message-ID: <9e79905e-8dff-2980-ab8d-9cfd880275c0@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:

On 2017?03?02? 06:38, Heiko Stuebner wrote:
> As reported by Lorenzo, the residency/latency values defined in the
> idle-state for rk3368 "make no sense". When introducing them I
> simply took the idle-state node from the vendor kernel in error
> as I didn't look up if these values were sane in the first place.
>
> Talking to people and determining why they were used in this way
> showed that it was meant to make sure the cpu_suspend callback
> got initialized which at the 3.10 time was somehow required even
> for wfi-based idle handling.
>
> Of course the generic arch_cpu_idle() now does wfi-based idle-handling
> already, so there is no need for this.
>
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This has been sitting ere for way to long :-(, but finally I got
> to finish the change.
>
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 49d1191..5471ace 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -107,23 +107,10 @@
>  			};
>  		};
>  
> -		idle-states {
> -			entry-method = "psci";
> -
> -			cpu_sleep: cpu-sleep-0 {
> -				compatible = "arm,idle-state";
> -				arm,psci-suspend-param = <0x1010000>;
> -				entry-latency-us = <0x3fffffff>;
> -				exit-latency-us = <0x40000000>;
> -				min-residency-us = <0xffffffff>;
> -			};
> -		};
> -
>  		cpu_l0: cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x0>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -133,7 +120,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x1>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  
> @@ -141,7 +127,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x2>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  
> @@ -149,7 +134,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x3>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  
> @@ -157,7 +141,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x100>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  
>  			#cooling-cells = <2>; /* min followed by max */
> @@ -167,7 +150,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x101>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  
> @@ -175,7 +157,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x102>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  
> @@ -183,7 +164,6 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x103>;
> -			cpu-idle-states = <&cpu_sleep>;
>  			enable-method = "psci";
>  		};
>  	};
Looks good to me.
There are another redundant node - timer at ff810000, which can not probe
successfully because of missing clocks property. RK3368 don't support
power down core while idle, so there are not need add broadcast timer.
Should we delete the timer node or add missing clocks?
If add clocks, we should fix clk drivers first because timer clk is not
exported.
I suggest we should delete the timer node.
