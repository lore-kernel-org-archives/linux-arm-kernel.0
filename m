From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Mon, 14 Jan 2013 08:43:35 -0700
Subject: [PATCH v3 1/2] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
References: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
 <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <50F427A7.7000203@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 01/14/2013 08:02 AM, Shawn Guo wrote:
> Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> hardware specific frequency and voltage scaling requirements.
>
>
 > <snip>
 >
> --- /dev/null
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -0,0 +1,296 @@
>
> <snip>
>
> +
> +static int imx6q_set_target(struct cpufreq_policy *policy,
> +			    unsigned int target_freq, unsigned int relation)
> +{
>
> <snip>
>
> +
> +	/* scaling up?  scale voltage before frequency */
> +	if (freqs.new > freqs.old) {
> +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to scale voltage up: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Need to increase vddpu and vddsoc for safety
> +		 * if we are about to run at 1.2 GHz.
> +		 */
> +		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> +			regulator_set_voltage_tol(pu_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);
> +			regulator_set_voltage_tol(soc_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);
> +		}

I believe you need a delay here to let the LDOs ramp before changing
the CPU frequency.

According to the i.MX6Q reference manual, with the factory default
step times in PMU_MISC2 and the maximum voltage swing is
	1.25V (1.2GHz) - 0.95V (400MHz) == 0.325V

or 13 steps at 25mV.

The default step time is 0.000021333s (512 clocks at 24MHz), so
the worst case delay needed is ~280uS.

This could also be done in the regulator driver, but that may
require multiple delays if multiple rails are changed.

Regards,


Eric
