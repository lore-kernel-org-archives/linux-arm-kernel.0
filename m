From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Mar 2015 12:12:52 +0200
Subject: [PATCH 3/6] clk: mediatek: Add reset controller support
In-Reply-To: <1427447925-18030-4-git-send-email-s.hauer@pengutronix.de>
References: <1427447925-18030-1-git-send-email-s.hauer@pengutronix.de>
 <1427447925-18030-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBe+4mQ+gmEgBudpwMYLo7NLX1uJXx37nW1UtzOsY2x_WnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-27 10:18 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> The pericfg and infracfg units also provide reset lines to several
> other SoC internal units. Add support for the reset controller.

This messages is a bit confusing, could you explain better what the
patch does and how this interacts with pericfg and infracfg?

>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/mediatek/Makefile  |  1 +
>  drivers/clk/mediatek/clk-mtk.h | 10 +++++
>  drivers/clk/mediatek/reset.c   | 99 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 drivers/clk/mediatek/reset.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index c384e97..0b6f1c3 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-y += clk-mtk.o clk-pll.o clk-gate.o
> +obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 5aaba81..5a6b5dd 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -152,4 +152,14 @@ void __init mtk_clk_register_plls(struct device_node *node,
>                 const struct mtk_pll_data *plls, int num_plls,
>                 struct clk_onecell_data *clk_data);
>
> +#ifdef CONFIG_RESET_CONTROLLER
> +void mtk_register_reset_controller(struct device_node *np,
> +                       unsigned int num_regs, int regofs);
> +#else
> +static inline void mtk_register_reset_controller(struct device_node *np,
> +                       unsigned int num_regs, int regofs)
> +{
> +}
> +#endif
> +
>  #endif /* __DRV_CLK_MTK_H */
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> new file mode 100644
> index 0000000..3a85a53
> --- /dev/null
> +++ b/drivers/clk/mediatek/reset.c
> @@ -0,0 +1,99 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Do we need this? Seems that it isn't used at all.

Cheers,
Matthias
