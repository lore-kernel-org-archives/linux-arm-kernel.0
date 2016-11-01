From: youlin.pei@mediatek.com (Youlin Pei)
Date: Tue, 1 Nov 2016 20:12:53 +0800
Subject: [SPAM][PATCH 2/3] irqchip: mtk-cirq: Add mediatek mtk-cirq
 implement
In-Reply-To: <1477580545.5951.3.camel@mtksdaap41>
References: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
 <1476335194-26604-3-git-send-email-youlin.pei@mediatek.com>
 <1477580545.5951.3.camel@mtksdaap41>
Message-ID: <1478002373.8890.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-10-27 at 23:02 +0800, Yingjoe Chen wrote:
> On Thu, 2016-10-13 at 13:06 +0800, Youlin Pei wrote:
> > This commit add the mtk-cirq implement for mt2701.
> > 
> > Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
> > ---
> >  drivers/irqchip/Makefile       |    2 +-
> >  drivers/irqchip/irq-mtk-cirq.c |  257 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 258 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/irqchip/irq-mtk-cirq.c
> > 
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 4c203b6..eee95c6 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -59,7 +59,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
> >  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
> >  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
> >  obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
> > -obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
> > +obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
> >  obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
> >  obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
> >  obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
> > diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
> > new file mode 100644
> > index 0000000..544767d
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-mtk-cirq.c
> > @@ -0,0 +1,257 @@
> > +/*
> > + * Copyright (c) 2016 MediaTek Inc.
> > + * Author: Youlin.Pei <youlin.pei@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/syscore_ops.h>
> > +
> > +#define CIRQ_MASK_SET	0xC0
> > +#define CIRQ_MASK_CLR	0x100
> > +#define CIRQ_SENS_SET	0x180
> > +#define CIRQ_SENS_CLR	0x1C0
> 
> nit: please use lower case for hex value

fixed in V2, please review in v2.

> 
> > +#define CIRQ_POL_SET	0x240
> > +#define CIRQ_POL_CLR	0x280
> > +#define CIRQ_CONTROL	0x300
> > +
> > +#define CIRQ_EN		0x1
> 
> nit: please align

fixed in v2. please review in v2.

> 
> > +#define CIRQ_EDGE	0x2
> > +#define CIRQ_FLUSH	0x4
> > +
> > +#define CIRQ_IRQ_NUM    0x200
> > +
> > +struct mtk_cirq_chip_data {
> > +	void __iomem *base;
> > +	unsigned int ext_irq_start;
> > +};
> > +
> 
> <deleted..>
> 
> > +
> > +static int __init mtk_cirq_of_init(struct device_node *node,
> > +				   struct device_node *parent)
> > +{
> > +	struct irq_domain *domain, *domain_parent;
> > +	int ret;
> > +
> > +	domain_parent = irq_find_host(parent);
> > +	if (!domain_parent) {
> > +		pr_err("mtk_cirq: interrupt-parent not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	cirq_data = kzalloc(sizeof(*cirq_data), GFP_KERNEL);
> > +	if (!cirq_data)
> > +		return -ENOMEM;
> > +
> > +	cirq_data->base = of_iomap(node, 0);
> > +	if (!cirq_data->base) {
> > +		pr_err("mtk_cirq: unable to map cirq register\n");
> > +		ret = -ENXIO;
> > +		goto out_free;
> > +	}
> > +
> > +	if (of_property_read_u32(node, "mediatek,ext-irq-start",
> > +				 &cirq_data->ext_irq_start)) {
> > +		ret = -EINVAL;
> > +		goto out_free;
> 
> Please propagate error returned from of_property_read_u32
> Should goto out_unmap when fail here.

fixed in v2, thanks!
> 
> Joe.C
> 
> > +	}
> > +
> > +	domain = irq_domain_add_hierarchy(domain_parent, 0, CIRQ_IRQ_NUM, node,
> > +					  &cirq_domain_ops, cirq_data);
> > +	if (!domain) {
> > +		ret = -ENOMEM;
> > +		goto out_unmap;
> > +	}
> > +
> > +	mtk_cirq_syscore_init();
> > +
> > +	return 0;
> > +
> > +out_unmap:
> > +	iounmap(cirq_data->base);
> > +out_free:
> > +	kfree(cirq_data);
> > +	return ret;
> > +}
> > +
> > +IRQCHIP_DECLARE(mtk_cirq, "mediatek,mt2701-cirq", mtk_cirq_of_init);
> 
> 
