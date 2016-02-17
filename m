From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 16 Feb 2016 16:46:48 -0800
Subject: [RESEND PATCH v8 1/6] clk: hisilicon: add CRG driver for hi3519
 soc
In-Reply-To: <1454639472-17373-2-git-send-email-xuejiancheng@huawei.com>
References: <1454639472-17373-1-git-send-email-xuejiancheng@huawei.com>
 <1454639472-17373-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160217004648.2278.64006@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jiancheng Xue,

Quoting Jiancheng Xue (2016-02-04 18:31:07)
> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
> index 74dba31..3f57b09 100644
> --- a/drivers/clk/hisilicon/Makefile
> +++ b/drivers/clk/hisilicon/Makefile
> @@ -4,8 +4,10 @@
>  
>  obj-y  += clk.o clkgate-separated.o clkdivider-hi6220.o
>  
> +obj-$(CONFIG_RESET_CONTROLLER) += reset.o

Do you really want to build reset.o for all hisi SoCs?

>  obj-$(CONFIG_ARCH_HI3xxx)      += clk-hi3620.o
>  obj-$(CONFIG_ARCH_HIP04)       += clk-hip04.o
>  obj-$(CONFIG_ARCH_HIX5HD2)     += clk-hix5hd2.o
>  obj-$(CONFIG_COMMON_CLK_HI6220)        += clk-hi6220.o
>  obj-$(CONFIG_STUB_CLK_HI6220)  += clk-hi6220-stub.o
> +obj-$(CONFIG_COMMON_CLK_HI3519)        += clk-hi3519.o
> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
> new file mode 100644
> index 0000000..ed983af
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3519.c
> @@ -0,0 +1,133 @@
> +/*
> + * Hi3519 Clock Driver
> + *
> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <dt-bindings/clock/hi3519-clock.h>
> +#include <linux/delay.h>

Remove this header.

> +#include <linux/module.h>
> +#include <linux/of_address.h>

Remove this header.

> +#include <linux/of_platform.h>

Remove this header.

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

Remove this header.

> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 9f8e766..06ec3fe 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -37,7 +37,7 @@
>  
>  static DEFINE_SPINLOCK(hisi_clk_lock);
>  
> -struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
> +struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>                                              int nr_clks)
>  {
>         struct hisi_clock_data *clk_data;
> @@ -71,8 +71,9 @@ err_data:
>  err:
>         return NULL;
>  }
> +EXPORT_SYMBOL(hisi_clk_init);
>  
> -void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
> +void hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
>                                          int nums, struct hisi_clock_data *data)
>  {
>         struct clk *clk;
> @@ -91,8 +92,9 @@ void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_fixed_rate);
>  
> -void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
> +void hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
>                                            int nums,
>                                            struct hisi_clock_data *data)
>  {
> @@ -112,8 +114,9 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_fixed_factor);
>  
> -void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
> +void hisi_clk_register_mux(const struct hisi_mux_clock *clks,
>                                   int nums, struct hisi_clock_data *data)
>  {
>         struct clk *clk;
> @@ -141,8 +144,9 @@ void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_mux);
>  
> -void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
> +void hisi_clk_register_divider(const struct hisi_divider_clock *clks,
>                                       int nums, struct hisi_clock_data *data)
>  {
>         struct clk *clk;
> @@ -170,8 +174,9 @@ void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_divider);
>  
> -void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
> +void hisi_clk_register_gate(const struct hisi_gate_clock *clks,
>                                        int nums, struct hisi_clock_data *data)
>  {
>         struct clk *clk;
> @@ -198,8 +203,9 @@ void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_gate);
>  
> -void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
> +void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
>                                        int nums, struct hisi_clock_data *data)
>  {
>         struct clk *clk;
> @@ -226,8 +232,9 @@ void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
>                 data->clk_data.clks[clks[i].id] = clk;
>         }
>  }
> +EXPORT_SYMBOL(hisi_clk_register_gate_sep);
>  
> -void __init hi6220_clk_register_divider(struct hi6220_divider_clock *clks,
> +void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
>                                         int nums, struct hisi_clock_data *data)

It would have been better to break out all of the changes to clk.c into
a separate patch.

>  {
>         struct clk *clk;
> diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
> index b56fbc1..20d64af 100644
> --- a/drivers/clk/hisilicon/clk.h
> +++ b/drivers/clk/hisilicon/clk.h
> @@ -111,18 +111,18 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
>         u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
>  
>  struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
> -void hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
> +void hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
>                                 int, struct hisi_clock_data *);
> -void hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
> +void hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
>                                 int, struct hisi_clock_data *);
> -void hisi_clk_register_mux(struct hisi_mux_clock *, int,
> +void hisi_clk_register_mux(const struct hisi_mux_clock *, int,
>                                 struct hisi_clock_data *);
> -void hisi_clk_register_divider(struct hisi_divider_clock *,
> +void hisi_clk_register_divider(const struct hisi_divider_clock *,
>                                 int, struct hisi_clock_data *);
> -void hisi_clk_register_gate(struct hisi_gate_clock *,
> +void hisi_clk_register_gate(const struct hisi_gate_clock *,
>                                 int, struct hisi_clock_data *);
> -void hisi_clk_register_gate_sep(struct hisi_gate_clock *,
> +void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
>                                 int, struct hisi_clock_data *);
> -void hi6220_clk_register_divider(struct hi6220_divider_clock *,
> +void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
>                                 int, struct hisi_clock_data *);
>  #endif /* __HISI_CLK_H */

Ditto.

> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> new file mode 100644
> index 0000000..4fc7c8f
> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.c
> @@ -0,0 +1,130 @@
> +/*
> + * Hisilicon Reset Controller Driver
> + *
> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

I didn't look into these headers but I'm guessing they aren't all
needed?

Best regards,
Mike
