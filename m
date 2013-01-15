From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 Jan 2013 22:53:57 +0800
Subject: [PATCH v3 1/2] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <50F427A7.7000203@boundarydevices.com>
References: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
 <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
 <50F427A7.7000203@boundarydevices.com>
Message-ID: <20130115145356.GD6574@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, Jan 14, 2013 at 08:43:35AM -0700, Eric Nelson wrote:
> >+	/* scaling up?  scale voltage before frequency */
> >+	if (freqs.new > freqs.old) {
> >+		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> >+		if (ret) {
> >+			dev_err(cpu_dev, "failed to scale voltage up: %d\n", ret);
> >+			return ret;
> >+		}
> >+
> >+		/*
> >+		 * Need to increase vddpu and vddsoc for safety
> >+		 * if we are about to run at 1.2 GHz.
> >+		 */
> >+		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> >+			regulator_set_voltage_tol(pu_reg,
> >+					PU_SOC_VOLTAGE_HIGH, 0);
> >+			regulator_set_voltage_tol(soc_reg,
> >+					PU_SOC_VOLTAGE_HIGH, 0);
> >+		}
> 
> I believe you need a delay here to let the LDOs ramp before changing
> the CPU frequency.
> 
> According to the i.MX6Q reference manual, with the factory default
> step times in PMU_MISC2 and the maximum voltage swing is
> 	1.25V (1.2GHz) - 0.95V (400MHz) == 0.325V
> 
> or 13 steps at 25mV.
> 
> The default step time is 0.000021333s (512 clocks at 24MHz), so
> the worst case delay needed is ~280uS.
> 
> This could also be done in the regulator driver, but that may
> require multiple delays if multiple rails are changed.
> 
I initially thought that regulator driver should take care of it.  But
now I agree with you that we can do it here for the least latency.

Will roll it into v4.  Thanks.

Shawn
