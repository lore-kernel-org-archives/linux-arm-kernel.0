From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2018 09:26:11 +0100
Subject: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
In-Reply-To: <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180727082611.GE4628@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jul 2018, Jae Hyun Yoo wrote:

> This commit adds PECI client MFD driver.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                   |  14 ++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
>  include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>  4 files changed, 278 insertions(+)
>  create mode 100644 drivers/mfd/intel-peci-client.c
>  create mode 100644 include/linux/mfd/intel-peci-client.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f3fa516011ec..e38b591479d4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PECI_CLIENT
> +	bool "Intel PECI client"
> +	depends on (PECI || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  multi-funtional Intel PECI (Platform Environment Control Interface)
> +	  client. PECI is a one-wire bus interface that provides a communication
> +	  channel from PECI clients in Intel processors and chipset components
> +	  to external monitoring or control devices.
> +
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2852a6042ecf..29e2cacc58bd 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT)	+= intel-peci-client.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
> new file mode 100644
> index 000000000000..d7702cf1ea50
> --- /dev/null
> +++ b/drivers/mfd/intel-peci-client.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-peci-client.h>
> +#include <linux/module.h>
> +#include <linux/peci.h>
> +#include <linux/of_device.h>
> +
> +enum cpu_gens {
> +	CPU_GEN_HSX = 0, /* Haswell Xeon */
> +	CPU_GEN_BRX,     /* Broadwell Xeon */
> +	CPU_GEN_SKX,     /* Skylake Xeon */
> +};
> +
> +static struct mfd_cell peci_functions[] = {
> +	{
> +		.name = "peci-cputemp",
> +		.of_compatible = "intel,peci-cputemp",
> +	},
> +	{
> +		.name = "peci-dimmtemp",
> +		.of_compatible = "intel,peci-dimmtemp",
> +	},
> +};

The more I look at this driver, the less I think it fits into MFD.

What's stopping you from registering these devices directly from DT?

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
