From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Feb 2018 09:03:31 +0530
Subject: [PATCH v2 06/16] arm64: dts: mt7622: add cpufreq related device
 nodes
In-Reply-To: <fc5bdf53b92bd7a96e94b714d8d13deebca95c28.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
 <fc5bdf53b92bd7a96e94b714d8d13deebca95c28.1517910489.git.sean.wang@mediatek.com>
Message-ID: <20180207033331.GK28462@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-02-18, 17:52, sean.wang at mediatek.com wrote:
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -26,6 +70,10 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x0>;
> +			clocks = <&infracfg CLK_INFRA_MUX1_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cpu_opp_table>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};
> @@ -34,6 +82,7 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x1>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};

Sorry for not picking this earlier, but you should probably add the same clock
related properties for both cpu nodes here. Things will break if CPU1 is used by
the cpufreq core to bring the cpufreq policy online.

This can happen if cpufreq driver is a module, CPU0 is hotplugged out and then
the cpufreq driver is inserted.

-- 
viresh
