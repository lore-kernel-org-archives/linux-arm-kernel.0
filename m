From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Aug 2017 10:45:15 +0530
Subject: [PATCH 1/4] ARM: dts: augment Ux500 to use DT cpufreq
In-Reply-To: <20170810125221.25818-2-linus.walleij@linaro.org>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-2-linus.walleij@linaro.org>
Message-ID: <20170811051515.GD3638@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-08-17, 14:52, Linus Walleij wrote:
> This adds the operating points to the Ux500 device tree and
> deletes the old special-purpose cpufreq node, as we can now
> use the generic DT cpufreq driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Viresh et al: I will merge this into ARM SoC separately from
> the rest of the patches once we agree on this approach.

Sure, no worries.

> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index 6c5affe2d0f5..2310a4e97768 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -37,6 +37,14 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a9";
>  			reg = <0x300>;
> +			/* cpufreq controls */
> +			operating-points = <998400 0
> +					    800000 0
> +					    400000 0
> +					    200000 0>;
> +			clocks = <&prcmu_clk PRCMU_ARMSS>;
> +			clock-names = "cpu";
> +			clock-latency = <20000>;
>  		};
>  		CPU1: cpu at 301 {
>  			device_type = "cpu";
> @@ -494,13 +502,6 @@
>  				reg = <0x80157450 0xC>;
>  			};
>  
> -			cpufreq {
> -				compatible = "stericsson,cpufreq-ux500";
> -				clocks = <&prcmu_clk PRCMU_ARMSS>;
> -				clock-names = "armss";
> -				status = "disabled";
> -			};
> -

This is relieving :)

But this solution isn't the best really, though you may not face any
issues with your use case.

For example, below will fail cpufreq on your board. You can try that
to make sure I am not dreaming.

- Compile cpufreq-dt as a module.
- Boot the board.
- Offline CPU0 (i.e. Keep only CPU1 online).
- Boom, cpufreq failed.

This will happen because the CPU1 doesn't have the operating-points
and other properties. We should have them in all the CPUs.

In order to not repeat the OPP table for all CPUs, you can use the new
operating-points-v2 bindings and mark the OPP table shared.

-- 
viresh
