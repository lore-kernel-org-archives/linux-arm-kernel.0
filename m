From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 16 Sep 2018 15:10:37 +0100
Subject: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware
 driver
In-Reply-To: <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
 <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
Message-ID: <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few minor Nits...

I remember asking about this in the last review!

On 04/09/18 10:52, Nava kishore Manne wrote:
> This patch adds zynqmp nvmem firmware driver to access the
> SoC revision information from the hardware register.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> new file mode 100644
> index 0000000..e377900
> --- /dev/null
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +#define SILICON_REVISION_MASK 0xF
> +
> +static int zynqmp_nvmem_read(void *context, unsigned int offset,
> +			     void *val, size_t bytes)
> +{
> +	int ret;
> +	int idcode, version;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_chipid)
> +		return -ENXIO;
> +
> +	ret = eemi_ops->get_chipid(&idcode, &version);
> +	if (ret < 0)
> +		return ret;
> +
> +	pr_debug("Read chipid val %x %x\n", idcode, version);
> +	*(int *)val = version & SILICON_REVISION_MASK;

Use dev_dbg here.
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config econfig = {
> +	.name = "zynqmp-nvmem",
> +	.owner = THIS_MODULE,
> +	.word_size = 1,
> +	.size = 1,
> +	.read_only = true,
> +};
> +
> +static const struct of_device_id zynqmp_nvmem_match[] = {
> +	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
> +
> +static int zynqmp_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem;
> +
> +	econfig.dev = &pdev->dev;
> +	econfig.reg_read = zynqmp_nvmem_read;
> +
> +	nvmem = nvmem_register(&econfig);
You can use devm_ variant and remove the zynqmp_nvmem_remove() totally

> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
> +	platform_set_drvdata(pdev, nvmem);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_nvmem_remove(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> +
> +	return nvmem_unregister(nvmem);
> +}
> +
