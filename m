From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Feb 2018 10:33:21 +0000
Subject: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
 <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
Message-ID: <20180201103321.fftn37mgzbk6oltl@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 01:23:48AM +0000, Jolly Shah wrote:
> Hi Mark,
> Thanks for the review,
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: Wednesday, January 31, 2018 10:20 AM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> > gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> > sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> > dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> > linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>
> > Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> > driver
> > 
> > On Wed, Jan 24, 2018 at 03:21:12PM -0800, Jolly Shah wrote:
> > > This patch is adding communication layer with firmware.
> > > Firmware driver provides an interface to firmware APIs.
> > > Interface APIs can be used by any driver to communicate to
> > > PMUFW(Platform Management Unit). All requests go through ATF.
> > 
> > > +/**
> > > + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
> > > + *					while suspended
> > > + * @target:	Node ID of the targeted PU or subsystem
> > > + * @wakeup_node:Node ID of the wakeup peripheral
> > > + * @enable:	Enable or disable the specified peripheral as wake source
> > > + *
> > > + * Return:	Returns status, either success or error+reason
> > > + */
> > > +static int zynqmp_pm_set_wakeup_source(const u32 target,
> > > +				       const u32 wakeup_node,
> > > +				       const u32 enable)
> > > +{
> > > +	return invoke_pm_fn(PM_SET_WAKEUP_SOURCE, target,
> > > +			    wakeup_node, enable, 0, NULL); }
> > 
> > I see many functions take a "Node ID" parameter, but these don't appear to be
> > in any DT binding, and drivers (other than the debugfs driver) aren't using them.
> > 
> > What's the plan for making use of these? Where are the node IDs going to come
> > from in practice?
> > 
> Node ids are defined in firmware.h. Node id refers to targeted PU/subsystem/peripheral for required action.

Ok. What I was asking was how a node id would be associated with
particular peripheral instances (which are presumably going to be nodes
in the DT).

e.g. if I have

	device at foo {
		compatible = "xlnx,some-device";
		reg = <0xf00 0x100>;
		...
	};

... how does the kernel know which node id(s) the device is associated
with?

I assume that those will need something like a xlnx,eemi-node-id
property.

[...]

> > > +/**
> > > + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> > > + * @pin:	Pin number to request
> > > + *
> > 
> > No DT binding for the pinctrl bits?
> > 
> > [...]
> It doesn't require any bindings. Calling drivers will have DT binding for pins they use. 

For those drivers to be able to refer to the EEMI FW as a pin
controller, we'll need a pinctrl node in the DT (and hence a binding).

> > > +/**
> > > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > > + * @clock_id:	ID of the clock to be enabled
> > > + *
> > 
> > Likewise for the clocks?
> >
> It doesn't require bindings too. 

As with pinctrl, for drivers to be able to refer to these clocks, we'll
need a clock node in the DT (and hence a binding).

Thanks,
Mark.
