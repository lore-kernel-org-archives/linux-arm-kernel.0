From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 3 Jul 2018 09:06:47 +0200
Subject: [PATCH v2] ARM: imx: Provide support for NXP i.MX7D Cortex-M4
In-Reply-To: <20180703065724.GL4348@dragon>
References: <20180702062755.17263-1-o.rempel@pengutronix.de>
 <20180703065724.GL4348@dragon>
Message-ID: <522e3bdf-9cdf-f584-b063-38dd23982096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03.07.2018 08:57, Shawn Guo wrote:
> On Mon, Jul 02, 2018 at 08:27:55AM +0200, Oleksij Rempel wrote:
>> Cortex M4 part can be started from a boot loader or over
>> Linux remoteproc framework.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/Makefile         |  2 +-
>>  arch/arm/mach-imx/Kconfig          | 33 +++++++++++++++++++-----------
>>  arch/arm/mach-imx/Makefile         |  3 ++-
>>  arch/arm/mach-imx/mach-imx7d-cm4.c | 21 +++++++++++++++++++
>>  4 files changed, 45 insertions(+), 14 deletions(-)
>>  create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 7e2424957809..e3fe1bfbc404 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -539,7 +539,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>>  	imx6ull-14x14-evk.dtb \
>>  	imx6ull-colibri-eval-v3.dtb \
>>  	imx6ull-colibri-wifi-eval-v3.dtb
>> -dtb-$(CONFIG_SOC_IMX7D) += \
>> +dtb-$(CONFIG_SOC_IMX7D_CA7) += \
> 
> We agreed to keep this unchanged, no?

yes. sorry.

>>  	imx7d-cl-som-imx7.dtb \
>>  	imx7d-colibri-emmc-eval-v3.dtb \
>>  	imx7d-colibri-eval-v3.dtb \
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index e47fa13f4b0c..5ad58b1cb4bc 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -522,18 +522,6 @@ config SOC_IMX6UL
>>  	help
>>  	  This enables support for Freescale i.MX6 UltraLite processor.
>>  
>> -config SOC_IMX7D
>> -	bool "i.MX7 Dual support"
>> -	select PINCTRL_IMX7D
>> -	select ARM_GIC
>> -	select HAVE_ARM_ARCH_TIMER
>> -	select HAVE_IMX_ANATOP
>> -	select HAVE_IMX_MMDC
>> -	select HAVE_IMX_SRC
>> -	select IMX_GPCV2
>> -	help
>> -		This enables support for Freescale i.MX7 Dual processor.
>> -
>>  config SOC_LS1021A
>>  	bool "Freescale LS1021A support"
>>  	select ARM_GIC
>> @@ -548,6 +536,27 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
>>  
>>  if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
>>  
>> +config SOC_IMX7D_CA7
>> +	bool
>> +	select ARM_GIC
>> +	select HAVE_ARM_ARCH_TIMER
>> +	select HAVE_IMX_ANATOP
>> +	select HAVE_IMX_MMDC
>> +	select HAVE_IMX_SRC
>> +	select IMX_GPCV2
>> +
>> +config SOC_IMX7D_CM4
>> +	bool
>> +	select ARMV7M_SYSTICK
>> +
>> +config SOC_IMX7D
>> +	bool "i.MX7 Dual support"
>> +	select PINCTRL_IMX7D
>> +	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
>> +	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
>> +	help
>> +		This enables support for Freescale i.MX7 Dual processor.
>> +
>>  config SOC_VF610
>>  	bool "Vybrid Family VF610 support"
>>  	select ARM_GIC if ARCH_MULTI_V7
>> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
>> index 2327e3e876d8..64ebeb6a4f30 100644
>> --- a/arch/arm/mach-imx/Makefile
>> +++ b/arch/arm/mach-imx/Makefile
>> @@ -81,7 +81,8 @@ obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
>>  obj-$(CONFIG_SOC_IMX6SLL) += mach-imx6sl.o
>>  obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
>>  obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
>> -obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
>> +obj-$(CONFIG_SOC_IMX7D_CA7) += mach-imx7d.o
>> +obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
>>  
>>  ifeq ($(CONFIG_SUSPEND),y)
>>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
>> diff --git a/arch/arm/mach-imx/mach-imx7d-cm4.c b/arch/arm/mach-imx/mach-imx7d-cm4.c
>> new file mode 100644
>> index 000000000000..c36dea79aeb8
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/mach-imx7d-cm4.c
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright 2017 Pengutronix
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
> 
> Can we use SPDX tag for new file?

ok.

> Shawn
> 
>> +
>> +#include <linux/kernel.h>
>> +#include <asm/v7m.h>
>> +#include <asm/mach/arch.h>
>> +
>> +static const char * const imx7d_cm4_dt_compat[] __initconst = {
>> +	"fsl,imx7d-cm4",
>> +	NULL,
>> +};
>> +
>> +DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual Cortex-M4 (Device Tree)")
>> +	.dt_compat = imx7d_cm4_dt_compat,
>> +	.restart = armv7m_restart,
>> +MACHINE_END
>> -- 
>> 2.17.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/b4295a22/attachment.sig>
