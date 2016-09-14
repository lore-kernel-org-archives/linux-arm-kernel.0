From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 14:33:21 +0200
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1473855354-150093-3-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <5140357.dcW9ibtZJ6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 8:15:52 PM CEST Zhichang Yuan wrote:

> +Required properties:
> +- compatible: should be "hisilicon,low-pin-count"
> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
> +- reg: base address and length of the register set for the device.
> +- ranges: define a 1:1 mapping between the I/O space of the child device and
> +	  the parent.

Do we still need the "ranges" here? The property in your example seems
wrong.

> +	ranges = <0x01 0xe4 0x0 0xe4 0x1000>;

You translate I/O port 0x00e4 through 0x10e4 to CPU address 0x0e4?

> +/**
> + * hisilpc_children_map_sysio - setup the mapping between system Io and
> + *			physical IO
> + *
> + * @child: the device whose IO is handling
> + * @data: some device specific data. For ACPI device, should be NULL.
> + *
> + * Returns >=0 means the mapping is successfully created;
> + * others mean some failures.
> + */
> +static int hisilpc_children_map_sysio(struct device * child, void * data)
> +{
> +	struct resource *iores;
> +	unsigned long cpuio;
> +	struct extio_ops *opsnode;
> +	int ret;
> +	struct hisilpc_dev *lpcdev;
> +
> +	if (!child || !child->parent)
> +		return -EINVAL;
> +
> +	iores = platform_get_resource_byname(to_platform_device(child),
> +					IORESOURCE_IO, "dev_io");
> +	if (!iores)
> +		return -ENODEV;
> +
> +	/*
> +	 * can not use devm_kzalloc to allocate slab for child before its driver
> +	 * start probing. Here allocate the slab with the name of parent.
> +	 */
> +	opsnode = devm_kzalloc(child->parent, sizeof(*opsnode), GFP_KERNEL);
> +	if (!opsnode)
> +		return -ENOMEM;
> +
> +	cpuio = data ? *((unsigned long *)data) : 0;
> +
> +	opsnode->start = iores->start;
> +	opsnode->end = iores->end;
> +	opsnode->ptoffset = cpuio ? (cpuio - iores->start) : 0;
> +
> +	dev_info(child, "map sys port[%lx - %lx] offset=0x%lx",
> +				(unsigned long)iores->start,
> +				(unsigned long)iores->end,
> +				opsnode->ptoffset);
> +
> +	opsnode->pfin = hisilpc_comm_inb;
> +	opsnode->pfout = hisilpc_comm_outb;
> +
> +	lpcdev = platform_get_drvdata(to_platform_device(child->parent));
> +	opsnode->devpara = lpcdev;
> +
> +	/* only apply indirect-IO to ipmi child device */

I don't get this part. The bus driver should not care what its
children are, just register and PIO ranges that the bus can handle
in theory, i.e. from 0x000 to 0xfff.

	Arnd
