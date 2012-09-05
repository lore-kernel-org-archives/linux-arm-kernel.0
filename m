From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Wed, 05 Sep 2012 09:37:34 +0200
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources
 of camera and eMMA
In-Reply-To: <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
Message-ID: <5047013E.30508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,
This is because I will send a patch to add support of eMMA-PP. eMMA-PrP 
is not only used for soc-camera. It can also be used as stand-alone 
driver and now to be able to use eMMA-PrP module, 
IMX_HAVE_PLATFORM_MX2_CAMERA must be set.
And if I follow this logic, I have to put declaration of eMMA-PP with 
imx-fb and eMMA-PP can only be enabled if IMX_HAVE_PLATFORM_IMX_FB.
Of course, eMMA-PrP is almost always used with soc-camera and eMMA-PP 
with LCDC (imx-fb) but eMMA can be used to do HW accelarated colorspace 
conversion.
It is not a problem for me to keep eMMA-PrP and mx2-camera together. It 
was just to have a more independant eMMA driver.

For the Visstrim_M10 board, I don't think that it is needed to set 
IMX_HAVE_PLATFORM_MX2_EMMA because there is no reference to m2m-emmaprp 
and mx2-camera embeds handling of eMMA-PrP without using eMMA-PrP driver.
It seems that eMMA-PrP embeded in mx2camera handles more case than 
stand-alone eMMA-PrP driver. Maybe eMMA-PrP driver needs some review to 
handle all In/Out image formats ?
Please, let me know your point of view ?
Thank you.

