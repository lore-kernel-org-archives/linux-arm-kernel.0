From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 6 May 2015 10:38:21 +0200
Subject: [PATCH 5/7] ARM: mediatek: add smp bringup code
In-Reply-To: <1430466210-22963-6-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430466210-22963-6-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeLbyzHfDqfdTh4Nh1ymg3=evKoQenLQ=VKhUkj55gGdVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-01 9:43 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> Add support for booting secondary CPUs on mt6589, mt8127
> and mt8135.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  arch/arm/mach-mediatek/Makefile  |   3 +
>  arch/arm/mach-mediatek/platsmp.c | 145 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+)
>  create mode 100644 arch/arm/mach-mediatek/platsmp.c
>
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 43e619f..2116460 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -1 +1,4 @@
> +ifeq ($(CONFIG_SMP),y)
> +obj-$(CONFIG_ARCH_MEDIATEK) += platsmp.o
> +endif
>  obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
> diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
> new file mode 100644
> index 0000000..e266b3d
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/platsmp.c
> @@ -0,0 +1,145 @@
> +/*
> + * arch/arm/mach-mediatek/platsmp.c
> + *
> + * Copyright (c) 2014 Mediatek Inc.
> + * Author: Shunli Wang <shunli.wang@mediatek.com>
> + *         Yingjoe Chen <yingjoe.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/threads.h>
> +
> +#define MTK_MAX_CPU            8
> +#define MTK_SMP_REG_SIZE       0x1000
> +
> +struct mtk_smp_boot_info {
> +       unsigned long smp_base;
> +       unsigned int jump_reg;
> +       unsigned int boot_reg;

This variable is not used, right?

> +       unsigned int core_keys[MTK_MAX_CPU - 1];
> +       unsigned int core_regs[MTK_MAX_CPU - 1];
> +};
> +
> +static const struct mtk_smp_boot_info mtk_mt8135_tz_boot = {
> +       0x80002000, 1020, 1012,
> +       { 0x534c4131, 0x4c415332, 0x41534c33 },
> +       { 1016, 1016, 1016},

Please convert to hex values.

-- 
motzblog.wordpress.com
