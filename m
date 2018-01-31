From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 31 Jan 2018 19:48:00 +0000
Subject: [PATCH v3 4/4] drivers: firmware: xilinx: Add debugfs interface
In-Reply-To: <20180125093057.GA1936@kroah.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-5-git-send-email-jollys@xilinx.com>
 <20180125093057.GA1936@kroah.com>
Message-ID: <DM2PR0201MB076787151BE9EE4EA1F32BD3B8FB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,
Thanks for review comments. All will be taken care in next version patch.

Thanks,
Jolly Shah

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Thursday, January 25, 2018 1:31 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 4/4] drivers: firmware: xilinx: Add debugfs interface
> 
> On Wed, Jan 24, 2018 at 03:21:14PM -0800, Jolly Shah wrote:
> > Firmware-debug provides debugfs interface to all APIs.
> 
> I don't understand this changelog comment, care to make it more
> informational?  At least describe the debugfs files you are adding so that people
> have a chance to understand what is going on here :)
> 
> > diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig
> > b/drivers/firmware/xilinx/zynqmp/Kconfig
> > index 8f7709d..bdd0188 100644
> > --- a/drivers/firmware/xilinx/zynqmp/Kconfig
> > +++ b/drivers/firmware/xilinx/zynqmp/Kconfig
> > @@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
> >  	  Say yes to enable zynqmp firmware interface driver.
> >  	  In doubt, say N
> >
> > +config ZYNQMP_FIRMWARE_DEBUG
> > +	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
> > +	default ARCH_ZYNQMP && ZYNQMP_FIRMWARE && DEBUG_FS
> > +	help
> > +	  Say yes to enable zynqmp firmware interface debug APIs.
> > +	  In doubt, say N
> 
> So your default is going to be Y if the driver is selected?  That's not good, just
> leave the default alone please.
> 
> > +
> >  endmenu
> > diff --git a/drivers/firmware/xilinx/zynqmp/Makefile
> > b/drivers/firmware/xilinx/zynqmp/Makefile
> > index 6629781..02f0c9a 100644
> > --- a/drivers/firmware/xilinx/zynqmp/Makefile
> > +++ b/drivers/firmware/xilinx/zynqmp/Makefile
> > @@ -2,3 +2,4 @@
> >  # Makefile for Xilinx firmwares
> >
> >  obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
> > +obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += firmware-debug.o
> > diff --git a/drivers/firmware/xilinx/zynqmp/firmware-debug.c
> > b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
> > new file mode 100644
> > index 0000000..daefc62
> > --- /dev/null
> > +++ b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
> > @@ -0,0 +1,511 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
> > + *
> > + *  Copyright (C) 2014-2018 Xilinx, Inc.
> > + *
> > + *  Michal Simek <michal.simek@xilinx.com>
> > + *  Davorin Mista <davorin.mista@aggios.com>
> > + *  Jolly Shah <jollys@xilinx.com>
> > + *  Rajan Vaja <rajanv@xilinx.com>
> > + */
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> > +#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
> > +
> > +#define DRIVER_NAME	"zynqmp-firmware"
> 
> You define this in 2 places, but only use it in one, you don't need this at all,
> please remove all instances.
> 
> > +static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32
> > +*pm_api_ret) {
> > +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> > +	u32 pm_api_version;
> > +	int ret;
> > +
> > +	if (!eemi_ops)
> > +		return -ENXIO;
> > +
> > +	switch (pm_id) {
> > +	case PM_GET_API_VERSION:
> > +		eemi_ops->get_api_version(&pm_api_version);
> > +		pr_info("%s PM-API Version = %d.%d\n", __func__,
> > +			pm_api_version >> 16, pm_api_version & 0xffff);
> 
> This is a _very_ noisy function, dumping a lot of stuff to the kernel log.  Why?
> Why not send it back to the caller of the debugfs file reader instead?
> 
> > +	case PM_GET_NODE_STATUS:
> > +		ret = eemi_ops->get_node_status(pm_api_arg[0],
> > +						&pm_api_ret[0],
> > +						&pm_api_ret[1],
> > +						&pm_api_ret[2]);
> > +		if (!ret)
> > +			pr_info("GET_NODE_STATUS:\n\tNodeId:
> %llu\n\tStatus: %u\n\tRequirements: %u\n\tUsage: %u\n",
> > +				pm_api_arg[0], pm_api_ret[0],
> > +				pm_api_ret[1], pm_api_ret[2]);
> 
> Multi-line dmesg messages?  Not good, you just lost the logging level for the
> multiple lines :(
> 
> Again, don't do this at all, just put it in file output instead.  That way tools/users
> can actually use it, instead of having to dig through kernel log messages.
> 
> > +/**
> > + * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
> > + *
> > + * Return:      None
> > + */
> > +void zynqmp_pm_api_debugfs_init(void) {
> > +	struct dentry *root_dir;
> > +	struct dentry *d;
> > +
> > +	/* Initialize debugfs interface */
> > +	root_dir = debugfs_create_dir(DRIVER_NAME, NULL);
> > +	if (!root_dir) {
> > +		pr_warn("debugfs_create_dir failed\n");
> 
> Why warn?  What can a user do about this?  Just return and move on.
> 
> > +		return;
> > +	}
> > +
> > +	d = debugfs_create_file("pm", 0220, root_dir, NULL,
> > +				&fops_zynqmp_pm_dbgfs);
> > +	if (!d) {
> > +		pr_warn("debugfs_create_file power failed\n");
> > +		goto err_dbgfs;
> > +	}
> > +
> > +	d = debugfs_create_file("api_version", 0444, root_dir,
> > +				NULL, &fops_zynqmp_pm_dbgfs);
> > +	if (!d) {
> > +		pr_warn("debugfs_create_file api_version failed\n");
> > +		goto err_dbgfs;
> 
> Same for these files, who cares if they were not created or not at all?
> No need to even check here at all, this whole function can be reduced to just 3
> lines:
> 	debugfs_create_dir(...);
> 	debugfs_create_file(...);
> 	debugfs_create_file(...);
> 
> There, nice and simple.  Remember, debugfs doesn't matter, and it should be
> _really_ easy to use.  Don't make it more complex than it has to be please.
> 
> thanks,
> 
> greg k-h
