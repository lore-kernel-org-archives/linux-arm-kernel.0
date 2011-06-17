From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2011 16:56:10 +0200
Subject: [RFC PATCH 01/16] ARM: local timers: early device probing hooks
In-Reply-To: <1308251204-16719-2-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<1308251204-16719-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <201106171656.10745.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011, Marc Zyngier wrote:
> @@ -147,6 +148,19 @@ static int __init timer_init_syscore_ops(void)
>  
>  device_initcall(timer_init_syscore_ops);
>  
> +void (* __initdata arm_late_time_init)(void);
> +
> +static void __init __arm_late_time_init(void)
> +{
> +       if (arm_late_time_init)
> +               arm_late_time_init();
> +
> +#ifdef CONFIG_LOCAL_TIMER_DEVICES
> +       early_platform_driver_register_all("localtimer");
> +       early_platform_driver_probe("localtimer", 1, 0);
> +#endif
> +}
> +
>  void __init time_init(void)
>  {
>         system_timer = machine_desc->timer;

Instead of having two separate global pointers, should we make the ARM specific
callback a machine_desc callback?

	Arnd
