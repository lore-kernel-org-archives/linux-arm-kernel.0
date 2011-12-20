From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 14:41:32 +0000
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111220144132.GA29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 06:30:59PM +0800, Richard Zhao wrote:

> +
> +	if (higher && cpu_reg)
> +		regulator_set_voltage(cpu_reg,
> +				cpu_volts[index], cpu_volts[index]);

This is really bad, you're only supporting the configuration of a
specific voltage which doesn't reflect what hardware does (things will
be specified as a range of voltages) and will needlessly cause
interoperability problems between chips and regulators if the regulator
can't hit the *exact* voltage requested.  There's a good solid reason
why the regulator API specifies everything in terms of voltage ranges.

> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret != 0) {
> +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> +		return ret;
> +	}

This error checking is really random - you're ignoring some errors and
logging the errors you do detect as debug messages which seems odd.
Similar issues apply throughough.

> +	if (cpu_volts) {
> +		cpu_reg = regulator_get(NULL, "cpu");
> +		if (IS_ERR(cpu_reg)) {
> +			printk(KERN_WARNING
> +				"cpufreq: regulator cpu get failed.\n");
> +			cpu_reg = NULL;
> +		}
> +	}

You should log what the error was.  You're also not doing anything to
check that the voltage ranges required by the frequencies are actually
supported on this system, the driver should double check this so that
governors don't sit there trying to set voltages that are impossible on
a given board.
