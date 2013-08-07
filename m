From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 11:42:49 -0600
Subject: [PATCH 2/6] ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0
 driver
In-Reply-To: <d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
Message-ID: <52028719.8070908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 08:46 AM, Viresh Kumar wrote:
> cpufreq-cpu0 driver needs OPPs to be present in DT which can be probed by it to
> get frequency table. This patch adds OPPs and clock-latency to tegra cpu0 node
> for multiple SoCs.
> 
> Voltage levels aren't used until now for tegra and so a flat value which would
> eventually be ignored is used to represent voltage.

This patch is problematic w.r.t. DT being an ABI.

We can certainly add new optional properties to a DT binding that enable
new features. However, a new version of a binding can't require new
properties to exist that didn't before, since that means that old DTs
won't work with new kernels that require the new properties.

As such, I believe we do need some Tegra-specific piece of code that
defines these OPP tables in the kernel, so that the operating-points
property is not needed.

Similarly, we can't put invalid voltages into the DT, since if a later
kernel version starts actually using that field, the HW will no longer
work correctly. Unless perhaps we put 0 into the DT and make the binding
define that 0 means "you can't change the voltage at all away from the
boot value"?

Is the operating-points property documented in
Documentation/devicetree/bindings/ somewhere?

(Also Cc'ing the DT mailing list and maintainers)

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index abf6c40..730e0d9 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -438,6 +438,18 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
> +			operating-points = <
> +				/* kHz    ignored */
> +				 216000   1000000
> +				 312000   1000000
> +				 456000   1000000
> +				 608000   1000000
> +				 760000   1000000
> +				 816000   1000000
> +				 912000   1000000
> +				 1000000  1000000
> +			>;
> +			clock-latency = <300000>;
>  		};