On 09/05/2012 08:49 AM, javier Martin wrote:
> Hi Ga?tan,
> is there any real technical reason to do this or is the patch only for
> cosmetic purposes?
>
> The following patch, which is meant to go through the linux-media
> tree, adds support for mx2_emmaprp in the Visstrim_M10 boards:
> https://patchwork.kernel.org/patch/1347921/
>
> Could you please add the flag IMX_HAVE_PLATFORM_MX2_EMMA for the
> Visstrim_M10 board in this patch?
>
> On 4 September 2012 14:56, Ga?tan Carlier <gcembed@gmail.com> wrote:
>> IMX_HAVE_PLATFORM_MX2_EMMA define has been added.
>>
>> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
>> ---
>>   arch/arm/mach-imx/devices-imx27.h               |    4 ++-
>>   arch/arm/plat-mxc/devices/Kconfig               |    3 ++
>>   arch/arm/plat-mxc/devices/Makefile              |    1 +
>>   arch/arm/plat-mxc/devices/platform-mx2-camera.c |   17 ---------
>>   arch/arm/plat-mxc/devices/platform-mx2-emma.c   |   41 +++++++++++++++++++++++
>>   arch/arm/plat-mxc/include/mach/devices-common.h |    9 ++++-
>>   6 files changed, 56 insertions(+), 19 deletions(-)
>>   create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-emma.c
>>
>> diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
>> index 0482293..d8eb4a0 100644
>> --- a/arch/arm/mach-imx/devices-imx27.h
>> +++ b/arch/arm/mach-imx/devices-imx27.h
>> @@ -54,8 +54,10 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[];
>>   extern const struct imx_mx2_camera_data imx27_mx2_camera_data;
>>   #define imx27_add_mx2_camera(pdata)    \
>>          imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
>> +
>> +extern const struct imx_mx2_emma_data imx27_mx2_emmaprp_data;
>>   #define imx27_add_mx2_emmaprp()        \
>> -       imx_add_mx2_emmaprp(&imx27_mx2_camera_data)
>> +       imx_add_mx2_emmaprp(&imx27_mx2_emmaprp_data)
>>
>>   extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data;
>>   #define imx27_add_mxc_ehci_otg(pdata)  \
>
> This chunk doesn't seem ok. What kernel branch are you development against?
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-imx/devices-imx27.h;h=436c5720fe6a40255a2c3bc5ab05378c23855e02;hb=HEAD#l50
>
>> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
>> index 6b46cee..96feef7 100644
>> --- a/arch/arm/plat-mxc/devices/Kconfig
>> +++ b/arch/arm/plat-mxc/devices/Kconfig
>> @@ -56,6 +56,9 @@ config IMX_HAVE_PLATFORM_MX1_CAMERA
>>   config IMX_HAVE_PLATFORM_MX2_CAMERA
>>          bool
>>
>> +config IMX_HAVE_PLATFORM_MX2_EMMA
>> +       bool
>> +
>>   config IMX_HAVE_PLATFORM_MXC_EHCI
>>          bool
>>
>> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
>> index 76f3195..7292c1f 100644
>> --- a/arch/arm/plat-mxc/devices/Makefile
>> +++ b/arch/arm/plat-mxc/devices/Makefile
>> @@ -28,3 +28,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
>>   obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
>>   obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
>>   obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
>> +obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_EMMA) += platform-mx2-emma.o
>> diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
>> index 11eace9..11c688f 100644
>> --- a/arch/arm/plat-mxc/devices/platform-mx2-camera.c
>> +++ b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
>> @@ -63,20 +63,3 @@ struct platform_device *__init imx_add_mx2_camera(
>>                          pdata, sizeof(*pdata), DMA_BIT_MASK(32));
>>   }
>>
>> -struct platform_device *__init imx_add_mx2_emmaprp(
>> -               const struct imx_mx2_camera_data *data)
>> -{
>> -       struct resource res[] = {
>> -               {
>> -                       .start = data->iobaseemmaprp,
>> -                       .end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
>> -                       .flags = IORESOURCE_MEM,
>> -               }, {
>> -                       .start = data->irqemmaprp,
>> -                       .end = data->irqemmaprp,
>> -                       .flags = IORESOURCE_IRQ,
>> -               },
>> -       };
>> -       return imx_add_platform_device_dmamask("m2m-emmaprp", 0,
>> -                       res, 2, NULL, 0, DMA_BIT_MASK(32));
>> -}
>> diff --git a/arch/arm/plat-mxc/devices/platform-mx2-emma.c b/arch/arm/plat-mxc/devices/platform-mx2-emma.c
>> new file mode 100644
>> index 0000000..a51749a
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/devices/platform-mx2-emma.c
>> @@ -0,0 +1,41 @@
>> +/*
>> + * Copyright (C) 2010 Pengutronix
>> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it under
>> + * the terms of the GNU General Public License version 2 as published by the
>> + * Free Software Foundation.
>> + */
>> +#include <mach/hardware.h>
>> +#include <mach/devices-common.h>
>> +
>> +#define imx_mx2_emmaprp_data_entry_single(soc)                         \
>> +       {                                                               \
>> +               .iobase = soc ## _EMMAPRP_BASE_ADDR,                    \
>> +               .iosize = SZ_32,                                        \
>> +               .irq = soc ## _INT_EMMAPRP,                             \
>> +       }
>> +
>> +#ifdef CONFIG_SOC_IMX27
>> +const struct imx_mx2_emma_data imx27_mx2_emmaprp_data __initconst =
>> +       imx_mx2_emmaprp_data_entry_single(MX27);
>> +#endif /* ifdef CONFIG_SOC_IMX27 */
>> +
>> +struct platform_device *__init imx_add_mx2_emmaprp(
>> +               const struct imx_mx2_emma_data *data)
>> +{
>> +       struct resource res[] = {
>> +               {
>> +                       .start = data->iobase,
>> +                       .end = data->iobase + data->iosize - 1,
>> +                       .flags = IORESOURCE_MEM,
>> +               }, {
>> +                       .start = data->irq,
>> +                       .end = data->irq,
>> +                       .flags = IORESOURCE_IRQ,
>> +               },
>> +       };
>> +       return imx_add_platform_device_dmamask("m2m-emmaprp", 0,
>> +                       res, 2, NULL, 0, DMA_BIT_MASK(32));
>> +}
>> +
>> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
>> index 762780c..2117072 100644
>> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
>> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
>> @@ -229,8 +229,15 @@ struct imx_mx2_camera_data {
>>   struct platform_device *__init imx_add_mx2_camera(
>>                  const struct imx_mx2_camera_data *data,
>>                  const struct mx2_camera_platform_data *pdata);
>> +
>> +
>> +struct imx_mx2_emma_data {
>> +       resource_size_t iobase;
>> +       resource_size_t iosize;
>> +       resource_size_t irq;
>> +};
>>   struct platform_device *__init imx_add_mx2_emmaprp(
>> -               const struct imx_mx2_camera_data *data);
>> +               const struct imx_mx2_emma_data *data);
>>
>>   #include <mach/mxc_ehci.h>
>>   struct imx_mxc_ehci_data {
>> --
>> 1.7.7.4
>>
>
> Regards.
>
Regards,
Ga?tan.
