From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 May 2014 10:32:45 -0500
Subject: [RFC] [v2 Patch 1/6] drivers: reset: TI: SoC reset controller
 support.
In-Reply-To: <5368E01C.9000709@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
 <1399320567-3639-2-git-send-email-dmurphy@ti.com>
 <20140505213306.GA3732@saruman.home> <5368E01C.9000709@ti.com>
Message-ID: <20140506153245.GE25849@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[ I had to manually rewrap your email which came with long lines, please
have a read on Documentation/email-clients.txt ]

On Tue, May 06, 2014 at 08:14:04AM -0500, Dan Murphy wrote:
> >> The TI SoC reset controller support utilizes the
> >> reset controller framework to give device drivers or
> >> function drivers a common set of APIs to call to reset
> >> a module.
> >>
> >> The reset-ti is a common interface to the reset framework.
> >>  The register data is retrieved during initialization
> >>  of the reset driver through the reset-ti-data
> >> file.  The array of data is associated with the compatible from the
> >> respective DT entry.
> >>
> >> Once the data is available then this is derefenced within the common
> >> interface.
> >>
> >> The device driver has the ability to assert, deassert or perform a
> >> complete reset.
> >>
> >> This code was derived from previous work by Rajendra Nayak and Afzal Mohammed.
> >> The code was changed to adopt to the reset core and abstract away the SoC information.
> > you should break your commit log at around 72 characters at most.
> 
> Do you mean 72 characters per line?

<sartalics> no, that's too much. The entire commit log </sartalics>

Yes, per-line :-)

> >> diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
> >> new file mode 100644
> >> index 0000000..4d2a6d5
> >> --- /dev/null
> >> +++ b/drivers/reset/ti/reset-ti-data.h
> >> @@ -0,0 +1,56 @@
> >> +/*
> >> + * PRCM reset driver for TI SoC's
> >> + *
> >> + * Copyright 2014 Texas Instruments Inc.
> > this is not the TI aproved way for copyright notices. Yeah,
> > nit-picking...
> 
> Hmm.  Will need to look at other TI files to correct then.

/**
 * file.c - Short Description
 *
 * Copyright (C) 2010-2011 Texas Instruments Incorporated -  http://www.ti.com
 *
 * Author: Dan Murphy <dmurphy@ti.com>
 *
 * GPL text goes here
 */

> >> + * Author: Dan Murphy <dmurphy@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +#ifndef _RESET_TI_DATA_H_
> >> +#define _RESET_TI_DATA_H_
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/reset-controller.h>
> >> +
> >> +/**
> >> + * struct ti_reset_reg_data - Structure of the reset register information
> >> + *		for a particular SoC.
> >> + * @rstctrl_offs: This is the reset control offset value from
> >> + *		from the parent reset node.
> >> + * @rstst_offs: This is the reset status offset value from
> >> + *		from the parent reset node.
> >> + * @rstctrl_bit: This is the reset control bit for the module.
> >> + * @rstst_bit: This is the reset status bit for the module.
> >> + *
> >> + * This structure describes the reset register control and status offsets.
> >> + * The bits are also defined for the same.
> >> + */
> >> +struct ti_reset_reg_data {
> >> +	void __iomem *reg_base;
> >> +	u32	rstctrl_offs;
> >> +	u32	rstst_offs;
> >> +	u32	rstctrl_bit;
> >> +	u32	rstst_bit;
> > this structure can be folded into struct ti_reset_data and all of that
> > can be initialized during probe.
> 
> I could do that.  It will simplify the de-referencing as well.

yeah, and it will prevent constant alloc/free of this structure

> >> diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
> >> new file mode 100644
> >> index 0000000..349f4fb
> >> --- /dev/null
> >> +++ b/drivers/reset/ti/reset-ti.c
> >> @@ -0,0 +1,267 @@
> >> +/*
> >> + * PRCM reset driver for TI SoC's
> >> + *
> >> + * Copyright 2014 Texas Instruments Inc.
> >> + *
> >> + * Author: Dan Murphy <dmurphy@ti.com>
> > fix copyright notice here too
> >
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/err.h>
> >> +#include <linux/io.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "reset-ti-data.h"
> >> +
> >> +#define DRIVER_NAME "prcm_reset_ti"
> >> +
> >> +static struct ti_reset_data *ti_data;
> > NAK, you *really* don't need and don't to have this global here. It only

don't _want_ to have, missed the verb

> >> +		return ret;
> >> +	}
> >> +
> >> +	/* node parent */
> >> +	parent = of_get_parent(dev_node);
> >> +	if (!parent) {
> >> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> >> +		return ret;
> >> +	}
> >> +	/* prcm reset parent */
> >> +	reset_parent = of_get_next_parent(parent);
> >> +	if (!reset_parent) {
> >> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> >> +		return ret;
> >> +	}
> >> +	/* PRCM Parent */
> >> +	reset_parent = of_get_parent(reset_parent);
> >> +	if (!prcm_parent) {
> >> +		pr_err("%s: Cannot find parent reset node\n", __func__);
> >> +		return ret;
> >> +	}
> >> +
> >> +	reset_data->reg_base = of_iomap(reset_parent, 0);
> > please don't. of_iomap() is the stupidest helper in the kernel. Find
> > your resource using platform_get_resource() and map it with
> > devm_ioremap_resource() since that will properly request_mem_region()
> > and correctly map the resource with or without caching.
> 
> Thanks for the information.  The reason this is here so that if there are multiple PRCM
> modules I can just get the base address for the phandle of interest.

yeah, you can also:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	[...]
	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	[...]

or even:

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "my_resource");
	[...]
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "my_other_resource");
	[...]

