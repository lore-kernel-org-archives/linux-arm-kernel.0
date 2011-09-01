From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Sep 2011 18:00:55 +0200
Subject: [PATCH 1/1] OMAP: omap_device: only override _noirq methods,
	not normal suspend/resume
In-Reply-To: <1314229437-31836-2-git-send-email-khilman@ti.com>
References: <1314229437-31836-1-git-send-email-khilman@ti.com>
	<1314229437-31836-2-git-send-email-khilman@ti.com>
Message-ID: <201109011800.55516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011, Kevin Hilman wrote:
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -622,7 +622,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
>                                    _od_runtime_idle)
>                 USE_PLATFORM_PM_SLEEP_OPS
> -               SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
> +               .suspend_noirq = _od_suspend_noirq,
> +               .resume_noirq = _od_resume_noirq,
>         }
>  };

This breaks if CONFIG_SUSPEND is not set and the _od_suspend_noirq/_od_resume_noirq
functions are not defined.

	Arnd
