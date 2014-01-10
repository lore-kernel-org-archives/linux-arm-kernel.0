From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 10 Jan 2014 11:32:18 +0100
Subject: [PATCH 6/6] arm: dts: add cpu nodes for Exynos4210 SoC
In-Reply-To: <1389283165-17708-7-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140110113218.423bc6e0@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> Add CPU nodes for Exynos4210 SoC and also properties required by the
> cpufreq-cpu0 driver.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         |    6 ++++++
>  arch/arm/boot/dts/exynos4210-trats.dts          |    6 ++++++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 ++++++
>  arch/arm/boot/dts/exynos4210.dtsi               |   22
> ++++++++++++++++++++++ 4 files changed, 40 insertions(+), 0
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts
> b/arch/arm/boot/dts/exynos4210-origen.dts index 2aa13cb..afecd8f
> 100644 --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -32,6 +32,12 @@
>  		bootargs ="root=/dev/ram0 rw ramdisk=8192
> initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc"; };
>  
> +	cpus {
> +		cpu: cpu at 0 {
> +			cpu0-supply = <&buck1_reg>;
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts
> b/arch/arm/boot/dts/exynos4210-trats.dts index 63cc571..25487d7 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -30,6 +30,12 @@
>  		bootargs = "console=ttySAC2,115200N8
> root=/dev/mmcblk0p5 rootwait earlyprintk panic=5"; };
>  
> +	cpus {
> +		cpu: cpu at 0 {
> +			cpu0-supply = <&varm_breg>;
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> b/arch/arm/boot/dts/exynos4210-universal_c210.dts index
> d2e3f5f..74d5a70 100644 ---
> a/arch/arm/boot/dts/exynos4210-universal_c210.dts +++
> b/arch/arm/boot/dts/exynos4210-universal_c210.dts @@ -28,6 +28,12 @@
>  		bootargs = "console=ttySAC2,115200N8
> root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1"; };
>  
> +	cpus {
> +		cpu: cpu at 0 {
> +			cpu0-supply = <&vdd_arm_reg>;
> +		};
> +	};
> +
>  	mct at 10050000 {
>  		compatible = "none";
>  	};
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> b/arch/arm/boot/dts/exynos4210.dtsi index 48ecd7a..3db2da8 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -36,6 +36,28 @@
>  		reg = <0x10023CA0 0x20>;
>  	};
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			clocks = <&clock 12>;
> +			clock-names = "cpu";
> +
> +			operating-points = <
> +				200000	950000
> +				400000	975000
> +				500000	975000
> +				800000	1075000
> +				1000000	1150000
> +				1200000	1250000
> +			>;

On the ./arch/arm/boot/dts/highbank.dts the oop's order is decreasing. 

That shouldn't be a problem for the cpufreq core, however in my opinion
we shall stick to one convention.

> +			safe-opp-index = <3>;
> +		};
> +	};
> +
>  	gic: interrupt-controller at 10490000 {
>  		cpu-offset = <0x8000>;
>  	};



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
