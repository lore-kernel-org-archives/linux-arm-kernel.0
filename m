From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 03 Aug 2010 13:50:20 +0900
Subject: [PATCH v2 3/3] ARM: S5PC210: Add I2C0/I2C1/I2C2 support
In-Reply-To: <20100802002545.GA32265@july>
References: <20100802002545.GA32265@july>
Message-ID: <00ef01cb32c7$625995b0$270cc110$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Configure proper mux pins and define i2c0/i2c1/i2c2.
> 
> v1:
> 	Use the linux/gpio.h

In future, please make sure your patch has no problem with
scripts/checkpatch.pl.
I got the result of it like following...I will fix it.

--
ERROR: code indent should use tabs where possible
#78: FILE: arch/arm/mach-s5pv310/setup-i2c0.c:24:
+        s3c_gpio_cfgpin(S5PV310_GPD1(0), S3C_GPIO_SFN(2));$

ERROR: code indent should use tabs where possible
#79: FILE: arch/arm/mach-s5pv310/setup-i2c0.c:25:
+        s3c_gpio_setpull(S5PV310_GPD1(0), S3C_GPIO_PULL_UP);$

ERROR: code indent should use tabs where possible
#80: FILE: arch/arm/mach-s5pv310/setup-i2c0.c:26:
+        s3c_gpio_cfgpin(S5PV310_GPD1(1), S3C_GPIO_SFN(2));$

ERROR: code indent should use tabs where possible
#81: FILE: arch/arm/mach-s5pv310/setup-i2c0.c:27:
+        s3c_gpio_setpull(S5PV310_GPD1(1), S3C_GPIO_PULL_UP);$

...

total: 12 errors, 1 warnings, 95 lines checked
--

And if you want to add changes, please add it next of the line of
'---'..because no need to add the changes in commit message.

Others looks ok..will apply with fixing coding-style.

> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig      |   10 ++++++++++
>  arch/arm/mach-s5pv310/Makefile     |    5 +++++
>  arch/arm/mach-s5pv310/setup-i2c0.c |   12 ++++++++++--
>  arch/arm/mach-s5pv310/setup-i2c1.c |   25 +++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/setup-i2c2.c |   25 +++++++++++++++++++++++++
>  5 files changed, 75 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c1.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c2.c
> 
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index 2fe8149..faa3436 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -15,6 +15,16 @@ config CPU_S5PV310
>  	help
>  	  Enable S5PV310 CPU support
> 
> +config S5PV310_SETUP_I2C1
> +	bool
> +	help
> +	  Common setup code for i2c bus 1.
> +
> +config S5PV310_SETUP_I2C2
> +	bool
> +	help
> +	  Common setup code for i2c bus 2.
> +
>  # machine support
> 
>  config MACH_SMDKV310
> diff --git a/arch/arm/mach-s5pv310/Makefile
b/arch/arm/mach-s5pv310/Makefile
> index 5b52132..82dbbaa 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -23,3 +23,8 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
> 
>  obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
>  obj-$(CONFIG_MACH_UNIVERSAL)	+= mach-universal.o
> +
> +# device support
> +
> +obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
> +obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
> diff --git a/arch/arm/mach-s5pv310/setup-i2c0.c
b/arch/arm/mach-s5pv310/setup-
> i2c0.c
> index d4f5a81..a29f5e6 100644
> --- a/arch/arm/mach-s5pv310/setup-i2c0.c
> +++ b/arch/arm/mach-s5pv310/setup-i2c0.c
> @@ -1,4 +1,5 @@
> -/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
> +/*
> + * linux/arch/arm/mach-s5pv310/setup-i2c0.c
>   *
>   * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
> @@ -14,7 +15,14 @@
> 
>  struct platform_device; /* don't need the contents */
> 
> +#include <linux/gpio.h>
> +#include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> +
>  void s3c_i2c0_cfg_gpio(struct platform_device *dev)
>  {
> -/* will be implemented later */
> +        s3c_gpio_cfgpin(S5PV310_GPD1(0), S3C_GPIO_SFN(2));
> +        s3c_gpio_setpull(S5PV310_GPD1(0), S3C_GPIO_PULL_UP);
> +        s3c_gpio_cfgpin(S5PV310_GPD1(1), S3C_GPIO_SFN(2));
> +        s3c_gpio_setpull(S5PV310_GPD1(1), S3C_GPIO_PULL_UP);
>  }
> diff --git a/arch/arm/mach-s5pv310/setup-i2c1.c
b/arch/arm/mach-s5pv310/setup-
> i2c1.c
> new file mode 100644
> index 0000000..8ce6ebd
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-i2c1.c
> @@ -0,0 +1,25 @@
> +/*
> + * linux/arch/arm/mach-s5pv310/setup-i2c1.c
> + *
> + * Copyright (C) 2010 Samsung Electronics Co., Ltd.
> + *
> + * I2C1 GPIO configuration.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +struct platform_device; /* don't need the contents */
> +
> +#include <linux/gpio.h>
> +#include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> +
> +void s3c_i2c1_cfg_gpio(struct platform_device *dev)
> +{
> +        s3c_gpio_cfgpin(S5PV310_GPD1(2), S3C_GPIO_SFN(2));
> +        s3c_gpio_setpull(S5PV310_GPD1(2), S3C_GPIO_PULL_UP);
> +        s3c_gpio_cfgpin(S5PV310_GPD1(3), S3C_GPIO_SFN(2));
> +        s3c_gpio_setpull(S5PV310_GPD1(3), S3C_GPIO_PULL_UP);
> +}
> diff --git a/arch/arm/mach-s5pv310/setup-i2c2.c
b/arch/arm/mach-s5pv310/setup-
> i2c2.c
> new file mode 100644
> index 0000000..dcae14f
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-i2c2.c
> @@ -0,0 +1,25 @@
> +/*
> + * linux/arch/arm/mach-s5pv310/setup-i2c2.c
> + *
> + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> + *
> + * I2C2 GPIO configuration.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +struct platform_device; /* don't need the contents */
> +
> +#include <linux/gpio.h>
> +#include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> +
> +void s3c_i2c2_cfg_gpio(struct platform_device *dev)
> +{
> +        s3c_gpio_cfgpin(S5PV310_GPA0(6), S3C_GPIO_SFN(3));
> +        s3c_gpio_setpull(S5PV310_GPA0(6), S3C_GPIO_PULL_UP);
> +        s3c_gpio_cfgpin(S5PV310_GPA0(7), S3C_GPIO_SFN(3));
> +        s3c_gpio_setpull(S5PV310_GPA0(7), S3C_GPIO_PULL_UP);
> +}
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
