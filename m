From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 1 Feb 2018 01:23:48 +0000
Subject: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
Message-ID: <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for the review,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Wednesday, January 31, 2018 10:20 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> driver
> 
> On Wed, Jan 24, 2018 at 03:21:12PM -0800, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> 
> > +/**
> > + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
> > + *					while suspended
> > + * @target:	Node ID of the targeted PU or subsystem
> > + * @wakeup_node:Node ID of the wakeup peripheral
> > + * @enable:	Enable or disable the specified peripheral as wake source
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_set_wakeup_source(const u32 target,
> > +				       const u32 wakeup_node,
> > +				       const u32 enable)
> > +{
> > +	return invoke_pm_fn(PM_SET_WAKEUP_SOURCE, target,
> > +			    wakeup_node, enable, 0, NULL); }
> 
> I see many functions take a "Node ID" parameter, but these don't appear to be
> in any DT binding, and drivers (other than the debugfs driver) aren't using them.
> 
> What's the plan for making use of these? Where are the node IDs going to come
> from in practice?
> 
Node ids are defined in firmware.h. Node id refers to targeted PU/subsystem/peripheral for required action.

> > +/**
> > + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or
> restart
> > + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> > + * @subtype:	Specifies which system should be restarted or shut down
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_system_shutdown(const u32 type, const u32
> > +subtype) {
> > +	return invoke_pm_fn(PM_SYSTEM_SHUTDOWN, type, subtype, 0, 0,
> NULL);
> > +}
> 
> PSCI already has this functionality, so I'm a little confused by the duplication.
> 
PSCI doesn't distinguish between shutdown scope. It can be APU/PS/System in this case.

> [...]
> 
> > +/**
> > + * zynqmp_pm_get_node_status - PM call to request a node's current power
> state
> > + * @node:		ID of the component or sub-system in question
> > + * @status:		Current operating state of the requested node
> > + * @requirements:	Current requirements asserted on the node,
> > + *			used for slave nodes only.
> > + * @usage:		Usage information, used for slave nodes only:
> > + *			0 - No master is currently using the node
> > + *			1 - Only requesting master is currently using the node
> > + *			2 - Only other masters are currently using the node
> > + *			3 - Both the current and at least one other master
> > + *			is currently using the node
> 
> These should probably have corresponding macros or enum values.
Will add macros in next version patch.

> 
> [...]
> 
> > +/**
> > + * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
> > + * @address:	Address of the data/ Address of output buffer where
> > + *		hash should be stored.
> > + * @size:	Size of the data.
> > + * @flags:
> > + *	BIT(0) - Sha3 init (Here address and size inputs can be NULL)
> > + *	BIT(1) - Sha3 update (address should holds the )
> 
> Missing "data", I guess?
Yes will update in next version patch.

> 
> > + *	BIT(2) - Sha3 final (address should hold the address of
> > + *		 buffer to store hash)
> 
> Is the SHA engine coherent? Or is cache maintenance necessary?
> 
> [...]
It is coherent. Update/Final has below significance here:
BIT(1) - To call Sha3_Update API which can be called multiple times when data is not contiguous.
BIT(2) - to get final hash of the whole updated data. Hash will be overwritten at provided address with 48 bytes.

> 
> > +/**
> > + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> > + * @pin:	Pin number to request
> > + *
> 
> No DT binding for the pinctrl bits?
> 
> [...]
It doesn't require any bindings. Calling drivers will have DT binding for pins they use. 


> 
> > +/**
> > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > + * @clock_id:	ID of the clock to be enabled
> > + *
> 
> Likewise for the clocks?
>
It doesn't require bindings too. 
 
> > +/**
> > + * get_eemi_ops	- Get eemi ops functions
> > + *
> > + * Return:	- pointer of eemi_ops structure
> > + */
> > +const struct zynqmp_eemi_ops *get_eemi_ops(void) {
> > +	return &eemi_ops;
> > +}
> > +EXPORT_SYMBOL_GPL(get_eemi_ops);
> > +
> > +static int __init zynqmp_plat_init(void) {
> > +	struct device_node *np;
> > +	int ret = 0;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> > +	if (!np)
> > +		return 0;
> > +	of_node_put(np);
> > +
> > +	/* We're running on a ZynqMP machine, the PM node is mandatory. */
> > +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
> > +	if (!np) {
> > +		pr_warn("%s: pm node not found\n", __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	ret = get_set_conduit_method(np);
> > +	if (ret) {
> > +		of_node_put(np);
> > +		return ret;
> > +	}
> > +
> > +	/* Check PM API version number */
> > +	zynqmp_pm_get_api_version(&pm_api_version);
> > +	if (pm_api_version != ZYNQMP_PM_VERSION) {
> > +		panic("%s power management API version error. Expected:
> v%d.%d - Found: v%d.%d\n",
> > +		      __func__,
> > +		      ZYNQMP_PM_VERSION_MAJOR,
> ZYNQMP_PM_VERSION_MINOR,
> > +		      pm_api_version >> 16, pm_api_version & 0xffff);
> > +	}
> > +
> > +	pr_info("%s Power management API v%d.%d\n", __func__,
> > +		ZYNQMP_PM_VERSION_MAJOR,
> ZYNQMP_PM_VERSION_MINOR);
> > +
> > +	of_node_put(np);
> > +
> > +	return ret;
> > +}
> > +
> > +early_initcall(zynqmp_plat_init);
> 
> Why does this need to be an early initcall? Can't we probe this as a platform
> device?
> 
> Thanks,
> Mark.
