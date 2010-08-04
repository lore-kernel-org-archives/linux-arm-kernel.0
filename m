From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Aug 2010 20:29:13 +0900
Subject: [PATCH v6 1/7] ARM: S5PV210: Allow to probe EVT revision number.
In-Reply-To: <1280829866-26001-2-git-send-email-myungjoo.ham@samsung.com>
References: <1280829866-26001-1-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <001a01cb33c8$46f44340$d4dcc9c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Early products of S5PV210, EVT0, had several errata that require
> kernel to avoid using some parts/instructions of the CPU or to
> add protection instructions. There are products with such early
> production CPUs; thus, we want to distinguish them in kernel.
> This patch is to distinguish such products.
> 
> Include <mach/hardware.h> and call s5pv210_revision().
> 
> For example,
> 
> 	if (s5pv210_revision(EVT0)) {
> 		... execute code targeted only to EVT0 ...
> 	} else {
> 		... execute normal code ...
> 	}
> 
> Call set_s5pv210_revision(EVTx) when the EVT revision number can be
> identified. We have EVT0, EVT1, and EVT1-Fused avaialble right now and
> only EVT1-Fused has the unique revision number at chipid (PRO_ID
> register). A function, get_s5pv210_revision_chipid(), returns EVT
> revision number if the revision is identified by the chipid; otherwise,
> the function returns EVT_UNKNOWN. When EVT cannot be identified with
> chipid, it can be identified at board support file
> (arch/arm/mach-s5pv210/mach-*.c), not at the cpu file
> (arch/arm/mach-s5pv210/cpu.c).
> 
> For Aquila machine. (mach-aquila.c)
> 
> Part of Aquila machines have the early production CPUs that require
> to address errata issues. Note that we don't do this for GONI machines
> because they have never used early production CPUs with errata. Besides,
> please note that there are other boards that use such early produces
> other than Aquila. However, those boards/machines are not registered at
> the /linux/arch/arm/tools/mach-types, yet; thus, we have omitted them
> in this patch.
> 
> For Goni machine. (mach-goni.c)
> 
> It's either EVT1 or EVT1-Fused; thus, it can be identified by
> get_s5pv210_revision_chipid() function.
> 
I think, your commit description(message) need to update with your changes.

> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> v5 updates:
> 	- rename revision check function.
> 	- revise revision check functions so that it does not access
> 	  board-related information.
> 	- chipid is used to identify EVT revision.
> 	- added "s5pv210_revision_or_later()" function
> v6 updates:
> 	- removed consideration for EVT1-FUSED
> 
> ---
>  arch/arm/mach-s5pv210/cpu.c                   |   13 +++++++++++++
>  arch/arm/mach-s5pv210/include/mach/hardware.h |   12 +++++++++++-
>  arch/arm/mach-s5pv210/mach-aquila.c           |    9 +++++++++
>  arch/arm/mach-s5pv210/mach-goni.c             |    3 +++
>  4 files changed, 36 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index 94c632b..74d4c08 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -27,6 +27,7 @@
>  #include <asm/proc-fns.h>
>  #include <mach/map.h>
>  #include <mach/regs-clock.h>
> +#include <mach/hardware.h>
> 
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
> @@ -128,6 +129,18 @@ static struct sys_device s5pv210_sysdev = {
>  	.cls	= &s5pv210_sysclass,
>  };
> 
> +static bool s5pv210_evt0;
> +
> +bool s5pv210_revision_evt0(void)
> +{
> +	return s5pv210_evt0 == true;
> +}
> +
> +void set_s5pv210_revision_evt0(bool evt0)
> +{
> +	s5pv210_evt0 = evt0;
> +}
> +

I'm not sure we _really_ need above functions...just one of extern variable
such as 's5pv210_evt_version' can handle this functionality...?

>  static int __init s5pv210_core_init(void)
>  {
>  	return sysdev_class_register(&s5pv210_sysclass);
> diff --git a/arch/arm/mach-s5pv210/include/mach/hardware.h
b/arch/arm/mach-
> s5pv210/include/mach/hardware.h
> index fada7a3..fa50868 100644
> --- a/arch/arm/mach-s5pv210/include/mach/hardware.h
> +++ b/arch/arm/mach-s5pv210/include/mach/hardware.h
> @@ -13,6 +13,16 @@
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H __FILE__
> 
> -/* currently nothing here, placeholder */
> +extern bool s5pv210_revision_evt0(void);
> +extern void set_s5pv210_revision_evt0(bool);
> +
> +/*
> + * get_s5pv210_revision_chipid returns s5pv210_revision if the
> + * EVT revision can be determined by the chipid(PRO_ID) register.
> + * However, note that only EVT1-FUSED can be identified from it and
> + * it cannot distinguish between EVT0 and EVT1. In such case, it
> + * returns EVT_UNKNOWN. In such case use set_s5pv210_revision() to
> + * set the revision number manually.
> + */
> 
>  #endif /* __ASM_ARCH_HARDWARE_H */
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c
b/arch/arm/mach-s5pv210/mach-
> aquila.c
> index 46d5c7e..6a8deaa 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -30,6 +30,7 @@
>  #include <mach/regs-clock.h>
>  #include <mach/regs-fb.h>
>  #include <mach/gpio.h>
> +#include <mach/hardware.h>
> 
>  #include <plat/gpio-cfg.h>
>  #include <plat/regs-serial.h>
> @@ -536,6 +537,14 @@ static void __init aquila_map_io(void)
> 
>  static void __init aquila_machine_init(void)
>  {
> +	/* CPU Revision (EVTx) */
> +	set_s5pv210_revision_evt0(false);
> +	if (system_rev & 0x0800) {
> +		if ((system_rev & 0xF) < 8)

...

> +			set_s5pv210_revision_evt0(true);
> +	} else if (system_rev & 0x2000)
> +		set_s5pv210_revision_evt0(true);
> +
>  	/* PMIC */
>  	aquila_pmic_init();
>  	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
> i2c_gpio_pmic_devs,
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 380d2ae..08ee3f6 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -32,6 +32,7 @@
>  #include <mach/regs-clock.h>
>  #include <mach/regs-fb.h>
>  #include <mach/gpio.h>
> +#include <mach/hardware.h>
> 
>  #include <plat/gpio-cfg.h>
>  #include <plat/regs-serial.h>
> @@ -520,6 +521,8 @@ static void __init goni_map_io(void)
> 
>  static void __init goni_machine_init(void)
>  {
> +	set_s5pv210_revision_evt0(false);
> +
>  	/* PMIC */
>  	goni_pmic_init();
>  	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
> i2c_gpio_pmic_devs,
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
