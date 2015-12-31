From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 30 Dec 2015 17:35:11 -0800
Subject: [PATCH v2,
 RESEND] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <1451298058-28910-1-git-send-email-yamada.masahiro@socionext.com>
References: <1451298058-28910-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151231013511.21505.59601@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yamada-san,

Quoting Masahiro Yamada (2015-12-28 02:20:58)
> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
> new file mode 100644
> index 0000000..7606f27
> --- /dev/null
> +++ b/drivers/clk/uniphier/Kconfig
> @@ -0,0 +1,35 @@
> +menuconfig CLK_UNIPHIER
> +       bool "Clock drivers for UniPhier SoCs"
> +       depends on ARCH_UNIPHIER

Might want to make the above line:

	depends on ARCH_UNIPHIER || COMPILE_TEST

> +       depends on OF
> +       default y
> +       help
> +         Supports clock drivers for UniPhier SoCs.

Why menuconfig? Can we make this a non-visible config option selected by
the UniPhier platform?

> +
> +if CLK_UNIPHIER

Please drop the if statement here and have the below options 'depends'
on CLK_UNIPHIER.

> +
> +config CLK_UNIPHIER_PH1_SLD3
> +       bool "Clock driver for UniPhier PH1-sLD3 SoC"
> +       default y

Can you make these drivers into loadable modules? If so you might
consider tristate.

> +
> +config CLK_UNIPHIER_PH1_LD4
> +       bool "Clock driver for UniPhier PH1-LD4 SoC"
> +       default y
> +
> +config CLK_UNIPHIER_PH1_PRO4
> +       bool "Clock driver for UniPhier PH1-Pro4 SoC"
> +       default y
> +
> +config CLK_UNIPHIER_PH1_SLD8
> +       bool "Clock driver for UniPhier PH1-sLD8 SoC"
> +       default y
> +
> +config CLK_UNIPHIER_PH1_PRO5
> +       bool "Clock driver for UniPhier PH1-Pro5 SoC"
> +       default y
> +
> +config CLK_UNIPHIER_PROXSTREAM2
> +       bool "Clock driver for UniPhier ProXstream2/PH1-LD6b SoC"
> +       default y
> +
> +endif
> diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
> new file mode 100644
> index 0000000..3be1a17
> --- /dev/null
> +++ b/drivers/clk/uniphier/Makefile
> @@ -0,0 +1,10 @@
> +obj-y += clk-uniphier-core.o
> +obj-y += clk-uniphier-peri.o
> +obj-y += clk-uniphier-mio.o
> +
> +obj-$(CONFIG_CLK_UNIPHIER_PH1_SLD3)    += clk-ph1-sld3.o
> +obj-$(CONFIG_CLK_UNIPHIER_PH1_LD4)     += clk-ph1-ld4.o
> +obj-$(CONFIG_CLK_UNIPHIER_PH1_PRO4)    += clk-ph1-pro4.o
> +obj-$(CONFIG_CLK_UNIPHIER_PH1_SLD8)    += clk-ph1-sld8.o
> +obj-$(CONFIG_CLK_UNIPHIER_PH1_PRO5)    += clk-ph1-pro5.o
> +obj-$(CONFIG_CLK_UNIPHIER_PROXSTREAM2) += clk-proxstream2.o
> diff --git a/drivers/clk/uniphier/clk-ph1-ld4.c b/drivers/clk/uniphier/clk-ph1-ld4.c
> new file mode 100644
> index 0000000..48d342f
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-ph1-ld4.c
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data ph1_ld4_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 65,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "upll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 288000,
> +                       .div = 24576,
> +               },
> +       },
> +       {
> +               .name = "a2pll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 24,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "a2pll",
> +                       .mult = 1,
> +                       .div = 16,
> +               },
> +       },
> +       {
> +               .name = "i2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 16,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 32,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = NULL,
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "ehci",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 18,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 1,
> +                       .div = 12,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init ph1_ld4_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, ph1_ld4_clk_idata);
> +}
> +CLK_OF_DECLARE(ph1_ld4_clk, "socionext,ph1-ld4-sysctrl", ph1_ld4_clk_init);

Can you avoid using CLK_OF_DECLARE and instead make this into a
platform_driver? For examples please see drivers/clk/qcom*.c

> diff --git a/drivers/clk/uniphier/clk-ph1-pro4.c b/drivers/clk/uniphier/clk-ph1-pro4.c
> new file mode 100644
> index 0000000..052813a
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-ph1-pro4.c
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data ph1_pro4_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 64,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "upll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 288,
> +                       .div = 25,
> +               },
> +       },
> +       {
> +               .name = "a2pll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 256,
> +                       .div = 125,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "a2pll",
> +                       .mult = 1,
> +                       .div = 8,
> +               },
> +       },
> +       {
> +               .name = "fi2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 32,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 32,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "ehci",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 18,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 1,
> +                       .div = 12,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init ph1_pro4_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, ph1_pro4_clk_idata);
> +}
> +CLK_OF_DECLARE(ph1_pro4_clk, "socionext,ph1-pro4-sysctrl", ph1_pro4_clk_init);

Ditto.

