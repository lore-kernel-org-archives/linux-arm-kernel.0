From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Dec 2014 12:03:24 -0500
Subject: [PATCH] ARM: mvebu: use the cpufreq-dt platform_data for
 independent clocks
In-Reply-To: <1417538882-19254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1417538882-19254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141202170324.GY22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, ThomasP,

On Tue, Dec 02, 2014 at 05:48:02PM +0100, Thomas Petazzoni wrote:
> This commit adjusts the registration of the cpufreq-dt driver in the
> mvebu platform to indicate to the cpufreq driver that the platform has
> independent clocks for each CPU.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Jason, this commit was part of my "[PATCHv2 0/4] cpufreq-dt,
> platform_data based proposal" series, which included 3 patches for
> drivers/cpufreq/, and this last patch for mach-mvebu to make use of
> the new cpufreq feature. However, in order to not confuse the cpufreq
> maintainer, when I sent "[PATCH v3 0/3] cpufreq: cpufreq-dt:
> platform_data based proposal", I didn't include this patch for
> mach-mvebu.
> 
> But now, it means that this is the only missing piece to get cpufreq
> working on Armada XP. Do you think you could squeeze it into the
> things merged for 3.19 ? It's a very small patch, so hopefully it's
> still possible to do so.

I have no problem with it except logistical.  :(  I'm currently on
travel and my well-tested, but hacked up connection to my development
box went down.  I've no way to apply this until this weekend at best.

Acked-by; Jason Cooper <jason@lakedaemon.net>

Arnd, would you mind taking this directly onto mvebu/soc?  I've nothing
else in the queue (just the one pending pull request for soc-suspend)

Or, would it be acceptable for this to be /fixes-non-critical for -rc1?


thx,

Jason.

> The patch is based on mvebu/soc.
> ---
>  arch/arm/mach-mvebu/pmsu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 5a757f9..d8ab605 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpu_pm.h>
> +#include <linux/cpufreq-dt.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -571,6 +572,10 @@ int mvebu_pmsu_dfs_request(int cpu)
>  	return 0;
>  }
>  
> +struct cpufreq_dt_platform_data cpufreq_dt_pd = {
> +	.independent_clocks = true,
> +};
> +
>  static int __init armada_xp_pmsu_cpufreq_init(void)
>  {
>  	struct device_node *np;
> @@ -643,7 +648,8 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  		}
>  	}
>  
> -	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	platform_device_register_data(NULL, "cpufreq-dt", -1,
> +				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
>  	return 0;
>  }
>  
> -- 
> 2.1.0
> 
