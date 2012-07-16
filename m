From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 16 Jul 2012 16:00:54 +0530
Subject: [PATCHv4 4/8] ARM: OMAP3: add manual control for mpu / core pwrdm
 usecounting
In-Reply-To: <1342189185-5306-5-git-send-email-t-kristo@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-5-git-send-email-t-kristo@ti.com>
Message-ID: <5003ED5E.4010202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> mpu / core powerdomain usecounts are now statically increased
> by 1 during MPU activity. This allows the domains to reflect
> actual usage, and will allow the usecount to reach 0 just before
> all CPUs are ready to idle. Proper powerdomain usecounts are
> propageted to voltagedomain level also, and will allow vc
> callbacks to be triggered at right point of time.
>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/pm34xx.c      |    3 ++
>   arch/arm/mach-omap2/pm44xx.c      |    3 ++
>   arch/arm/mach-omap2/powerdomain.c |   64 +++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/powerdomain.h |    3 ++
>   4 files changed, 73 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3a595e8..7c7b173 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -758,6 +758,9 @@ int __init omap3_pm_init(void)
>   	omap_pm_suspend = omap3_pm_suspend;
>   #endif
>
> +	/* Notify pwrdm usecounters about active CPU */
> +	pwrdm_cpu_wakeup();
> +

These internally increment/decrement usecount for MPU and CORE
but the name pwrdm_cpu_wakeup/idle seems somewhat misleading.
But I don't know either what would be a better name, so..

Reviewed-by: Rajendra Nayak <rnayak@ti.com>
