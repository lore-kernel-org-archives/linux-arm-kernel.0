From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 23 Aug 2010 12:58:49 +0900
Subject: [PATCH RE-SEND] ARM: S5P: Move OneNAND device definitions in
	plat-s5p
In-Reply-To: <006001cb426b$e84dd560$b8e98020$%kim@samsung.com>
References: <1282522043-2420-1-git-send-email-kgene.kim@samsung.com>
	<01ba01cb4268$8346fa50$89d4eef0$%park@samsung.com>
	<006001cb426b$e84dd560$b8e98020$%kim@samsung.com>
Message-ID: <AANLkTi=V52VyR7ydy6CPChsn0Qp0jW0G0x=ozroDBZYo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 11:35 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> " Note: S5PC110 and S5PC210 have same OneNAND driver."
>>
>> Yes I also think it's same device. At least Spec is same. But I heard it
> has
>> some different feature related with DMA operation.
>> I'm not yet receive the official release from LSI. So I can't tell the
> exact
>> one.
>>
>> If it's true. we need to separate it if required.
>>
> No need to separate this stuff.
> It means that no problem to use this commonly for S5PC110 and S5PC210.
As DMA operation is changed, we need to register onenand device
separately like s5pc210-onenand.
to use the different read operations.

>
> But...I will check it again before applying.
>
>> Thank you,
>> Kyungmin Park
>>
>> -----Original Message-----
>> From: Kukjin Kim [mailto:kgene.kim at samsung.com]
>> Sent: Monday, August 23, 2010 9:07 AM
>> To: linux-arm-kernel at lists.infradead.org;
> linux-samsung-soc at vger.kernel.org
>> Cc: ben-linux at fluff.org; Kukjin Kim; Kyungmin Park
>> Subject: [PATCH RE-SEND] ARM: S5P: Move OneNAND device definitions in
>> plat-s5p
>>
>> This patch moves OneNAND device definitions from mach-s5pv210 to plat-s5p
>> so that can support it commonly.
>>
>> Note: S5PC110 and S5PC210 have same OneNAND driver.
>>
>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Kyungmin Park <Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?9 +-----
>> ?arch/arm/mach-s5pv210/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?1 -
>> ?arch/arm/mach-s5pv210/include/mach/map.h ? ? ? ? ?| ? ?3 ++
>> ?arch/arm/mach-s5pv210/mach-aquila.c ? ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-s5pv210/mach-goni.c ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-s5pv310/include/mach/irqs.h ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-s5pv310/include/mach/map.h ? ? ? ? ?| ? ?6 ++++
>> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +++
>> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c | ? 28
>> +++++++++++---------
>> ?arch/arm/plat-samsung/include/plat/devs.h ? ? ? ? | ? ?2 +-
>> ?11 files changed, 37 insertions(+), 24 deletions(-)
>> ?rename arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c (59%)
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>> index d3a3895..5315fec 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -53,11 +53,6 @@ config S5PV210_SETUP_SDHCI_GPIO
>> ? ? ? help
>> ? ? ? ? Common setup code for SDHCI gpio.
>>
>> -config S5PC110_DEV_ONENAND
>> - ? ? bool
>> - ? ? help
>> - ? ? ? Compile in platform device definition for OneNAND1 controller
>> -
>> ?menu "S5PC110 Machines"
>>
>> ?config MACH_AQUILA
>> @@ -71,7 +66,7 @@ config MACH_AQUILA
>> ? ? ? select S3C_DEV_HSMMC
>> ? ? ? select S3C_DEV_HSMMC1
>> ? ? ? select S3C_DEV_HSMMC2
>> - ? ? select S5PC110_DEV_ONENAND
>> + ? ? select S5P_DEV_ONENAND
>> ? ? ? select S5PV210_SETUP_FB_24BPP
>> ? ? ? select S5PV210_SETUP_SDHCI
>> ? ? ? help
>> @@ -88,7 +83,7 @@ config MACH_GONI
>> ? ? ? select S3C_DEV_HSMMC
>> ? ? ? select S3C_DEV_HSMMC1
>> ? ? ? select S3C_DEV_HSMMC2
>> - ? ? select S5PC110_DEV_ONENAND
>> + ? ? select S5P_DEV_ONENAND
>> ? ? ? select S5PV210_SETUP_FB_24BPP
>> ? ? ? select S5PV210_SETUP_SDHCI
>> ? ? ? help
>> diff --git a/arch/arm/mach-s5pv210/Makefile
> b/arch/arm/mach-s5pv210/Makefile
>> index 05048c5..7045489 100644
>> --- a/arch/arm/mach-s5pv210/Makefile
>> +++ b/arch/arm/mach-s5pv210/Makefile
>> @@ -26,7 +26,6 @@ obj-$(CONFIG_MACH_GONI) ? ? ? ? ? ? += mach-goni.o
>>
>> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-audio.o
>> ?obj-$(CONFIG_S3C64XX_DEV_SPI) ? ? ? ?+= dev-spi.o
>> -obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
>>
>> ?obj-$(CONFIG_S5PV210_SETUP_FB_24BPP) += setup-fb-24bpp.o
>> ?obj-$(CONFIG_S5PV210_SETUP_I2C1) ? ? += setup-i2c1.o
>> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h
>> b/arch/arm/mach-s5pv210/include/mach/map.h
>> index dd4fb6b..aa19d2f 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/map.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
>> @@ -17,7 +17,10 @@
>> ?#include <plat/map-s5p.h>
>>
>> ?#define S5PC110_PA_ONENAND ? (0xB0000000)
>> +#define S5P_PA_ONENAND ? ? ? ? ? ? ? S5PC110_PA_ONENAND
>> +
>> ?#define S5PC110_PA_ONENAND_DMA ? ? ? (0xB0600000)
>> +#define S5P_PA_ONENAND_DMA ? S5PC110_PA_ONENAND_DMA
>>
>> ?#define S5PV210_PA_CHIPID ? ?(0xE0000000)
>> ?#define S5P_PA_CHIPID ? ? ? ? ? ? ? ?S5PV210_PA_CHIPID
>> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c
>> b/arch/arm/mach-s5pv210/mach-aquila.c
>> index 0dda801..bf772de 100644
>> --- a/arch/arm/mach-s5pv210/mach-aquila.c
>> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
>> @@ -477,7 +477,7 @@ static struct platform_device *aquila_devices[]
>> __initdata = {
>> ? ? ? &aquila_i2c_gpio_pmic,
>> ? ? ? &aquila_device_gpiokeys,
>> ? ? ? &s3c_device_fb,
>> - ? ? &s5pc110_device_onenand,
>> + ? ? &s5p_device_onenand,
>> ? ? ? &s3c_device_hsmmc0,
>> ? ? ? &s3c_device_hsmmc1,
>> ? ? ? &s3c_device_hsmmc2,
>> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
>> b/arch/arm/mach-s5pv210/mach-goni.c
>> index 53754d7..fdc5cca 100644
>> --- a/arch/arm/mach-s5pv210/mach-goni.c
>> +++ b/arch/arm/mach-s5pv210/mach-goni.c
>> @@ -456,7 +456,7 @@ static void goni_setup_sdhci(void)
>>
>> ?static struct platform_device *goni_devices[] __initdata = {
>> ? ? ? &s3c_device_fb,
>> - ? ? &s5pc110_device_onenand,
>> + ? ? &s5p_device_onenand,
>> ? ? ? &goni_i2c_gpio_pmic,
>> ? ? ? &goni_device_gpiokeys,
>> ? ? ? &s5p_device_fimc0,
>> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h
>> b/arch/arm/mach-s5pv310/include/mach/irqs.h
>> index 522352f..7b4b09f 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
>> @@ -73,6 +73,8 @@
>> ?#define IRQ_HSMMC2 ? ? ? ? ? COMBINER_IRQ(29, 2)
>> ?#define IRQ_HSMMC3 ? ? ? ? ? COMBINER_IRQ(29, 3)
>>
>> +#define IRQ_ONENAND_AUDI ? ? COMBINER_IRQ(34, 0)
>> +
>> ?/* Set the default NR_IRQS */
>>
>> ?#define NR_IRQS
>> ? ? ? COMBINER_IRQ(MAX_COMBINER_NR, 0)
>> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h
>> b/arch/arm/mach-s5pv310/include/mach/map.h
>> index 6c7b1fc..5288f5a 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/map.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
>> @@ -23,6 +23,12 @@
>>
>> ?#include <plat/map-s5p.h>
>>
>> +#define S5PC210_PA_ONENAND ? ? ? ? ? (0x0C000000)
>> +#define S5P_PA_ONENAND ? ? ? ? ? ? ? ? ? ? ? S5PC210_PA_ONENAND
>> +
>> +#define S5PC210_PA_ONENAND_DMA ? ? ? ? ? ? ? (0x0C600000)
>> +#define S5P_PA_ONENAND_DMA
>> ? ? ? S5PC210_PA_ONENAND_DMA
>> +
>> ?#define S5PV310_PA_CHIPID ? ? ? ? ? ?(0x10000000)
>> ?#define S5P_PA_CHIPID ? ? ? ? ? ? ? ? ? ? ? ?S5PV310_PA_CHIPID
>>
>> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
>> index c6a855d..407e323 100644
>> --- a/arch/arm/plat-s5p/Kconfig
>> +++ b/arch/arm/plat-s5p/Kconfig
>> @@ -46,3 +46,8 @@ config S5P_DEV_FIMC2
>> ? ? ? bool
>> ? ? ? help
>> ? ? ? ? Compile in platform device definitions for FIMC controller 2
>> +
>> +config S5P_DEV_ONENAND
>> + ? ? bool
>> + ? ? help
>> + ? ? ? Compile in platform device definition for OneNAND controller
>> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
>> index b2e0296..f3e917e 100644
>> --- a/arch/arm/plat-s5p/Makefile
>> +++ b/arch/arm/plat-s5p/Makefile
>> @@ -24,3 +24,4 @@ obj-$(CONFIG_S5P_EXT_INT) ? += irq-eint.o
>> ?obj-$(CONFIG_S5P_DEV_FIMC0) ?+= dev-fimc0.o
>> ?obj-$(CONFIG_S5P_DEV_FIMC1) ?+= dev-fimc1.o
>> ?obj-$(CONFIG_S5P_DEV_FIMC2) ?+= dev-fimc2.o
>> +obj-$(CONFIG_S5P_DEV_ONENAND) ? ? ? ?+= dev-onenand.o
>> diff --git a/arch/arm/mach-s5pv210/dev-onenand.c
>> b/arch/arm/plat-s5p/dev-onenand.c
>> similarity index 59%
>> rename from arch/arm/mach-s5pv210/dev-onenand.c
>> rename to arch/arm/plat-s5p/dev-onenand.c
>> index f8ede33..6db9262 100644
>> --- a/arch/arm/mach-s5pv210/dev-onenand.c
>> +++ b/arch/arm/plat-s5p/dev-onenand.c
>> @@ -1,10 +1,12 @@
>> -/*
>> - * linux/arch/arm/mach-s5pv210/dev-onenand.c
>> +/* linux/arch/arm/plat-s5p/dev-onenand.c
>> + *
>> + * Copyright 2010 Samsung Electronics Co., Ltd.
>> + * ? ? ? ? ? http://www.samsung.com
>> ? *
>> ? * ?Copyright (c) 2008-2010 Samsung Electronics
>> ? * ?Kyungmin Park <kyungmin.park@samsung.com>
>> ? *
>> - * S5PC110 series device definition for OneNAND devices
>> + * S5P series device definition for OneNAND devices
>> ? *
>> ? * This program is free software; you can redistribute it and/or modify
>> ? * it under the terms of the GNU General Public License version 2 as
>> @@ -19,15 +21,15 @@
>> ?#include <mach/irqs.h>
>> ?#include <mach/map.h>
>>
>> -static struct resource s5pc110_onenand_resources[] = {
>> +static struct resource s5p_onenand_resources[] = {
>> ? ? ? [0] = {
>> - ? ? ? ? ? ? .start ?= S5PC110_PA_ONENAND,
>> - ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND + SZ_128K - 1,
>> + ? ? ? ? ? ? .start ?= S5P_PA_ONENAND,
>> + ? ? ? ? ? ? .end ? ?= S5P_PA_ONENAND + SZ_128K - 1,
>> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> ? ? ? },
>> ? ? ? [1] = {
>> - ? ? ? ? ? ? .start ?= S5PC110_PA_ONENAND_DMA,
>> - ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
>> + ? ? ? ? ? ? .start ?= S5P_PA_ONENAND_DMA,
>> + ? ? ? ? ? ? .end ? ?= S5P_PA_ONENAND_DMA + SZ_8K - 1,
>> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> ? ? ? },
>> ? ? ? [2] = {
>> @@ -37,19 +39,19 @@ static struct resource s5pc110_onenand_resources[] = {
>> ? ? ? },
>> ?};
>>
>> -struct platform_device s5pc110_device_onenand = {
>> +struct platform_device s5p_device_onenand = {
>> ? ? ? .name ? ? ? ? ? = "s5pc110-onenand",
>> ? ? ? .id ? ? ? ? ? ? = -1,
>> - ? ? .num_resources ?= ARRAY_SIZE(s5pc110_onenand_resources),
>> - ? ? .resource ? ? ? = s5pc110_onenand_resources,
>> + ? ? .num_resources ?= ARRAY_SIZE(s5p_onenand_resources),
>> + ? ? .resource ? ? ? = s5p_onenand_resources,
>> ?};
>>
>> -void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
>> +void s5p_onenand_set_platdata(struct onenand_platform_data *pdata)
>> ?{
>> ? ? ? struct onenand_platform_data *pd;
>>
>> ? ? ? pd = kmemdup(pdata, sizeof(struct onenand_platform_data),
>> GFP_KERNEL);
>> ? ? ? if (!pd)
>> ? ? ? ? ? ? ? printk(KERN_ERR "%s: no memory for platform data\n",
>> __func__);
>> - ? ? s5pc110_device_onenand.dev.platform_data = pd;
>> + ? ? s5p_device_onenand.dev.platform_data = pd;
>> ?}
>> diff --git a/arch/arm/plat-samsung/include/plat/devs.h
>> b/arch/arm/plat-samsung/include/plat/devs.h
>> index 85f6f23..cb12102 100644
>> --- a/arch/arm/plat-samsung/include/plat/devs.h
>> +++ b/arch/arm/plat-samsung/include/plat/devs.h
>> @@ -73,7 +73,7 @@ extern struct platform_device s3c_device_hwmon;
>> ?extern struct platform_device s3c_device_nand;
>> ?extern struct platform_device s3c_device_onenand;
>> ?extern struct platform_device s3c64xx_device_onenand1;
>> -extern struct platform_device s5pc110_device_onenand;
>> +extern struct platform_device s5p_device_onenand;
>>
>> ?extern struct platform_device s3c_device_usbgadget;
>> ?extern struct platform_device s3c_device_usb_hsotg;
>> --
>> 1.6.2.5
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
