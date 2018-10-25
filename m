From: dachaac@gmail.com (=?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?=)
Date: Thu, 25 Oct 2018 23:53:56 +0300
Subject: [PATCH v2 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
In-Reply-To: <20181026122424.30831-4-nava.manne@xilinx.com>
References: <20181026122424.30831-1-nava.manne@xilinx.com>
 <20181026122424.30831-4-nava.manne@xilinx.com>
Message-ID: <437c1bc9-8d5b-7b2a-f612-993151c23f7c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some comments below.

On 26/10/2018 15.24, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-Fixed some minor coding issues as suggested
> 		 by philipp.
>
> Changes for v1:
> 		-None.
>
> Changes for RFC-V3:
> 		-None.
>
> Changes for RFC-V2:
> 		-Moved eemi_ops into a priv struct as suggested
> 		 by philipp.
>
>   drivers/reset/Makefile       |   1 +
>   drivers/reset/reset-zynqmp.c | 114 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 115 insertions(+)
>   create mode 100644 drivers/reset/reset-zynqmp.c
>
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4243c38..eb315d1 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -24,4 +24,5 @@ obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>   obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>   obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
>   obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>   
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> new file mode 100644
> index 0000000..cff63d9
> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
Probably should be:

+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 1)

or if START is moved one forward:

+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)

> +#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
If you move start forward then you don't need +1 here. Or you can get 
rid of the define altogether and just use ZYNQMP_PM_RESET_START in it's 
place..

Thanks,
Vesa J??skel?inen
