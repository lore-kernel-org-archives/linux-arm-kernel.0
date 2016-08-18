From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 18 Aug 2016 14:07:17 +0200
Subject: [PATCH 2/4] soc: qcom: add EBI2 driver
In-Reply-To: <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160818140717.7b5c2bbd@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon,  8 Aug 2016 23:24:03 +0200 Linus Walleij wrote:
> This adds a driver for the Qualcomm External Bus Interface EBI2
> found in the MSM8660 and APQ8060 SoCs (at least).
> 
> This was tested with the SMSC9112 ethernet on the APQ8060
> Dragonboard sitting on top of the SLOW CS2.
> 
> Some of my understanding if very vague and based on guesses and
> extrapolations: the documentation in APQ8060 Qualcomm Application
> Processor User Guide 80-N7150-14 Rev. A describes select features but
> does not document the register bit fields.
> 
> However I had to do something like this to provide a serious driver,
> I have marked the guesses with /* GUESS */
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig  |   8 +
>  drivers/soc/qcom/Makefile |   1 +
>  drivers/soc/qcom/ebi2.c   | 371 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 380 insertions(+)
>  create mode 100644 drivers/soc/qcom/ebi2.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 461b387d03cc..1f56baa30807 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -76,3 +76,11 @@ config QCOM_WCNSS_CTRL
>  	help
>  	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
>  	  firmware to a newly booted WCNSS chip.
> +
> +config QCOM_EBI2
> +	bool "Qualcomm External Bus Interface 2 (EBI2)"
> +	default y if ARCH_MSM8X60
> +	help
> +	  Say y here to enable support for the Qualcomm External Bus
> +	  Interface 2, which can be used to connect things like NAND Flash,
> +	  SRAM, ethernet adapters, FPGAs and LCD displays.
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index fdd664edf0bd..8d5a8d738d0a 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
> +obj-$(CONFIG_QCOM_EBI2)	+= ebi2.o
> diff --git a/drivers/soc/qcom/ebi2.c b/drivers/soc/qcom/ebi2.c
> new file mode 100644
> index 000000000000..f90c5d13fb5a
> --- /dev/null
> +++ b/drivers/soc/qcom/ebi2.c
> @@ -0,0 +1,371 @@
> +/*
> + * Qualcomm External Bus Interface 2 (EBI2) driver
> + * an older version of the Qualcomm Parallel Interface Controller (QPIC)
> + *
> + * Copyright (C) 2016 Linaro Ltd.
> + *
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + * See the device tree bindings for this block for more details on the
> + * hardware.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitops.h>
> +
> +/* Guessed bit placement CS2 and CS3 are certain */
> +/* What about CS1A, CS1B, CS2A, CS2B? */
> +#define EBI2_CS0_ENABLE BIT(2) /* GUESS */
> +#define EBI2_CS1_ENABLE BIT(3) /* GUESS */
> +#define EBI2_CS2_ENABLE BIT(4)
> +#define EBI2_CS3_ENABLE BIT(5)
> +#define EBI2_CS4_ENABLE BIT(6) /* GUESS */
> +#define EBI2_CS5_ENABLE BIT(7) /* GUESS */
> +#define EBI2_CSN_MASK BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7)
> +
missing '()' around expression, otherwise...

> +	csval &= ~EBI2_CSN_MASK;
...this will be '~BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7)'
which is most likely NOT what's intended.

(Also spaces around the '|' operator would improve readability)


Lothar Wa?mann
