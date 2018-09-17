From: navam@xilinx.com (Nava kishore Manne)
Date: Mon, 17 Sep 2018 03:14:14 +0000
Subject: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware
 driver
In-Reply-To: <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
 <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
 <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
Message-ID: <BYAPR02MB471039817A37E2583A90FC21C21E0@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

	Thansks for providing the comments..
Please find my repsonce inline...

> -----Original Message-----
> From: Srinivas Kandagatla [mailto:srinivas.kandagatla at linaro.org]
> Sent: Sunday, September 16, 2018 7:41 PM
> To: Nava kishore Manne <navam@xilinx.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem
> firmware driver
> 
> Few minor Nits...
> 
> I remember asking about this in the last review!
> 
> On 04/09/18 10:52, Nava kishore Manne wrote:
> > This patch adds zynqmp nvmem firmware driver to access the SoC
> > revision information from the hardware register.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > diff --git a/drivers/nvmem/zynqmp_nvmem.c
> > b/drivers/nvmem/zynqmp_nvmem.c new file mode 100644 index
> > 0000000..e377900
> > --- /dev/null
> > +++ b/drivers/nvmem/zynqmp_nvmem.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 Xilinx, Inc.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +#define SILICON_REVISION_MASK 0xF
> > +
> > +static int zynqmp_nvmem_read(void *context, unsigned int offset,
> > +			     void *val, size_t bytes)
> > +{
> > +	int ret;
> > +	int idcode, version;
> > +	const struct zynqmp_eemi_ops *eemi_ops =
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (!eemi_ops || !eemi_ops->get_chipid)
> > +		return -ENXIO;
> > +
> > +	ret = eemi_ops->get_chipid(&idcode, &version);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pr_debug("Read chipid val %x %x\n", idcode, version);
> > +	*(int *)val = version & SILICON_REVISION_MASK;
> 
> Use dev_dbg here.

Will fix in the next version..

> > +
> > +	return 0;
> > +}
> > +
> > +static struct nvmem_config econfig = {
> > +	.name = "zynqmp-nvmem",
> > +	.owner = THIS_MODULE,
> > +	.word_size = 1,
> > +	.size = 1,
> > +	.read_only = true,
> > +};
> > +
> > +static const struct of_device_id zynqmp_nvmem_match[] = {
> > +	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
> > +
> > +static int zynqmp_nvmem_probe(struct platform_device *pdev) {
> > +	struct nvmem_device *nvmem;
> > +
> > +	econfig.dev = &pdev->dev;
> > +	econfig.reg_read = zynqmp_nvmem_read;
> > +
> > +	nvmem = nvmem_register(&econfig);
> You can use devm_ variant and remove the zynqmp_nvmem_remove() totally
> 
Will fix in the next version...

Regards,
Navakishore.
