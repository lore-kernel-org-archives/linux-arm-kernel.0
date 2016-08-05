From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 5 Aug 2016 19:15:33 -0400
Subject: [PATCH v2 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <1470345071-9455-3-git-send-email-nleeder@codeaurora.org>
References: <1470345071-9455-1-git-send-email-nleeder@codeaurora.org>
 <1470345071-9455-3-git-send-email-nleeder@codeaurora.org>
Message-ID: <CAP=VYLo5pBHd1=K78jMvg7XkT6Bn4NP9m+1K34dGyJ0ZRugwkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2016 at 5:11 PM, Neil Leeder <nleeder@codeaurora.org> wrote:
> Adds perf events support for L2 cache PMU.
>
> The L2 cache PMU driver is named 'l2cache_0' and can be used
> with perf events to profile L2 events such as cache hits
> and misses.
>
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig               |  10 +
>  drivers/soc/qcom/Makefile              |   1 +
>  drivers/soc/qcom/perf_event_l2.c       | 839 +++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/perf_event_l2.h |  81 ++++
>  4 files changed, 931 insertions(+)
>  create mode 100644 drivers/soc/qcom/perf_event_l2.c
>  create mode 100644 include/linux/soc/qcom/perf_event_l2.h
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 21ec616..0b5ddb9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -19,6 +19,16 @@ config QCOM_L2_ACCESSORS
>           Provides support for accessing registers in the L2 cache
>           for Qualcomm Technologies chips.
>
> +config QCOM_PERF_EVENTS_L2
> +       bool "Qualcomm Technologies L2-cache perf events"

Since this is a bool, you shouldn't need module.h in your driver or
any MODULE_<xyz> tags (if there are any).

Thanks,
Paul.
--

> +       depends on ARCH_QCOM && HW_PERF_EVENTS && ACPI
> +       select QCOM_L2_ACCESSORS
> +         help
> +         Provides support for the L2 cache performance monitor unit (PMU)
> +         in Qualcomm Technologies processors.
> +         Adds the L2 cache PMU into the perf events subsystem for
> +         monitoring L2 cache events.
> +
>  config QCOM_PM
>         bool "Qualcomm Power Management"
>         depends on ARCH_QCOM && !ARM64
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6ef29b9..c8e89ca9 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_QCOM_GSBI)        +=      qcom_gsbi.o
>  obj-$(CONFIG_QCOM_L2_ACCESSORS) += l2-accessors.o
> +obj-$(CONFIG_QCOM_PERF_EVENTS_L2)      += perf_event_l2.o
>  obj-$(CONFIG_QCOM_PM)  +=      spm.o
>  obj-$(CONFIG_QCOM_SMD) +=      smd.o
>  obj-$(CONFIG_QCOM_SMD_RPM)     += smd-rpm.o
> diff --git a/drivers/soc/qcom/perf_event_l2.c b/drivers/soc/qcom/perf_event_l2.c
> new file mode 100644
> index 0000000..54c6790
> --- /dev/null
> +++ b/drivers/soc/qcom/perf_event_l2.c
> @@ -0,0 +1,839 @@
> +/* Copyright (c) 2015,2016 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#define pr_fmt(fmt) "l2 perfevents: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/list.h>
> +#include <linux/acpi.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/perf_event_l2.h>
> +#include <linux/soc/qcom/l2-accessors.h>
> +#include <linux/topology.h>
