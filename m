From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 7 Mar 2018 00:44:45 +0000
Subject: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
 <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
Message-ID: <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Thanks for the review,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, March 01, 2018 6:28 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; michal.simek at xilinx.com
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; robh+dt at kernel.org; mark.rutland at arm.com;
> Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> driver
> 
> 
> 
> On 20/02/18 19:21, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  arch/arm64/Kconfig.platforms                    |    1 +
> >  drivers/firmware/Kconfig                        |    1 +
> >  drivers/firmware/Makefile                       |    1 +
> >  drivers/firmware/xilinx/Kconfig                 |    4 +
> >  drivers/firmware/xilinx/Makefile                |    4 +
> >  drivers/firmware/xilinx/zynqmp/Kconfig          |   16 +
> >  drivers/firmware/xilinx/zynqmp/Makefile         |    4 +
> >  drivers/firmware/xilinx/zynqmp/firmware.c       | 1051
> +++++++++++++++++++++++
> >  include/linux/firmware/xilinx/zynqmp/firmware.h |  590 +++++++++++++
> >  9 files changed, 1672 insertions(+)
> >  create mode 100644 drivers/firmware/xilinx/Kconfig  create mode
> > 100644 drivers/firmware/xilinx/Makefile  create mode 100644
> > drivers/firmware/xilinx/zynqmp/Kconfig
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
> >  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
> >  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> >
> > +
> > +/**
> > + * zynqmp_pm_force_powerdown - PM call to request for another PU or
> subsystem to
> > + *				be powered down forcefully
> > + * @target:	Node ID of the targeted PU or subsystem
> > + * @ack:	Flag to specify whether acknowledge is requested
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_force_powerdown(const u32 target,
> > +				     const enum zynqmp_pm_request_ack ack) {
> > +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack,
> 0, 0,
> > +NULL); }
> > +
> 
> [...]
> 
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
> > +	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
> > +				   0, 0, NULL);
> > +}
> > +
> 
> I can't understand why you need above 2 APIs: PM_FORCE_POWERDOWN and
> PM_SYSTEM_SHUTDOWN. You should use PSCI_SYSTEM_OFF and
> PSCI_SYSTEM_RESET and drop these two.
> 

FORCE_POWERDOWN allows remote master to force power off other node/domain.
SYSTEM_SHUTDOWN provides interface to shutdown/restart the subsystem. It supports system/subsystem restart with argument value. PSCI doesn?t support argument to identify between restart types.

> 
> > +static const struct zynqmp_eemi_ops eemi_ops = {
> > +	.get_api_version = zynqmp_pm_get_api_version,
> > +	.get_chipid = zynqmp_pm_get_chipid,
> > +	.reset_assert = zynqmp_pm_reset_assert,
> > +	.reset_get_status = zynqmp_pm_reset_get_status,
> > +	.fpga_load = zynqmp_pm_fpga_load,
> > +	.fpga_get_status = zynqmp_pm_fpga_get_status,
> > +	.sha_hash = zynqmp_pm_sha_hash,
> > +	.rsa = zynqmp_pm_rsa,
> > +	.request_suspend = zynqmp_pm_request_suspend,
> > +	.force_powerdown = zynqmp_pm_force_powerdown,
> > +	.request_wakeup = zynqmp_pm_request_wakeup,
> > +	.set_wakeup_source = zynqmp_pm_set_wakeup_source,
> > +	.system_shutdown = zynqmp_pm_system_shutdown,
> > +	.request_node = zynqmp_pm_request_node,
> > +	.release_node = zynqmp_pm_release_node,
> > +	.set_requirement = zynqmp_pm_set_requirement,
> > +	.set_max_latency = zynqmp_pm_set_max_latency,
> > +	.set_configuration = zynqmp_pm_set_configuration,
> > +	.get_node_status = zynqmp_pm_get_node_status,
> > +	.get_operating_characteristic =
> zynqmp_pm_get_operating_characteristic,
> > +	.init_finalize = zynqmp_pm_init_finalize,
> > +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
> > +	.ioctl = zynqmp_pm_ioctl,
> > +	.query_data = zynqmp_pm_query_data,
> > +	.pinctrl_request = zynqmp_pm_pinctrl_request,
> > +	.pinctrl_release = zynqmp_pm_pinctrl_release,
> > +	.pinctrl_get_function = zynqmp_pm_pinctrl_get_function,
> > +	.pinctrl_set_function = zynqmp_pm_pinctrl_set_function,
> > +	.pinctrl_get_config = zynqmp_pm_pinctrl_get_config,
> > +	.pinctrl_set_config = zynqmp_pm_pinctrl_set_config,
> > +	.clock_enable = zynqmp_pm_clock_enable,
> > +	.clock_disable = zynqmp_pm_clock_disable,
> > +	.clock_getstate = zynqmp_pm_clock_getstate,
> > +	.clock_setdivider = zynqmp_pm_clock_setdivider,
> > +	.clock_getdivider = zynqmp_pm_clock_getdivider,
> > +	.clock_setrate = zynqmp_pm_clock_setrate,
> > +	.clock_getrate = zynqmp_pm_clock_getrate,
> > +	.clock_setparent = zynqmp_pm_clock_setparent,
> > +	.clock_getparent = zynqmp_pm_clock_getparent, };
> > +
> Instead of introducing all these in oneshot, add them as you have users of it.
> IOW, show the users of these functions in the series. Also I asked to split this
> into functional changes like clock, pinctrl, power, etc.

It can be split into functional changes in same series but it will be difficult to split between users as there are more than 10 driver users for different EEMI APIs and also multiple driver users using specifc EEMI APIs. They all can't be submitted as single series. 

> 
> --
> Regards,
> Sudeep
