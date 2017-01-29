From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:40:53 -0800
Subject: [PATCH v2 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <20161115223900.30728-3-heiko@sntech.de>
References: <20161115223900.30728-1-heiko@sntech.de>
 <20161115223900.30728-3-heiko@sntech.de>
Message-ID: <CAOesGMjq3uPqaWjMkEkqXs9W90XTwXknjheZNdYsOaGu4fw9_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,



On Tue, Nov 15, 2016 at 2:38 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The General Register Files are an area of registers containing a lot
> of single-bit settings for numerous components as well full components
> like usbphy control. Therefore all used components are accessed
> via the syscon provided by the grf nodes or from the sub-devices
> created through the simple-mfd created from the grf node.
>
> Some settings are not used by anything but will need to be set up
> according to expectations on the kernel side.
>
> Best example is the force_jtag setting, which defaults to on and
> results in the soc switching the pin-outputs between jtag and sdmmc
> automatically depending on the card-detect status. This conflicts
> heavily with how the dw_mmc driver expects to do its work and also
> with the clock-controller, which has most likely deactivated the
> jtag clock due to it being unused.
>
> So far the handling of this setting was living in the mach-rockchip
> code for the arm32-based rk3288 but that of course doesn't work
> for arm64 socs and would also look ugly for further arm32 socs.
>
> Also always disabling this setting is quite specific to linux and
> its subsystems, other operating systems might prefer other settings,
> so that the bootloader cannot really set a sane default for all.
>
> So introduce a top-level driver for the grf that handles these
> settings that need to be a certain way but nobody cares about.
>
> Other needed settings might surface in the future and can then
> be added here, but only as a last option. Ideally general GRF
> settings should be handled in the driver needing them.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/soc/rockchip/Kconfig  |  10 ++++
>  drivers/soc/rockchip/Makefile |   1 +
>  drivers/soc/rockchip/grf.c    | 134 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/soc/rockchip/grf.c
>
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 7140ff8..20da55d 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -3,6 +3,16 @@ if ARCH_ROCKCHIP || COMPILE_TEST
>  #
>  # Rockchip Soc drivers
>  #
> +
> +config ROCKCHIP_GRF
> +       bool
> +       default y
> +       help
> +         The General Register Files are a central component providing
> +         special additional settings registers for a lot of soc-components.
> +         In a lot of cases there also need to be default settings initialized
> +         to make some of them conform to expectations of the kernel.
> +
>  config ROCKCHIP_PM_DOMAINS
>          bool "Rockchip generic power domain"
>          depends on PM
> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
> index 3d73d06..c851fa0 100644
> --- a/drivers/soc/rockchip/Makefile
> +++ b/drivers/soc/rockchip/Makefile
> @@ -1,4 +1,5 @@
>  #
>  # Rockchip Soc drivers
>  #
> +obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>  obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> new file mode 100644
> index 0000000..0c85476a
> --- /dev/null
> +++ b/drivers/soc/rockchip/grf.c
> @@ -0,0 +1,134 @@
> +/*
> + * Rockchip Generic Register Files setup
> + *
> + * Copyright (c) 2016 Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define HIWORD_UPDATE(val, mask, shift) \
> +               ((val) << (shift) | (mask) << ((shift) + 16))
> +
> +struct rockchip_grf_value {
> +       const char *desc;
> +       u32 reg;
> +       u32 val;
> +};
> +
> +struct rockchip_grf_info {
> +       const struct rockchip_grf_value *values;
> +       int num_values;
> +};
> +
> +#define RK3036_GRF_SOC_CON0            0x140
> +
> +static const struct rockchip_grf_value rk3036_defaults[] __initconst = {
> +       /*
> +        * Disable auto jtag/sdmmc switching that causes issues with the
> +        * clock-framework and the mmc controllers making them unreliable.
> +        */
> +       { "jtag switching", RK3036_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 11) },
> +};
> +
> +static const struct rockchip_grf_info rk3036_grf __initconst = {
> +       .values = rk3036_defaults,
> +       .num_values = ARRAY_SIZE(rk3036_defaults),
> +};
> +
> +#define RK3288_GRF_SOC_CON0            0x244
> +
> +static const struct rockchip_grf_value rk3288_defaults[] __initconst = {
> +       { "jtag switching", RK3288_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 12) },
> +};
> +
> +static const struct rockchip_grf_info rk3288_grf __initconst = {
> +       .values = rk3288_defaults,
> +       .num_values = ARRAY_SIZE(rk3288_defaults),
> +};
> +
> +#define RK3368_GRF_SOC_CON15           0x43c
> +
> +static const struct rockchip_grf_value rk3368_defaults[] __initconst = {
> +       { "jtag switching", RK3368_GRF_SOC_CON15, HIWORD_UPDATE(0, 1, 13) },
> +};
> +
> +static const struct rockchip_grf_info rk3368_grf __initconst = {
> +       .values = rk3368_defaults,
> +       .num_values = ARRAY_SIZE(rk3368_defaults),
> +};
> +
> +#define RK3399_GRF_SOC_CON7            0xe21c
> +
> +static const struct rockchip_grf_value rk3399_defaults[] __initconst = {
> +       { "jtag switching", RK3399_GRF_SOC_CON7, HIWORD_UPDATE(0, 1, 12) },
> +};
> +
> +static const struct rockchip_grf_info rk3399_grf __initconst = {
> +       .values = rk3399_defaults,
> +       .num_values = ARRAY_SIZE(rk3399_defaults),
> +};
> +
> +static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
> +       {
> +               .compatible = "rockchip,rk3036-grf",
> +               .data = (void *)&rk3036_grf,
> +       }, {
> +               .compatible = "rockchip,rk3288-grf",
> +               .data = (void *)&rk3288_grf,
> +       }, {
> +               .compatible = "rockchip,rk3368-grf",
> +               .data = (void *)&rk3368_grf,
> +       }, {
> +               .compatible = "rockchip,rk3399-grf",
> +               .data = (void *)&rk3399_grf,
> +       },
> +       { /* sentinel */ },
> +};

I often come in after there's already been discussion on a topic, and
don't always find all of it, so let me know if this has already been
considered and not chosen for some reason:


I get a little worried when you see these per-SoC tables build up in
the kernel. It means there'll need to be additions here for a bunch of
different SoCs.

Would it be possible to describe this directly in the DT instead? If
nothing else, something like

function-regs = < array of regs >
function-values = < array of values >
function-names = < array of names >

Not ideal either, especially if abused into a random poke table, but
it won't require per-SoC changes to the kernel. If we keep the binding
under close eyes we can hopefully avoid abuse.

Given that Rockchip is still working on new SoCs, this list will just
grow and doing it in-kernel will stop scaling at some point.


-Olof
