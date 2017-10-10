From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 9 Oct 2017 19:49:47 -0500
Subject: [PATCH v3 4/5] soc: qcom: Remote filesystem memory driver
In-Reply-To: <20171005033258.12825-5-bjorn.andersson@linaro.org>
References: <20171005033258.12825-1-bjorn.andersson@linaro.org>
 <20171005033258.12825-5-bjorn.andersson@linaro.org>
Message-ID: <CAL_JsqK+pGsAf+FYTFDUGreTsCU_Rc7ouDsyE6hXJkYexomkzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 10:32 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The Qualcomm remote file system protocol is used by certain remoteprocs,
> in particular the modem, to read and write persistent storage in
> platforms where only the application CPU has physical storage access.
>
> The protocol is based on a set of QMI-encoded control-messages and a
> shared memory buffer for exchaning the data. This driver implements the
> latter, providing the user space service access to the carved out chunk
> of memory.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - Renamed driver to "rmtfs_mem" in attempt to clarify that this is not a
>   file system, but some chunk of memory.
>
> Changes since v1:
> - RFSA device represented direclty by the reserved-memory node
>
>  drivers/of/platform.c        |   1 +
>  drivers/soc/qcom/Kconfig     |  11 ++
>  drivers/soc/qcom/Makefile    |   1 +
>  drivers/soc/qcom/rmtfs_mem.c | 272 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 285 insertions(+)
>  create mode 100644 drivers/soc/qcom/rmtfs_mem.c
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index ee89f096f0f3..e7548c9a9915 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -498,6 +498,7 @@ EXPORT_SYMBOL_GPL(of_platform_default_populate);
>
>  #ifndef CONFIG_PPC
>  static const struct of_device_id reserved_mem_matches[] = {
> +       { .compatible = "qcom,rmtfs-mem" },
>         { .compatible = "ramoops" },
>         {}
>  };
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 9fca977ef18d..6dff89eaf3f8 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -24,6 +24,17 @@ config QCOM_PM
>           modes. It interface with various system drivers to put the cores in
>           low power modes.
>
> +config QCOM_RMTFS_MEM
> +       tristate "Qualcomm Remote Filesystem memory driver"
> +       depends on ARCH_QCOM
> +       help
> +         The Qualcomm remote filesystem memory driver is used for allocating
> +         and exposing regions of shared memory with remote processors for the
> +         purpose of exchanging sector-data between the remote filesystem
> +         service and its clients.
> +
> +         Say y here if you intend to boot the modem remoteproc.
> +
>  config QCOM_SMEM
>         tristate "Qualcomm Shared Memory Manager (SMEM)"
>         depends on ARCH_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 414f0de274fa..541c1f40d126 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_QCOM_GSBI)        +=      qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)  += mdt_loader.o
>  obj-$(CONFIG_QCOM_PM)  +=      spm.o
> +obj-$(CONFIG_QCOM_RMTFS_MEM)   += rmtfs_mem.o
>  obj-$(CONFIG_QCOM_SMD_RPM)     += smd-rpm.o
>  obj-$(CONFIG_QCOM_SMEM) +=     smem.o
>  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> new file mode 100644
> index 000000000000..2e7c955e7cf0
> --- /dev/null
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -0,0 +1,272 @@
> +/*
> + * Copyright (c) 2017 Linaro Ltd.
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
> +
> +#include <linux/kernel.h>
> +#include <linux/cdev.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/of_fdt.h>

This shouldn't be needed?


> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +#include <linux/qcom_scm.h>
