From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 14:39:48 +0100
Subject: [PATCH 1/6] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <1389283165-17708-2-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <52D29B24.3070601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Please see my comments inline.

On 09.01.2014 16:59, Thomas Abraham wrote:
[snip]
> @@ -69,12 +71,26 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>   		 new_freq / 1000, volt ? volt / 1000 : -1);
>
>   	/* scaling up?  scale voltage before frequency */
> -	if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
> +	if (!IS_ERR(cpu_reg) && new_freq > old_freq &&
> +				new_freq >= safe_frequency) {
>   		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
>   		if (ret) {
>   			pr_err("failed to scale voltage up: %d\n", ret);
>   			return ret;
>   		}
> +	} else if (!IS_ERR(cpu_reg) && old_freq < safe_frequency) {
> +		/*
> +		 * the scaled up voltage level for the new_freq is lower
> +		 * than the safe voltage level. so set safe_voltage
> +		 * as the intermediate voltage level and revert it
> +		 * back after the frequency has been changed.
> +		 */
> +		ret = regulator_set_voltage(cpu_reg, safe_voltage,
> +						safe_voltage);

Shouldn't the tolerance be used here as well?

> +		if (ret) {
> +			pr_err("failed to set safe voltage: %d\n", ret);
> +			return ret;
> +		}
>   	}
>
>   	ret = clk_set_rate(cpu_clk, freq_exact);
> @@ -94,6 +110,19 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>   		}
>   	}
>
> +	/*
> +	 * if safe voltage was applied during voltage scale up, then set
> +	 * the correct target voltage now.
> +	 */
> +	if (!IS_ERR(cpu_reg) && new_freq > old_freq &&
> +					new_freq < safe_frequency) {
> +		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
> +		if (ret) {
> +			pr_err("failed to scale voltage up: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +

I believe that it would be enough to reuse the if block of scaling down 
instead of repeating the same code, just the condition must be slightly 
modified:

-	/* scaling down?  scale voltage after frequency */
-	if (!IS_ERR(cpu_reg) && new_freq < old_freq) {
+	/*
+	 * scaling down or below safe frequency?
+	 * scale voltage after frequency
+	 */
+	if (!IS_ERR(cpu_reg)
+	    && (new_freq < old_freq || new_freq < safe_frequency)) {

Best regards,
Tomasz
