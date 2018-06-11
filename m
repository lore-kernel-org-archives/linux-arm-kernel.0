From: stefan@agner.ch (Stefan Agner)
Date: Mon, 11 Jun 2018 14:41:29 +0200
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <a4657c84-a807-d194-950c-38f5f8e4a53c@pengutronix.de>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
 <93e7b7ef-1bc0-2871-da2c-65ab3f070c07@pengutronix.de>
 <20180611082022.GG16091@dragon> <1528706126.2842.1.camel@pengutronix.de>
 <3fa291a7da6978545cd21fdcf78c483e@agner.ch>
 <a4657c84-a807-d194-950c-38f5f8e4a53c@pengutronix.de>
Message-ID: <610391dc49d481debe1c71bd3070c73b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.06.2018 13:53, Oleksij Rempel wrote:
> On 11.06.2018 13:48, Stefan Agner wrote:
>> On 11.06.2018 10:35, Lucas Stach wrote:
>>> Hi Shawn,
>>>
>>> Am Montag, den 11.06.2018, 16:20 +0800 schrieb Shawn Guo:
>>>> On Mon, Jun 11, 2018 at 10:02:53AM +0200, Oleksij Rempel wrote:
>>>>> Hi all,
>>>>>
>>>>> this patch was send 05.04.2018. Any comments?
>>>>>
>>>>> @Shawn, can you please take it?
>>>>
>>>> Honestly I'm not sure how useful it will be.??If we can have some i.MX
>>>> developers ACK on it, I will be more comfortable to take it.
>>>
>>> This is all highly experimental and in PoC stage, but we see some value
>>> in running a second Linux system on the M4 coprocessor. There are lots
>>> of things that still need to be figured out, but we are working on this
>>> from time to time when there are some hours to spare.
>>>
>>> This patch seems like a good step in the right direction and IMHO the
>>> amount of code and changes is small enough to carry it upstream without
>>> impacting anything else. I would be happy if this could be pulled in.
>>
>> I agree with Lucas here, this is rather minimal and not invasive.
>>
>>
>> Out of interest, on what memory region do you run Linux? Do you use
>> caches? In some experiments a while ago I noticed that only 2MiB/(or
>> 4MiB) of DDR memory can use caches, which is somewhat tight to run Linux
>> on.
>>
>> https://blog.printk.io/2017/05/i-mx-7-cortex-m4-memory-locations-and-performance/
> 
> here is DT part for master system on Cortex A7 to run Linux on Cortex M4:
> 
>         memory {
>                 device_type = "memory";
>                 reg = <0x80000000 0x40000000>;
>         };
> 
>         reserved-memory {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
> 
>                 m4_reserved_sysmem1: rproc at 88000000 {
>                         reg = <0x88000000 0x4000000>;
>                         no-map;
>                 };

So I guess that is where Linux on the M4 goes? Afaik this is in the
uncacheable area, so it is rather slow?

--
Stefan

> 
>                 /* not really needed node. used as example */
>                 m4_reserved_sysmem2: rproc at 88080000 {
>                         reg = <0x8c000000 0x80000>;
>                         no-map;
>                 };
>         };
> 
>         mailbox_test {
>                 compatible      = "mailbox-test";
>                 reg             = <0x00900000 0x00020000>, <0x00920000
> 0x00020000>;
>                 mboxes          = <&mu0a 0>, <&mu0a 0>;
>                 mbox-names      = "tx", "rx";
>         };
> };
> 
> /* node reserved for rproc */
> &uart1 {
>         assigned-clock-rates = <240000000>;
>         status = "disabled";
> };
> 
> &gpt2 {
>         assigned-clock-rates = <24000000>;
>         status = "disabled";
> };
> 
> &mu0a {
>         status = "okay";
>         #mbox-cells = <1>;
> };
> 
> &imx_rproc {
>         status = "okay";
>         memory-region = <&m4_reserved_sysmem1>,
>                         <&m4_reserved_sysmem2>;
> 
>         remote-nodes = <&gpt2>, <&uart1>;
> };
> 
> 
> 
>> --
>> Stefan
>>
>>
>>>>>
>>>>> On 05.04.2018 13:51, Oleksij Rempel wrote:
>>>>>> Provide basic support for Cortex-M4 located on NXP iMX7D.
>>>>>> This code was tested in combination with imx-rproc driver
>>>>>> which will upload with specially formatted ELF image containing
>>>>>> kernel, device and CPIO rootfs.
>>>>>>
>>>>>>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>>>> ---
>>>>>> ?arch/arm/boot/dts/Makefile?????????|??2 +-
>>>>>> ?arch/arm/mach-imx/Kconfig??????????| 33 +++++++++++++++++++++------------
>>>>>> ?arch/arm/mach-imx/Makefile?????????|??3 ++-
>>>>>> ?arch/arm/mach-imx/mach-imx7d-cm4.c | 21 +++++++++++++++++++++
>>>>>> ?4 files changed, 45 insertions(+), 14 deletions(-)
>>>>>> ?create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>>>> index 852452515bea..d49bb9a58aee 100644
>>>>>> --- a/arch/arm/boot/dts/Makefile
>>>>>> +++ b/arch/arm/boot/dts/Makefile
>>>>>> @@ -527,7 +527,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>>>>>>>>> ?	imx6ul-tx6ul-0011.dtb \
>>>>>>>>> ?	imx6ul-tx6ul-mainboard.dtb \
>>>>>>>>> ?	imx6ull-14x14-evk.dtb
>>>>>> -dtb-$(CONFIG_SOC_IMX7D) += \
>>>>>> +dtb-$(CONFIG_SOC_IMX7D_CA7) += \
>>>>>>>>> ?	imx7d-cl-som-imx7.dtb \
>>>>>>>>> ?	imx7d-colibri-emmc-eval-v3.dtb \
>>>>>>>>> ?	imx7d-colibri-eval-v3.dtb \
>>>>>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>>>>>> index 782699e67600..101c8599d952 100644
>>>>>> --- a/arch/arm/mach-imx/Kconfig
>>>>>> +++ b/arch/arm/mach-imx/Kconfig
>>>>>> @@ -528,18 +528,6 @@ config SOC_IMX6UL
>>>>>>>>> ?	help
>>>>>>>>> ?	??This enables support for Freescale i.MX6 UltraLite processor.
>>>>>> ?
>>>>>> -config SOC_IMX7D
>>>>>>>>> -	bool "i.MX7 Dual support"
>>>>>>>>> -	select PINCTRL_IMX7D
>>>>>>>>> -	select ARM_GIC
>>>>>>>>> -	select HAVE_ARM_ARCH_TIMER
>>>>>>>>> -	select HAVE_IMX_ANATOP
>>>>>>>>> -	select HAVE_IMX_MMDC
>>>>>>>>> -	select HAVE_IMX_SRC
>>>>>>>>> -	select IMX_GPCV2
>>>>>>>>> -	help
>>>>>>>>> -		This enables support for Freescale i.MX7 Dual processor.
>>>>>> -
>>>>>> ?config SOC_LS1021A
>>>>>>>>> ?	bool "Freescale LS1021A support"
>>>>>>>>> ?	select ARM_GIC
>>>>>> @@ -554,6 +542,27 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
>>>>>> ?
>>>>>> ?if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
>>>>>> ?
>>>>>> +config SOC_IMX7D_CA7
>>>>>>>>> +	bool
>>>>>>>>> +	select ARM_GIC
>>>>>>>>> +	select HAVE_ARM_ARCH_TIMER
>>>>>>>>> +	select HAVE_IMX_ANATOP
>>>>>>>>> +	select HAVE_IMX_MMDC
>>>>>>>>> +	select HAVE_IMX_SRC
>>>>>>>>> +	select IMX_GPCV2
>>>>>> +
>>>>>> +config SOC_IMX7D_CM4
>>>>>>>>> +	bool
>>>>>>>>> +	select ARMV7M_SYSTICK
>>>>>> +
>>>>>> +config SOC_IMX7D
>>>>>>>>> +	bool "i.MX7 Dual support"
>>>>>>>>> +	select PINCTRL_IMX7D
>>>>>>>>> +	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
>>>>>>>>> +	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
>>>>>>>>> +	help
>>>>>>>>> +		This enables support for Freescale i.MX7 Dual processor.
>>>>>> +
>>>>>> ?config SOC_VF610
>>>>>>>>> ?	bool "Vybrid Family VF610 support"
>>>>>>>>> ?	select ARM_GIC if ARCH_MULTI_V7
>>>>>> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
>>>>>> index 8ff71058207d..68640f100ef3 100644
>>>>>> --- a/arch/arm/mach-imx/Makefile
>>>>>> +++ b/arch/arm/mach-imx/Makefile
>>>>>> @@ -80,7 +80,8 @@ obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
>>>>>> ?obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
>>>>>> ?obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
>>>>>> ?obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
>>>>>> -obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
>>>>>> +obj-$(CONFIG_SOC_IMX7D_CA7) += mach-imx7d.o
>>>>>> +obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
>>>>>> ?
>>>>>> ?ifeq ($(CONFIG_SUSPEND),y)
>>>>>> ?AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
>>>>>> diff --git a/arch/arm/mach-imx/mach-imx7d-cm4.c b/arch/arm/mach-imx/mach-imx7d-cm4.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..c36dea79aeb8
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm/mach-imx/mach-imx7d-cm4.c
>>>>>> @@ -0,0 +1,21 @@
>>>>>> +/*
>>>>>> + * Copyright 2017 Pengutronix
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>>> + * published by the Free Software Foundation.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/kernel.h>
>>>>>> +#include <asm/v7m.h>
>>>>>> +#include <asm/mach/arch.h>
>>>>>> +
>>>>>> +static const char * const imx7d_cm4_dt_compat[] __initconst = {
>>>>>>>>> +	"fsl,imx7d-cm4",
>>>>>>>>> +	NULL,
>>>>>> +};
>>>>>> +
>>>>>> +DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual Cortex-M4 (Device Tree)")
>>>>>>>>> +	.dt_compat = imx7d_cm4_dt_compat,
>>>>>>>>> +	.restart = armv7m_restart,
>>>>>> +MACHINE_END
>>>>>>
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
