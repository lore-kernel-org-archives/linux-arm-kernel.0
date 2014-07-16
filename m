From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 13:56:44 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-13-git-send-email-thierry.reding@gmail.com>
Message-ID: <201407161356.44693.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 July 2014, Thierry Reding wrote:
> +/*
> + * PMC
> + */
> +enum tegra_suspend_mode {
> +       TEGRA_SUSPEND_NONE = 0,
> +       TEGRA_SUSPEND_LP2, /* CPU voltage off */
> +       TEGRA_SUSPEND_LP1, /* CPU voltage off, DRAM self-refresh */
> +       TEGRA_SUSPEND_LP0, /* CPU + core voltage off, DRAM self-refresh */
> +       TEGRA_MAX_SUSPEND_MODE,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
> +void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
> +void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
> +
> +bool tegra_pmc_cpu_is_powered(int cpuid);
> +int tegra_pmc_cpu_power_on(int cpuid);
> +int tegra_pmc_cpu_remove_clamping(int cpuid);
> +
> +void tegra_pmc_restart(enum reboot_mode mode, const char *cmd);
> +#endif
> +
> +/*

This part is causing multiple build failures in the randconfig tests.
You can avoid them by removing the #ifdef.

On a more general note, why are you adding this stuff into a global
header file in the first place? All users are in the same directory
in which the functions are defined.

	Arnd
