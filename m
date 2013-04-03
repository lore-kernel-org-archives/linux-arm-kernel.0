From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 13:49:18 -0700
Subject: [PATCH v2 08/18] ARM: OMAP5: PM: Add CPU power off in hotplug path
In-Reply-To: <1364205910-32392-9-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:00 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-9-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <876203uypd.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Add power management code to handle the CPU off mode to enable CPUP hotplug
> mode for OMAP5 devices. Separate suspend finisher is used for OMAP5(Cortex-A15)
> because it doesn't use SCU power status register and external PL310 L2 cache
> which makes code flow bit different.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> @@ -436,14 +445,21 @@ int __init omap4_mpuss_init(void)
>  
>  	if (cpu_is_omap44xx()) {
>  		omap_pm_ops.finish_suspend = omap4_finish_suspend;
> +		omap_pm_ops.hotplug_restart = omap_secondary_startup;
>  		omap_pm_ops.resume = omap4_cpu_resume;
>  		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
>  		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
>  	} else if (soc_is_omap54xx()) {
> +		omap_pm_ops.finish_suspend = omap5_finish_suspend;
> +		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
>  		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
>  		enable_mercury_retention_mode();
>  	}
>  
> +	/* Over-write the OMAP4 hook to take care of ROM BUG */
> +	if (cpu_is_omap446x())
> +		omap_pm_ops.hotplug_restart = omap_secondary_startup_4460;

A couple nits...

I think this would go better at the end of the 'if omap44xx' block
above.

Also, while you're hear, maybe it's time to rename the current secondary 
startup functions to match the new one.  IOW omap4_..., omap4460_... and omap5_...

Kevin
