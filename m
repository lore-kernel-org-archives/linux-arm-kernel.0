From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Mar 2011 16:36:59 +0900
Subject: [PATCH] ARM: S5P: Add platform helpers for camera GPIO
	configuration
In-Reply-To: <1297447665-19492-2-git-send-email-s.nawrocki@samsung.com>
References: <1297447665-19492-1-git-send-email-s.nawrocki@samsung.com>
	<1297447665-19492-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <01c701cbd975$c7dcd2d0$57967870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Add functions for the parallel camera GPIO interface
> configuration on S5PV210 and S5PV310 SoCs.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <s.nawrocki@samsung.com>

Hmm...typo?
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

> ---
>  arch/arm/mach-s5pv210/Kconfig           |    5 +++
>  arch/arm/mach-s5pv210/Makefile          |    1 +
>  arch/arm/mach-s5pv210/setup-camera.c    |   53
> +++++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/Kconfig           |    5 +++
>  arch/arm/mach-s5pv310/Makefile          |    1 +
>  arch/arm/mach-s5pv310/setup-camera.c    |   43 +++++++++++++++++++++++++
>  arch/arm/plat-s5p/include/plat/camera.h |   26 +++++++++++++++
>  7 files changed, 134 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/setup-camera.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-camera.c
>  create mode 100644 arch/arm/plat-s5p/include/plat/camera.h
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 53aabef..300993a 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -53,6 +53,11 @@ config S5PV210_SETUP_SDHCI_GPIO
>  	help
>  	  Common setup code for SDHCI gpio.
> 
> +config S5PV210_SETUP_CAMERA

How about "S5PV210_SETUP_FIMC"?

As you know, it belong to FIMC block which is written in datasheet.
And this naming is more reasonable like SETUP_I2C...

> +	bool
> +	help
> +	  Common setup code for the camera interfaces.
> +
>  menu "S5PC110 Machines"
> 
>  config MACH_AQUILA
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index ff1a0db..d6c9f0d 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
>  obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> 
> +obj-$(CONFIG_S5PV210_SETUP_CAMERA)	+= setup-camera.o
>  obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
>  obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
>  obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
> diff --git a/arch/arm/mach-s5pv210/setup-camera.c b/arch/arm/mach-
> s5pv210/setup-camera.c
> new file mode 100644
> index 0000000..e13c354
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-camera.c

So setup-fimc.c

> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2011 Samsung Electronics Co., Ltd.
> + *
> + * S5PV310 camera interface GPIO configuration.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/gpio.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/camera.h>
> +
> +/*
> + * Configure the camera parallel bus pins. The parallel bus can be
> multiplexed
> + * with any FIMC entity. Even multiple FIMC entities are allowed to be
> attached
> + * to a particular (A or B) gpio interface. This function should be
called
> from
> + * a board setup code.
> + */
> +int s5pv210_camif_cfg_gpio(enum s5p_camif_id id)

int s5pv210_fimc_cfg_gpio...

> +{
> +	u32 gpio8, gpio5;
> +	int ret;
> +	int i = 5;
> +
> +	switch (id) {
> +	case S5P_CAMIF_A:
> +		gpio8 = S5PV210_GPE0(0);
> +		gpio5 = S5PV210_GPE1(0);
> +		break;

Blank line?

> +	case S5P_CAMIF_B:
> +		gpio8 = S5PV210_GPJ0(0);
> +		gpio5 = S5PV210_GPJ1(0);
> +		break;

Same...

> +	default:
> +		WARN(1, "id: %d\n", id);
> +		return -EINVAL;
> +	}
> +
> +	ret = s3c_gpio_cfgall_range(gpio8, 8, S3C_GPIO_SFN(2),
> +				    S3C_GPIO_PULL_UP);
> +	if (ret)
> +		return ret;
> +
> +	ret = s3c_gpio_cfgall_range(gpio5, 5, S3C_GPIO_SFN(2),
> +				    S3C_GPIO_PULL_UP);

Where is "return ret;" ?

> +
> +	while (i-- && !ret)
> +		ret = s5p_gpio_set_drvstr(S5PV210_GPE1(i),
> +					  S5P_GPIO_DRVSTR_LV4);

Basically drive strength depends on each board. So I think, should be
removed here.

> +	return ret;
> +}
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index b2a9acc..ccd1dc4 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -71,6 +71,11 @@ config S5PV310_DEV_SYSMMU
>  	help
>  	  Common setup code for SYSTEM MMU in S5PV310
> 
> +config S5PV310_SETUP_CAMERA

S5PV310_SETUP_FIMC ?

> +	bool
> +	help
> +	  Common setup code for the camera interfaces.
> +
>  # machine support
> 
>  menu "S5PC210 Machines"
> diff --git a/arch/arm/mach-s5pv310/Makefile
b/arch/arm/mach-s5pv310/Makefile
> index 036fb38..c1d6577 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -32,6 +32,7 @@ obj-y					+=
dev-audio.o
>  obj-$(CONFIG_S5PV310_DEV_PD)		+= dev-pd.o
>  obj-$(CONFIG_S5PV310_DEV_SYSMMU)	+= dev-sysmmu.o
> 
> +obj-$(CONFIG_S5PV310_SETUP_CAMERA)	+= setup-camera.o
>  obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
>  obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
>  obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= setup-i2c3.o
> diff --git a/arch/arm/mach-s5pv310/setup-camera.c b/arch/arm/mach-
> s5pv310/setup-camera.c
> new file mode 100644
> index 0000000..8ab239e
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-camera.c

Almost same.

(snip)

> diff --git a/arch/arm/plat-s5p/include/plat/camera.h b/arch/arm/plat-
> s5p/include/plat/camera.h
> new file mode 100644
> index 0000000..f7c66ec
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/camera.h

How about camport.h?

> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (C) 2011 Samsung Electronics Co., Ltd.
> + *
> + * S5P series camera interface helper functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef PLAT_S5P_CAMERA_H_
> +#define PLAT_S5P_CAMERA_H_ __FILE__
> +
> +enum s5p_camif_id {
> +	S5P_CAMIF_A,
> +	S5P_CAMIF_B,
> +};

Because I think, "CAMPORT" is more clearly.

enum s5p_camport_id {
	S5P_CAMPORT_A,
	S5P_CAMPORT_B,
};


> +
> +/**
> + * s5pvX10_camif_cfg_gpio - configure IO pins of the camera A/B interface
> + * @id: id of a camera gpio interface
> + */
> +int s5pv210_camif_cfg_gpio(enum s5p_camif_id id);
> +int s5pv310_camif_cfg_gpio(enum s5p_camif_id id);
> +
> +#endif /* PLAT_S5P_CAMERA_H_ */
> --



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
