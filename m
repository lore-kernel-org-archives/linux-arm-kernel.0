From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 15:58:13 -0700
Subject: [PATCH v5 07/11] nvmem: Add simple nvmem-mmio consumer helper
 functions.
In-Reply-To: <1432226665-8994-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226665-8994-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5580AA05.90709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2015 09:44 AM, Srinivas Kandagatla wrote:
> diff --git a/drivers/nvmem/nvmem-mmio.c b/drivers/nvmem/nvmem-mmio.c
> new file mode 100644
> index 0000000..0d8131f
> --- /dev/null
> +++ b/drivers/nvmem/nvmem-mmio.c
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

#include <linux/platform_device.h>
#include <linux/nvmem_provider.h>
#include <linux/regmap.h>

> +#include "nvmem-mmio.h"
> +
> +int nvmem_mmio_remove(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> +
> +	return nvmem_unregister(nvmem);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_mmio_remove);
> +
> +int nvmem_mmio_probe(struct platform_device *pdev)
> +{
> +
[...]
> +
> +	platform_set_drvdata(pdev, nvmem);

It may be better to return the nvmem device instead so that the one
drvdata member is usable by the calling driver.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_mmio_probe);

Kernel-doc on these exported functions?

> diff --git a/drivers/nvmem/nvmem-mmio.h b/drivers/nvmem/nvmem-mmio.h
> new file mode 100644
> index 0000000..a2ad4e5
> --- /dev/null
> +++ b/drivers/nvmem/nvmem-mmio.h
> @@ -0,0 +1,41 @@
> +/*
> + * MMIO based nvmem providers.
> + *
> + * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef _LINUX_NVMEM_MMIO_H
> +#define _LINUX_NVMEM_MMIO_H
> +
> +#include <linux/platform_device.h>

Forward declare struct platform_device instead.

> +#include <linux/nvmem-provider.h>

Forward declare nvmem_config instead.

> +#include <linux/regmap.h>

Forward declare regmap_config instead.

> +
> +struct nvmem_mmio_data {
> +	struct regmap_config *regmap_config;
> +	struct nvmem_config *nvmem_config;
> +};
> +
> +#if IS_ENABLED(CONFIG_NVMEM)
> +
> +int nvmem_mmio_probe(struct platform_device *pdev);
> +int nvmem_mmio_remove(struct platform_device *pdev);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
