From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 10:41:53 +0200
Subject: [PATCH 11/12] cpuidle: mvebu: Add initial cpu idle support for
 Armada 370/XP SoC
In-Reply-To: <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
 <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <52172051.2030505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2013 08:53, Gregory CLEMENT wrote:
> Add wfi/cpu idle/cpu deep idle power states support for Armada XP SoC.
> 
> All the latencies and the power consumption values used at the
> "armada_370_xp_idle_driver" structure are preliminary and will be
> modified in the future after running some measurements and analysis.
> 
> Based on the work of Nadav Haklai.

Atsushi Yamagata reported me an kernel crash when pm_support=off.
Indeed I have lost a small chunk of code during my code reshaping.
The following code will fix the issue. I will add it in the next
version of this series.

[...]
> +
> +	if (pm_support == WFI)
> +		pr_info(" (WFI)\n");
> +	else if (pm_support == MV_CPU_IDLE)
> +		pr_info(" (CPU_IDLE)\n");
> +	else if (pm_support == MV_CPU_DEEP_IDLE)
> +		pr_info(" (CPU_DEEP_IDLE)\n");


> +	else
> +		pr_info(" (DISABLED)\n");
Will be replaced by
+       else {
+                       pr_info(" (DISABLED)\n");
+                       return; /* do not register the cpuidle device */
+       }

> +
> +	armada_370_xp_idle_driver.state_count = pm_support + 1;
> +
> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +}
> +

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