> diff --git a/drivers/clk/uniphier/clk-ph1-pro5.c b/drivers/clk/uniphier/clk-ph1-pro5.c
> new file mode 100644
> index 0000000..9f782d9
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-ph1-pro5.c
> @@ -0,0 +1,107 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data ph1_pro5_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 120,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "dapll1",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 128,
> +                       .div = 125,
> +               },
> +       },
> +       {
> +               .name = "dapll2",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 144,
> +                       .div = 5,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "dapll2",
> +                       .mult = 1,
> +                       .div = 8,
> +               },
> +       },
> +       {
> +               .name = "fi2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 48,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 48,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = NULL,
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init ph1_pro5_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, ph1_pro5_clk_idata);
> +}
> +CLK_OF_DECLARE(ph1_pro5_clk, "socionext,ph1-pro5-sysctrl", ph1_pro5_clk_init);

Ditto.

> diff --git a/drivers/clk/uniphier/clk-ph1-sld3.c b/drivers/clk/uniphier/clk-ph1-sld3.c
> new file mode 100644
> index 0000000..7249a81
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-ph1-sld3.c
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data ph1_sld3_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 65,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "upll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 288000,
> +                       .div = 24576,
> +               },
> +       },
> +       {
> +               .name = "a2pll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 24,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "a2pll",
> +                       .mult = 1,
> +                       .div = 16,
> +               },
> +       },
> +       {
> +               .name = "i2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 16,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 32,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "ehci",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 18,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 1,
> +                       .div = 12,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init ph1_sld3_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, ph1_sld3_clk_idata);
> +}
> +CLK_OF_DECLARE(ph1_sld3_clk, "socionext,ph1-sld3-sysctrl", ph1_sld3_clk_init);

Ditto.

> diff --git a/drivers/clk/uniphier/clk-ph1-sld8.c b/drivers/clk/uniphier/clk-ph1-sld8.c
> new file mode 100644
> index 0000000..bfebd38
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-ph1-sld8.c
> @@ -0,0 +1,107 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data ph1_sld8_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 64,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "upll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 288,
> +                       .div = 25,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 20,
> +               },
> +       },
> +       {
> +               .name = "i2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 16,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 32,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = NULL,
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "ehci",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 18,
> +               .data.factor = {
> +                       .parent_name = "upll",
> +                       .mult = 1,
> +                       .div = 12,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init ph1_sld8_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, ph1_sld8_clk_idata);
> +}
> +CLK_OF_DECLARE(ph1_sld8_clk, "socionext,ph1-sld8-sysctrl", ph1_sld8_clk_init);

Ditto.

> diff --git a/drivers/clk/uniphier/clk-proxstream2.c b/drivers/clk/uniphier/clk-proxstream2.c
> new file mode 100644
> index 0000000..b3ffedc
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-proxstream2.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct uniphier_clk_init_data proxstream2_clk_idata[] __initdata = {
> +       {
> +               .name = "spll",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = -1,
> +               .data.factor = {
> +                       .parent_name = UNIPHIER_CLK_EXT "ref",
> +                       .mult = 96,
> +                       .div = 1,
> +               },
> +       },
> +       {
> +               .name = "uart",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 3,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 27,
> +               },
> +       },
> +       {
> +               .name = "fi2c",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 4,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 48,
> +               },
> +       },
> +       {
> +               .name = "arm-scu",
> +               .type = UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +               .output_index = 7,
> +               .data.factor = {
> +                       .parent_name = "spll",
> +                       .mult = 1,
> +                       .div = 48,
> +               },
> +       },
> +       {
> +               .name = "stdmac-clken",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = -1,
> +               .data.gate = {
> +                       .parent_name = NULL,
> +                       .reg = 0x2104,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       {
> +               .name = "stdmac",
> +               .type = UNIPHIER_CLK_TYPE_GATE,
> +               .output_index = 10,
> +               .data.gate = {
> +                       .parent_name = "stdmac-clken",
> +                       .reg = 0x2000,
> +                       .bit_idx = 10,
> +               },
> +       },
> +       { /* sentinel */ }
> +};
> +
> +static void __init proxstream2_clk_init(struct device_node *np)
> +{
> +       uniphier_clk_init(np, proxstream2_clk_idata);
> +}
> +CLK_OF_DECLARE(proxstream2_clk, "socionext,proxstream2-sysctrl",
> +              proxstream2_clk_init);

Ditto.

> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> new file mode 100644
> index 0000000..8680101
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -0,0 +1,151 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt)            "uniphier-clk: " fmt
> +
> +#include <linux/clk-provider.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk-uniphier.h"
> +
> +static void __init uniphier_clk_update_parent_name(struct device_node *np,
> +                                                  const char **parent_name)
> +{
> +       const char *new_name;
> +       int index;
> +
> +       if (!parent_name || !*parent_name)
> +               return;
> +
> +       if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
> +               return;
> +
> +       index = of_property_match_string(np, "clock-names",
> +                               *parent_name + strlen(UNIPHIER_CLK_EXT));
> +       new_name = of_clk_get_parent_name(np, index);
> +       if (new_name)
> +               *parent_name = new_name;

Where can I find the DT binding description and DTS for this clock
controller? I'm confused why the parent name function is necessary and
I'd like to see the data.

Regards,
Mike
