From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Sep 2011 15:16:42 +0200
Subject: [PATCH v4 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <1317171902-14736-4-git-send-email-pdeschrijver@nvidia.com>
References: <1317171902-14736-1-git-send-email-pdeschrijver@nvidia.com>
	<1317171902-14736-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <201109281516.42513.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Peter De Schrijver wrote:
> --- a/arch/arm/mach-tegra/board-dt.c
> +++ b/arch/arm/mach-tegra/board-dt.c
> @@ -47,7 +47,7 @@
>  
>  void harmony_pinmux_init(void);
>  void seaboard_pinmux_init(void);
> -
> +void ventana_pinmux_init(void);
>  
>  struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
>         OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
> @@ -95,6 +95,8 @@ static void __init tegra_dt_init(void)
>                 harmony_pinmux_init();
>         else if (of_machine_is_compatible("nvidia,seaboard"))
>                 seaboard_pinmux_init();
> +       else if (of_machine_is_compatible("nvidia,ventana"))
> +               ventana_pinmux_init();

Are you (Peter, Colin, Olof) confident that this is not getting out
of hand before it's getting better?

If we are keeping the per-board pinmux configuration in the kernel
for longer, I think it would be better to do this table-driven than
having a list of top-level of_machine_is_compatible() statements
and do something like:

static struct {
	const char *machine;
	struct tegra_pingroup_config *config[];
} pinmux_configs[] __initdata = {
	{ "nvidia,ventana", &ventana_pinmux },
	{ "nvidia,seaboard, &seaboard_pinmux },
};

	Arnd
