From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 8 Jul 2011 08:51:17 -0600
Subject: [PATCH] of: add devicetree API for regulator
In-Reply-To: <1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACxGe6teb+-xYGUXAcjwubxNhNQ-9395PjjE=fDnmZQHbgR0tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Fri, Jul 8, 2011 at 4:20 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

No commit description?

> ---
> ?drivers/of/Kconfig ? ? ? ? ? | ? ?4 +
> ?drivers/of/Makefile ? ? ? ? ?| ? ?1 +
> ?drivers/of/of_regulator.c ? ?| ?166 ++++++++++++++++++++++++++++++++++++++++++
> ?include/linux/of_regulator.h | ? 34 +++++++++
> ?4 files changed, 205 insertions(+), 0 deletions(-)
> ?create mode 100644 drivers/of/of_regulator.c
> ?create mode 100644 include/linux/of_regulator.h
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index d06a637..edb6601 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -75,4 +75,8 @@ config OF_PCI
> ? ? ? ?help
> ? ? ? ? ?OpenFirmware PCI bus accessors
>
> +config OF_REGULATOR
> + ? ? ? def_tristate REGULATOR
> + ? ? ? depends on REGULATOR
> +
> ?endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index f7861ed..83ca06f 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_NET) ?+= of_net.o
> ?obj-$(CONFIG_OF_SPI) ? += of_spi.o
> ?obj-$(CONFIG_OF_MDIO) ?+= of_mdio.o
> ?obj-$(CONFIG_OF_PCI) ? += of_pci.o
> +obj-$(CONFIG_OF_REGULATOR) ? ? += of_regulator.o
> diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
> new file mode 100644
> index 0000000..d523302
> --- /dev/null
> +++ b/drivers/of/of_regulator.c
> @@ -0,0 +1,166 @@
> +/*
> + * OF helpers for the Regulator API
> + *
> + * Copyright (c) 2011 Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/suspend.h>
> +
> +static int of_regulator_init_constraints(struct device_node *of_dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct regulation_constraints *constraints)
> +{
> + ? ? ? const __be32 *p;
> + ? ? ? const char *cp;
> + ? ? ? const char *ops[] = {"voltage", "current", "mode", "status",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "drms"};
> + ? ? ? int i, size, len = 0, tmp = 0;
> +
> + ? ? ? memset(constraints, 0, sizeof(struct regulation_constraints));
> +
> + ? ? ? p = of_get_property(of_dev, "voltages", &size);
> + ? ? ? if (p && size / sizeof(int) == 2) {
> + ? ? ? ? ? ? ? constraints->min_uV = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? constraints->max_uV = be32_to_cpu(*p);
> + ? ? ? }

You can probably simplify a lot of code by using
of_property_read_u32_array(), which is currently in devicetree/next

> + ? ? ? p = of_get_property(of_dev, "currents", &size);
> + ? ? ? if (p && size / sizeof(int) == 2) {
> + ? ? ? ? ? ? ? constraints->min_uA = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? constraints->max_uA = be32_to_cpu(*p);
> + ? ? ? }
> + ? ? ? p = of_get_property(of_dev, "modes-mask", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->valid_modes_mask = be32_to_cpu(*p);
> + ? ? ? cp = of_get_property(of_dev, "ops-mask", &size);
> + ? ? ? tmp = 0;
> + ? ? ? if (cp && size > 0) {
> + ? ? ? ? ? ? ? i = 0;
> + ? ? ? ? ? ? ? do {
> + ? ? ? ? ? ? ? ? ? ? ? len = strlen(ops[i]);
> + ? ? ? ? ? ? ? ? ? ? ? if (!strncmp(cp, ops[i], len)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? constraints->valid_ops_mask |= 1 << i;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /* need to handle '\0' */
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cp += len + 1;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? size = size - len - 1;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? i = 0;
> + ? ? ? ? ? ? ? ? ? ? ? } else
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? i++;
> + ? ? ? ? ? ? ? } while (i < ARRAY_SIZE(ops));
> + ? ? ? ? ? ? ? if (size > 0)
> + ? ? ? ? ? ? ? ? ? ? ? printk(KERN_WARNING "Invalid string:%s\n", cp);
> + ? ? ? }
> + ? ? ? p = of_get_property(of_dev, "input-uV", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->input_uV = be32_to_cpu(*p);
> + ? ? ? p = of_get_property(of_dev, "state-pm-disk", &size);
> + ? ? ? if (p && size / sizeof(int) == 3) {
> + ? ? ? ? ? ? ? constraints->state_disk.uV = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? constraints->state_disk.mode = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? tmp = be32_to_cpu(*p);
> + ? ? ? ? ? ? ? constraints->state_disk.enabled = (tmp) ? 1 : 0;
> + ? ? ? ? ? ? ? constraints->state_disk.disabled = (tmp) ? 0 : 1;
> + ? ? ? }
> + ? ? ? p = of_get_property(of_dev, "state-pm-mem", &size);
> + ? ? ? if (p && size / sizeof(int) == 3) {
> + ? ? ? ? ? ? ? constraints->state_mem.uV = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? constraints->state_mem.mode = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? tmp = be32_to_cpu(*p);
> + ? ? ? ? ? ? ? constraints->state_mem.enabled = (tmp) ? 1 : 0;
> + ? ? ? ? ? ? ? constraints->state_mem.disabled = (tmp) ? 0 : 1;
> + ? ? ? }
> + ? ? ? p = of_get_property(of_dev, "state-pm-standby", &size);
> + ? ? ? if (p && size / sizeof(int) == 3) {
> + ? ? ? ? ? ? ? constraints->state_standby.uV = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? constraints->state_standby.mode = be32_to_cpu(*p++);
> + ? ? ? ? ? ? ? tmp = be32_to_cpu(*p);
> + ? ? ? ? ? ? ? constraints->state_standby.enabled = (tmp) ? 1 : 0;
> + ? ? ? ? ? ? ? constraints->state_standby.disabled = (tmp) ? 0 : 1;
> + ? ? ? }
> + ? ? ? cp = of_get_property(of_dev, "initial-state", &size);
> + ? ? ? if (cp) {
> + ? ? ? ? ? ? ? if (!strncmp(cp, "pm-suspend-on", size))
> + ? ? ? ? ? ? ? ? ? ? ? constraints->initial_state = PM_SUSPEND_ON;
> + ? ? ? ? ? ? ? if (!strncmp(cp, "pm-suspend-mem", size))
> + ? ? ? ? ? ? ? ? ? ? ? constraints->initial_state = PM_SUSPEND_MEM;
> + ? ? ? ? ? ? ? if (!strncmp(cp, "pm-suspend-standby", size))
> + ? ? ? ? ? ? ? ? ? ? ? constraints->initial_state = PM_SUSPEND_STANDBY;
> + ? ? ? }
> + ? ? ? p = of_get_property(of_dev, "initial_mode", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->initial_mode = be32_to_cpu(*p);
> + ? ? ? p = of_get_property(of_dev, "always-on", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->always_on = 1;
> + ? ? ? p = of_get_property(of_dev, "boot-on", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->boot_on = 1;
> + ? ? ? p = of_get_property(of_dev, "apply-uV", NULL);
> + ? ? ? if (p)
> + ? ? ? ? ? ? ? constraints->apply_uV = 1;
> + ? ? ? return 0;
> +}

This code is implementing a new binding which needs to be documented
in Documentation/devicetree/bindings.  It is hard to review the patch
without some accompanying documentation about how you expect it to be
used.

> +
> +int of_regulator_init_data(struct device_node *of_dev,
> + ? ? ? ? ? ? ? ? ? ? ? struct regulator_init_data *data)
> +{
> + ? ? ? struct regulator_consumer_supply *supply;
> + ? ? ? const char *p, *str;
> + ? ? ? int ret, i, size, calc_size, len, count = 0;
> +
> + ? ? ? if (of_dev == NULL || data == NULL)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? p = of_get_property(of_dev, "device_type", &size);
> + ? ? ? if (p == NULL || strncmp(p, "regulator", size))
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? ret = of_regulator_init_constraints(of_dev, &data->constraints);
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? return ret;
> + ? ? ? p = of_get_property(of_dev, "supply-name", &size);
> + ? ? ? str = p;
> + ? ? ? calc_size = size;
> + ? ? ? while (str && calc_size > 0) {
> + ? ? ? ? ? ? ? len = strlen(str);
> + ? ? ? ? ? ? ? if (len == 0)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? calc_size = calc_size - len - 1;
> + ? ? ? ? ? ? ? str += len + 1;
> + ? ? ? ? ? ? ? count++;
> + ? ? ? }
> + ? ? ? if (count == 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? supply = kzalloc(sizeof(struct regulator_consumer_supply) * count,
> + ? ? ? ? ? ? ? GFP_KERNEL);
> + ? ? ? if (supply == NULL)
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? str = p;
> + ? ? ? calc_size = size;
> + ? ? ? i = 0;
> + ? ? ? while (str && calc_size > 0 && i < count) {
> + ? ? ? ? ? ? ? len = strlen(str);
> + ? ? ? ? ? ? ? if (len == 0)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? supply[i++].supply = str;
> + ? ? ? ? ? ? ? calc_size = calc_size - len - 1;
> + ? ? ? ? ? ? ? str += len + 1;
> + ? ? ? }
> + ? ? ? data->consumer_supplies = supply;
> + ? ? ? data->num_consumer_supplies = count;
> + ? ? ? return 0;
> +}
> +
> +void of_regulator_deinit_data(struct regulator_init_data *data)
> +{
> + ? ? ? if (data && data->consumer_supplies)
> + ? ? ? ? ? ? ? kfree(data->consumer_supplies);
> +}
> diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
> new file mode 100644
> index 0000000..0155bd8
> --- /dev/null
> +++ b/include/linux/of_regulator.h
> @@ -0,0 +1,34 @@
> +/*
> + * Generic Regulator API implementation
> + *
> + * Copyright (c) 2011 Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __LINUX_OF_REGULATOR_H
> +#define __LINUX_OF_REGULATOR_H
> +
> +#if defined(CONFIG_OF_REGULATOR) || defined(CONFIG_OF_REGULATOR_MODULE)
> +#include <linux/regulator/machine.h>
> +
> +extern int of_regulator_init_data(struct device_node *of_node,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct regulator_init_data *data);
> +extern void of_regulator_deinit_data(struct regulator_init_data *data);
> +
> +#else
> +static inline int of_regulator_init_data(struct device_node *of_node,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct regulator_init_data *data)
> +{
> + ? ? ? return 0;
> +}
> +
> +static inline void of_regulator_deinit_data(struct regulator_init_data *data)
> +{
> +}
> +#endif /* CONFIG_OF_REGULATOR */
> +
> +#endif /* __LINUX_OF_REGULATOR_H */
> --
> 1.5.6.5
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
