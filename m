From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 30 Jul 2010 18:52:02 +0900
Subject: [RFC PATCH] s5pv210: New samsung SoCs devices support
In-Reply-To: <20100719073321.GA25399@july>
References: <20100719073321.GA25399@july>
Message-ID: <AANLkTinBPVZQo87f6doREDRm3MkP3mKRB-hukebuPSYb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To Ben,

Any comments?

On Mon, Jul 19, 2010 at 4:33 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Now only one samsung SoC and its devices are supported in mainline and
> can't support several SoCs simultaneously since each SoCs has different memory
> address and different number of IPs.
> e.g., some 64xx series has 2 I2Cs devices. C1xx series have three I2Cs and
> new SoC, S5PV310 has eight I2Cs.
>
> To address these issues. Each devices of SoC are registered at each devices tress (or list) and use it when probe time.
>
> Of course fundamentally we can't compile several SoCs simultaneously at current state. It's just preparation for supporting it
>
> Any comments are welcome.
>
> Thank you,
> Kyungmin Park
>
> Here's test codes and results.
>
> static struct samsung_device goni_samsung_devices[] = {
> ? ? ? ?/* device, index */
> ? ? ? S5PV210_DEVICE_ID(I2C, 0),
> ? ? ? S5PV210_DEVICE_ID(I2C, 1),
> ? ? ? S5PV210_DEVICE_ID(I2C, 2),
> };
>
> static void __init goni_machine_init(void)
> {
> ? ? ? samsung_platform_add_devices(goni_samsung_devices,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(goni_samsung_devices));
> ? ? ? platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
> ?}
>
> [ ? ?0.140000] samsung 0 device type 0, name s3c2440-i2c, id 2
> [ ? ?0.145000] samsung 0 device type 0, name s3c2440-i2c, id 1
> [ ? ?0.150000] samsung 0 device type 0, name s3c2440-i2c, id 0
> [ ? ?0.155000] S5PV210: Initializing architecture
> [ ? ?0.165000] bio: create slab <bio-0> at 0
> [ ? ?0.165000] s3c-i2c s3c2440-i2c.0: slave address 0x10
> [ ? ?0.170000] s3c-i2c s3c2440-i2c.0: bus frequency set to 378 KHz
> [ ? ?0.175000] s3c-i2c s3c2440-i2c.0: i2c-0: S3C I2C adapter
> [ ? ?0.185000] s3c-i2c s3c2440-i2c.1: slave address 0x10
> [ ? ?0.190000] s3c-i2c s3c2440-i2c.1: bus frequency set to 378 KHz
> [ ? ?0.195000] s3c-i2c s3c2440-i2c.1: i2c-1: S3C I2C adapter
> [ ? ?0.200000] s3c-i2c s3c2440-i2c.2: slave address 0x10
> [ ? ?0.205000] s3c-i2c s3c2440-i2c.2: bus frequency set to 378 KHz
> [ ? ?0.210000] s3c-i2c s3c2440-i2c.2: i2c-2: S3C I2C adapter
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?mach-s5pv210/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1
> ?mach-s5pv210/devices.c ? ? ? ? ? ? ? ? ? ? | ?144 +++++++++++++++++++++++++++++
> ?mach-s5pv210/include/mach/irqs.h ? ? ? ? ? | ? ?5 -
> ?plat-samsung/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1
> ?plat-samsung/devices.c ? ? ? ? ? ? ? ? ? ? | ?102 ++++++++++++++++++++
> ?plat-samsung/include/plat/samsung_device.h | ? 53 ++++++++++
> ?6 files changed, 305 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index 30be9a6..33ca7eb 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_MACH_GONI) ? ? ? ? ? ? ? += mach-goni.o
>
> ?# device support
>
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= devices.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-audio.o
> ?obj-$(CONFIG_S3C64XX_DEV_SPI) ?+= dev-spi.o
> ?obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
> diff --git a/arch/arm/mach-s5pv210/devices.c b/arch/arm/mach-s5pv210/devices.c
> new file mode 100644
> index 0000000..baf6567
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/devices.c
> @@ -0,0 +1,144 @@
> +/*
> + * arch/arm/mach-s5pv210/devices.c
> + *
> + * ?Copyright 2010 Samsung Electronics
> + * ?Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * Sasmung S5PC110/S5PV210 devices definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +
> +#include <mach/map.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/samsung_device.h>
> +#include <plat/iic.h>
> +
> +static struct resource s5pv210_i2c0_resource[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = S5PV210_PA_IIC0,
> + ? ? ? ? ? ? ? .end ? = S5PV210_PA_IIC0 + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start = S5PV210_IRQ_I2C0,
> + ? ? ? ? ? ? ? .end ? = S5PV210_IRQ_I2C0,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +static void s5pv210_i2c0_cfg_gpio(struct platform_device *dev)
> +{
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
> +}
> +
> +static struct s3c2410_platform_i2c s5pv210_i2c0_data = {
> + ? ? ? .bus_num ? ? ? ? ? ? ? ?= 0,
> + ? ? ? .slave_addr ? ? ? ? ? ? = 0x10,
> + ? ? ? .frequency ? ? ? ? ? ? ?= 400*1000,
> + ? ? ? .sda_delay ? ? ? ? ? ? ?= 100,
> + ? ? ? .cfg_gpio ? ? ? ? ? ? ? = s5pv210_i2c0_cfg_gpio,
> +};
> +
> +static struct platform_device s5pv210_i2c0_device = {
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "s3c2440-i2c",
> + ? ? ? .id ? ? ? ? ? ? ? ? ? ? = 0,
> + ? ? ? .dev ? ? ? ? ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &s5pv210_i2c0_data,
> + ? ? ? },
> + ? ? ? .num_resources ? ? ? ? ?= ARRAY_SIZE(s5pv210_i2c0_resource),
> + ? ? ? .resource ? ? ? ? ? ? ? = s5pv210_i2c0_resource,
> +};
> +
> +SAMSUNG_DEVICE_INIT(SAMSUNG_S5PV210, SAMSUNG_DEVICE_I2C, s5pv210_i2c0_device);
> +
> +static struct resource s5pv210_i2c1_resource[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = S5PV210_PA_IIC1,
> + ? ? ? ? ? ? ? .end ? = S5PV210_PA_IIC1 + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start = S5PV210_IRQ_I2C1,
> + ? ? ? ? ? ? ? .end ? = S5PV210_IRQ_I2C1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +static void s5pv210_i2c1_cfg_gpio(struct platform_device *dev)
> +{
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(2), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(2), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(3), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(3), S3C_GPIO_PULL_UP);
> +}
> +
> +static struct s3c2410_platform_i2c s5pv210_i2c1_data = {
> + ? ? ? .bus_num ? ? ? ? ? ? ? ?= 1,
> + ? ? ? .slave_addr ? ? ? ? ? ? = 0x10,
> + ? ? ? .frequency ? ? ? ? ? ? ?= 400*1000,
> + ? ? ? .sda_delay ? ? ? ? ? ? ?= 100,
> + ? ? ? .cfg_gpio ? ? ? ? ? ? ? = s5pv210_i2c1_cfg_gpio,
> +};
> +
> +static struct platform_device s5pv210_i2c1_device = {
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "s3c2440-i2c",
> + ? ? ? .id ? ? ? ? ? ? ? ? ? ? = 1,
> + ? ? ? .dev ? ? ? ? ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &s5pv210_i2c1_data,
> + ? ? ? },
> + ? ? ? .num_resources ? ? ? ? ?= ARRAY_SIZE(s5pv210_i2c1_resource),
> + ? ? ? .resource ? ? ? ? ? ? ? = s5pv210_i2c1_resource,
> +};
> +
> +SAMSUNG_DEVICE_INIT(SAMSUNG_S5PV210, SAMSUNG_DEVICE_I2C, s5pv210_i2c1_device);
> +
> +static struct resource s5pv210_i2c2_resource[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = S5PV210_PA_IIC2,
> + ? ? ? ? ? ? ? .end ? = S5PV210_PA_IIC2 + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start = S5PV210_IRQ_I2C2,
> + ? ? ? ? ? ? ? .end ? = S5PV210_IRQ_I2C2,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +static void s5pv210_i2c2_cfg_gpio(struct platform_device *dev)
> +{
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
> + ? ? ? s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
> +}
> +
> +static struct s3c2410_platform_i2c s5pv210_i2c2_data = {
> + ? ? ? .bus_num ? ? ? ? ? ? ? ?= 2,
> + ? ? ? .slave_addr ? ? ? ? ? ? = 0x10,
> + ? ? ? .frequency ? ? ? ? ? ? ?= 400*1000,
> + ? ? ? .sda_delay ? ? ? ? ? ? ?= 100,
> + ? ? ? .cfg_gpio ? ? ? ? ? ? ? = s5pv210_i2c2_cfg_gpio,
> +};
> +
> +static struct platform_device s5pv210_i2c2_device = {
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "s3c2440-i2c",
> + ? ? ? .id ? ? ? ? ? ? ? ? ? ? = 2,
> + ? ? ? .dev ? ? ? ? ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &s5pv210_i2c2_data,
> + ? ? ? },
> + ? ? ? .num_resources ? ? ? ? ?= ARRAY_SIZE(s5pv210_i2c2_resource),
> + ? ? ? .resource ? ? ? ? ? ? ? = s5pv210_i2c2_resource,
> +};
> +
> +SAMSUNG_DEVICE_INIT(SAMSUNG_S5PV210, SAMSUNG_DEVICE_I2C, s5pv210_i2c2_device);
> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
> index 9689537..fe48c7f 100644
> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> @@ -51,11 +51,13 @@
> ?#define IRQ_UART2 ? ? ? ? ? ? ?S5P_IRQ_VIC1(12)
> ?#define IRQ_UART3 ? ? ? ? ? ? ?S5P_IRQ_VIC1(13)
> ?#define IRQ_IIC ? ? ? ? ? ? ? ? ? ? ? ?S5P_IRQ_VIC1(14)
> +#define S5PV210_IRQ_I2C0 ? ? ? S5P_IRQ_VIC1(14)
> ?#define IRQ_SPI0 ? ? ? ? ? ? ? S5P_IRQ_VIC1(15)
> ?#define IRQ_SPI1 ? ? ? ? ? ? ? S5P_IRQ_VIC1(16)
> ?#define IRQ_SPI2 ? ? ? ? ? ? ? S5P_IRQ_VIC1(17)
> ?#define IRQ_IRDA ? ? ? ? ? ? ? S5P_IRQ_VIC1(18)
> -#define IRQ_CAN0 ? ? ? ? ? ? ? S5P_IRQ_VIC1(19)
> +#define IRQ_IIC2 ? ? ? ? ? ? ? S5P_IRQ_VIC1(19)
> +#define S5PV210_IRQ_I2C2 ? ? ? S5P_IRQ_VIC1(19)
> ?#define IRQ_CAN1 ? ? ? ? ? ? ? S5P_IRQ_VIC1(20)
> ?#define IRQ_HSIRX ? ? ? ? ? ? ?S5P_IRQ_VIC1(21)
> ?#define IRQ_HSITX ? ? ? ? ? ? ?S5P_IRQ_VIC1(22)
> @@ -85,6 +87,7 @@
> ?#define IRQ_MIXER ? ? ? ? ? ? ?S5P_IRQ_VIC2(11)
> ?#define IRQ_HDMI ? ? ? ? ? ? ? S5P_IRQ_VIC2(12)
> ?#define IRQ_IIC1 ? ? ? ? ? ? ? S5P_IRQ_VIC2(13)
> +#define S5PV210_IRQ_I2C1 ? ? ? S5P_IRQ_VIC2(13)
> ?#define IRQ_MFC ? ? ? ? ? ? ? ? ? ? ? ?S5P_IRQ_VIC2(14)
> ?#define IRQ_TVENC ? ? ? ? ? ? ?S5P_IRQ_VIC2(15)
> ?#define IRQ_I2S0 ? ? ? ? ? ? ? S5P_IRQ_VIC2(16)
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index b1d82cc..f2a91f3 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_S3C_ADC) += adc.o
>
> ?# devices
>
> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= devices.o
> ?obj-$(CONFIG_S3C_DEV_HSMMC) ? ?+= dev-hsmmc.o
> ?obj-$(CONFIG_S3C_DEV_HSMMC1) ? += dev-hsmmc1.o
> ?obj-$(CONFIG_S3C_DEV_HSMMC2) ? += dev-hsmmc2.o
> diff --git a/arch/arm/plat-samsung/devices.c b/arch/arm/plat-samsung/devices.c
> new file mode 100644
> index 0000000..0db6555
> --- /dev/null
> +++ b/arch/arm/plat-samsung/devices.c
> @@ -0,0 +1,102 @@
> +/*
> + * linux/arch/arm/plat-samsung/devices.c
> + *
> + * ?Copyright 2010 Samsung Electronics
> + *
> + * Sasmung SoCs series device helper functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/list.h>
> +
> +#include <plat/samsung_device.h>
> +
> +static struct list_head samsung_devices_list[SAMSUNG_NUM_SOC];
> +
> +static struct samsung_device *samsung_find_device(struct samsung_device *sdev)
> +{
> + ? ? ? struct samsung_device *sd;
> +
> + ? ? ? list_for_each_entry(sd, &samsung_devices_list[sdev->soc], list) {
> + ? ? ? ? ? ? ? if (sd->type == sdev->type &&
> + ? ? ? ? ? ? ? ? ? sd->pdev->id == sdev->id) {
> + ? ? ? ? ? ? ? ? ? ? ? return sd;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? return NULL;
> +}
> +
> +static void samsung_device_unregister(struct samsung_device *sdevs, int num)
> +{
> + ? ? ? struct samsung_device *sd;
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < num; i++) {
> + ? ? ? ? ? ? ? sd = samsung_find_device(&sdevs[i]);
> + ? ? ? ? ? ? ? if (!sd)
> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> + ? ? ? ? ? ? ? platform_device_unregister(sd->pdev);
> + ? ? ? }
> +}
> +
> +int samsung_platform_add_devices(struct samsung_device *sdevs, int num)
> +{
> + ? ? ? struct samsung_device *sd;
> + ? ? ? int i, ret = 0;
> +
> + ? ? ? for (i = 0; i < num; i++) {
> + ? ? ? ? ? ? ? sd = samsung_find_device(&sdevs[i]);
> + ? ? ? ? ? ? ? if (!sd)
> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> + ? ? ? ? ? ? ? ret = platform_device_register(sd->pdev);
> + ? ? ? ? ? ? ? if (ret) {
> + ? ? ? ? ? ? ? ? ? ? ? samsung_device_unregister(sdevs, num);
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? return ret;
> +}
> +EXPORT_SYMBOL(samsung_platform_add_devices);
> +
> +int samsung_device_register(enum samsung_soc soc,
> + ? ? ? ? ? ? ? enum samsung_device_type type, struct platform_device *pdev)
> +{
> + ? ? ? struct samsung_device *sd;
> +
> + ? ? ? sd = kzalloc(sizeof(struct samsung_device), GFP_KERNEL);
> + ? ? ? if (!sd)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? printk(KERN_INFO "samsung %d device type %d, name %s, id %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? soc, type, pdev->name, pdev->id);
> +
> + ? ? ? INIT_LIST_HEAD(&sd->list);
> + ? ? ? sd->soc = soc;
> + ? ? ? sd->type = type;
> + ? ? ? sd->pdev = pdev;
> + ? ? ? list_add(&sd->list, &samsung_devices_list[soc]);
> +
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(samsung_device_register);
> +
> +static int __init samsung_device_init(void)
> +{
> + ? ? ? int i;
> +
> + ? ? ? for (i = 0; i < SAMSUNG_NUM_SOC; i++)
> + ? ? ? ? ? ? ? INIT_LIST_HEAD(&samsung_devices_list[i]);
> + ? ? ? return 0;
> +}
> +
> +pure_initcall(samsung_device_init);
> diff --git a/arch/arm/plat-samsung/include/plat/samsung_device.h b/arch/arm/plat-samsung/include/plat/samsung_device.h
> new file mode 100644
> index 0000000..8bb134a
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/samsung_device.h
> @@ -0,0 +1,53 @@
> +/*
> + * arch/arm/mach-s5pv210/devices.c
> + *
> + * ?Copyright 2010 Samsung Electronics
> + * ?Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * Sasmung SoCs series devices definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SAMSUNG_DEVICE_H
> +#define __SAMSUNG_DEVICE_H
> +
> +#include <linux/init.h>
> +
> +enum samsung_soc {
> + ? ? ? SAMSUNG_S5PV210,
> + ? ? ? SAMSUNG_NUM_SOC,
> +};
> +
> +enum samsung_device_type {
> + ? ? ? SAMSUNG_DEVICE_I2C,
> +};
> +
> +struct samsung_device {
> + ? ? ? struct list_head ? ? ? ? ? ? ? ?list;
> + ? ? ? enum samsung_soc ? ? ? ? ? ? ? ?soc;
> + ? ? ? enum samsung_device_type ? ? ? ?type;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? ? ? ? ? id;
> + ? ? ? struct platform_device ? ? ? ? ?*pdev;
> +};
> +
> +extern int samsung_platform_add_devices(struct samsung_device *sdevs, int num);
> +extern int samsung_device_register(enum samsung_soc soc,
> + ? ? ? ? ? ? ? enum samsung_device_type type, struct platform_device *pdev);
> +
> +#define SAMSUNG_DEVICE_ID(dev_soc, dev_type, dev_id) ? ? ? ? ? ? ? ? ? \
> +{ ? ? ?.soc = dev_soc, .type = SAMSUNG_DEVICE_##dev_type, .id = dev_id, }
> +
> +#define S5PV210_DEVICE_ID(dev_type, dev_id) ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? SAMSUNG_DEVICE_ID(SAMSUNG_S5PV210, dev_type, dev_id)
> +
> +#define SAMSUNG_DEVICE_INIT(soc, type, pdev) ? ? ? ? ? ? ? ? ? ? ? ? ? \
> +static int samsung_device_init_##pdev(void) ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> +{ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? return samsung_device_register(soc, type, &pdev); ? ? ? ? ? ? ? \
> +} ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> +core_initcall(samsung_device_init_##pdev)
> +
> +#endif
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
