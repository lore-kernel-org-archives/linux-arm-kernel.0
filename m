From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 23:50:07 +0530
Subject: [PATCH 13/16] drivers: misc: add ARM CCI support
In-Reply-To: <1357777251-13541-14-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-14-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50F057D7.1010808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> On ARM multi-cluster systems coherency between cores running on
> different clusters is managed by the cache-coherent interconnect (CCI).
> It allows broadcasting of TLB invalidates and memory barriers and it
> guarantees cache coherency at system level.
>
> This patch enables the basic infrastructure required in Linux to
> handle and programme the CCI component. The first implementation is
> based on a platform device, its relative DT compatible property and
> a simple programming interface.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   drivers/misc/Kconfig    |   3 ++
>   drivers/misc/Makefile   |   1 +
>   drivers/misc/arm-cci.c  | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/arm-cci.h |  30 ++++++++++++++
How about 'drivers/bus/' considering CCI is an interconnect bus (though
for coherency)

>   4 files changed, 141 insertions(+)
>   create mode 100644 drivers/misc/arm-cci.c
>   create mode 100644 include/linux/arm-cci.h
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b151b7c1bd..30d5be1ad2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -499,6 +499,9 @@ config USB_SWITCH_FSA9480
>   	  stereo and mono audio, video, microphone and UART data to use
>   	  a common connector port.
>
> +config ARM_CCI
You might want add depends on ARM big.LITTTLE otherwise it will
break build for other arch's with random configurations.

[..]

> diff --git a/drivers/misc/arm-cci.c b/drivers/misc/arm-cci.c
> new file mode 100644
> index 0000000000..f329c43099
> --- /dev/null
> +++ b/drivers/misc/arm-cci.c
> @@ -0,0 +1,107 @@
> +/*
> + * CCI support
> + *
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/arm-cci.h>
> +
> +#define CCI400_EAG_OFFSET       0x4000
> +#define CCI400_KF_OFFSET        0x5000
> +
> +#define DRIVER_NAME	"CCI"
> +struct cci_drvdata {
> +	void __iomem *baseaddr;
> +	spinlock_t lock;
> +};
> +
> +static struct cci_drvdata *info;
> +
> +void disable_cci(int cluster)
> +{
> +	u32 cci_reg = cluster ? CCI400_KF_OFFSET : CCI400_EAG_OFFSET;
> +	writel_relaxed(0x0, info->baseaddr	+ cci_reg);
> +
> +	while (readl_relaxed(info->baseaddr + 0xc) & 0x1)
> +			;
> +}
> +EXPORT_SYMBOL_GPL(disable_cci);
> +
Is more functionality going to be added for CCI driver. Having this
much of driver code for just a disable_cci() functions seems like
overkill.

Regards
Santosh
