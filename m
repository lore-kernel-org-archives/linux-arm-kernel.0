From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Dec 2017 08:28:46 +0100
Subject: [PATCH v2 4/7] cpufreq: mvebu: Use dev_pm_opp_remove()
In-Reply-To: <20171207135616.23670-5-gregory.clement@free-electrons.com>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-5-gregory.clement@free-electrons.com>
Message-ID: <20171212082846.4e201953@windsurf.png.is.keysight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu,  7 Dec 2017 14:56:13 +0100, Gregory CLEMENT wrote:

> -		/*
> -		 * In case of a failure of dev_pm_opp_add(), we don't
> -		 * bother with cleaning up the registered OPP (there's
> -		 * no function to do so), and simply cancel the
> -		 * registration of the cpufreq device.
> -		 */
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
>  		if (ret) {
>  			clk_put(clk);
> @@ -90,6 +84,11 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
>  		if (ret) {
> +			/*
> +			 * The second opp failed to be added, remove
> +			 * the first one before exiting.
> +			 */
> +			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
>  			clk_put(clk);
>  			return ret;
>  		}

This still doesn't fix the failure situation. Indeed, you are only
removing the OPP at full rate for the current CPU, but you are not
removing the OPPs for the N-1 previous CPUs that have been handled in
previous iterations of the loop.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