> >> +	struct ti_reset_reg_data *temp_reg_data;
> >> +	void __iomem *status_reg;
> >> +	u32 bit_mask = 0;
> >> +	u32 val = 0;
> >> +
> >> +	temp_reg_data = kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
> > let's think about this for a second:
> >
> > user asks for a reset, then ->assert() method gets called, which will
> > allocate memory, do some crap, free the allocated memory, then you call
> > your ->deassert() method which will, allocate memory, do something, free
> > memory, then this method is called which will allocate memory, do
> > something, free memory.
> >
> > Note that *all* of your allocations a) are unnecessary and b) will break
> > resets from inside IRQ context...
> 
> This made also think that this is not thread safe as this reset calls
> can be called from multiple callers so I think a semaphore is order
> for this function plus the other calls.

right

> >> +	ti_reset_get_of_data(temp_reg_data, id);
> > this means that *every time* a reset is asserted/deasserted/waited on,
> > you will parse *ONE MORE TIME* the DTB. Why ? Why don't you parse it
> > once during probe() and cache the results ?
> 
> Cache it into what, a list?

into your struct ti_reset_data:

	of_get_property_u32(foo, "bar", &ti_data->bar);

following accesses you just need to read ti_data->bar.

> I had implemented a list before and received comments do not use a
> list.  Because you have to iterate through the list every time.  And a
> list would need to contain some sort of indexing agent which defeats
> the purpose of a phandle.  Then the DTB and kernel images would have
> to be in sync for the indexes.
> 
> If I put it into an array I run into issues with a bounded array and
> need to introduce the index anyway.  So passing the phandle is futile
> which means I have to introduce the indexing from the V1 series again.
> 
> For my information why is parsing the DTB worse then iterating through
> a list?  Is there a possibility that the DTB will be over written?

what are you talking about ?? Look at what how you're parsing your DTB:

+       ret = of_property_read_u32_index(parent, "reg", 0,
+                                        &reset_data->rstctrl_offs);
+       if (ret)
+               return ret;
+
+       ret = of_property_read_u32_index(parent, "reg", 1,
+                                        &reset_data->rstst_offs);
+       if (ret)
+               return ret;
+
+       ret = of_property_read_u32(dev_node, "control-bit",
+                                  &reset_data->rstctrl_bit);
+       if (ret < 0)
+               pr_err("%s: No entry in %s for rstst_offs\n", __func__,
+                          dev_node->name);
+
+       ret = of_property_read_u32(dev_node, "status-bit",
+                                  &reset_data->rstst_bit);
+       if (ret < 0)
+               pr_err("%s: No entry in %s for rstst_offs\n", __func__,
+                          dev_node->name);

why can't you do that from probe and cache the results inside struct
ti_reset_data ? IOW:

	probe()
	{
		[ ... ]

		ret = of_property_read_u32_index(parent, "reg", 0,
				&ti_data->rstctrl_offs);
		[ ... ]

		ret = of_property_read_u32_index(parent, "reg", 1,
				&ti_data->rstst_offs);
		[ ... ]

		ret = of_property_read_u32(dev_node, "control-bit",
				&ti_data->rstctrl_bit);
		[ ... ]

		ret = of_property_read_u32(dev_node, "status-bit",
				&ti_data->rstst_bit);
		[ ... ]

		return 0;
	}

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/1915acc1/attachment.sig>
