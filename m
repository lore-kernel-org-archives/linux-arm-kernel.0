From: RAJANV@xilinx.com (Rajan Vaja)
Date: Mon, 29 Oct 2018 14:27:18 +0000
Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
 domain driver
In-Reply-To: <20181012145251.GA6489@bogus>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
 <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
 <20181012145251.GA6489@bogus>
Message-ID: <BYAPR02MB40556D3EDE9892943073662DB7F30@BYAPR02MB4055.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 12 October 2018 08:23 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> geert+renesas at glider.be; bjorn.andersson at linaro.org; sean.wang at mediatek.com;
> m.szyprowski at samsung.com; Michal Simek <michals@xilinx.com>;
> mark.rutland at arm.com; devicetree at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
> domain driver
> 
> On Wed, Oct 10, 2018 at 06:41:44PM +0000, Jolly Shah wrote:
> > Ping for comments
> 
> Please see my comments on other ZynqMP firmware patches. In summary, I
> need to see a complete binding, not piecemeal additions.
[Rajan] Based on your suggestion to have complete zynqmp firmware binding, we can
have two options:

1. Use firmware node instead of having separate subnodes for dependent
drivers(genpd, reset, nvmem, etc). In this case, firmware driver
needs to take care of probing of depedent drivers. We have thought of
MFD approach to probe depedent drivers. Firmware driver would register
depedent drivers as MFD child devices from firmware probe. 

	firmware {
		zynqmp_firmware: zynqmp-firmware {
			compatible = "xlnx,zynqmp-firmware";
			method = "smc";
			#power-domain-cells = <1>;
		};
	};

	sata {
		...
		power-domains = <&zynqmp_firmware 2>;
		...
	};

drivers/firmware/xilinx/zynqmp.c: zynqmp_firmware_probe(struct platform_device *pdev)
	static const struct mfd_cell firmware_devs[] = {
		{
			.name = "zynqmp_power_controller",
		},
	};

	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
				ARRAY_SIZE(firmware_devs), NULL, 0, NULL);

2. Keep separate node for each device outside (in parralel to) zynqmp-firmware node.
In this case, each firmware driver consumer is independet driver/binding.
Order of probe can be taken care by -EPROBE defer mechanism.

Example:
	firmware {
		zynqmp_firmware: zynqmp-firmware {
			compatible = "xlnx,zynqmp-firmware";
			method = "smc";
		};
	};
		
	zynqmp_power_domains: zynqmp-power-domains {
		...
		compatible = "xlnx,zynqmp-genpd";
		#power-domain-cells = <1>;
		...
	};

	sata {
		...
		power-domains = <&zynqmp_power_domains 2>;
		...
	};

Please let us know your inputs and suggest better approach so we can submit
changes accordingly.

Thanks,
Rajan
> 
> Rob
> 
> >
> > Thanks,
> > Jolly Shah
> >
> > > -----Original Message-----
> > > From: Jolly Shah [mailto:jolly.shah at xilinx.com]
> > > Sent: Thursday, October 04, 2018 2:24 PM
> > > To: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> > > geert+renesas at glider.be; bjorn.andersson at linaro.org;
> > > sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> > > <michals@xilinx.com>; robh+dt at kernel.org; mark.rutland at arm.com
> > > Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> > > <JOLLYS@xilinx.com>
> > > Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
> > > domain driver
> > >
> > > The zynqmp power domain driver communicates the usage requirements for
> > > logical power domains / devices to the platform FW.
> > > FW is responsible for choosing appropriate power states, taking Linux' usage
> > > information into account.
> > >
> > > This patch series is based on top of Xilinx firmware patch set:
> > > https://patchwork.kernel.org/cover/10555405/
> > >
> > > v3:
> > >  - Changed binding to have FW node as a power controller as suggested by Rob
> > >  - Updated FW driver to register it as mfd child devices from firmware probe
> > >  - Move bindings location as suggested
> > >
> > > v2:
> > >  - Rebased on top of latest firmware driver patch series
> > >  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
> > >  - Updated device tree bindings to move power controller node under firmware
> > > node
> > >
> > > Jolly Shah (1):
> > >   drivers: soc: xilinx: Add ZynqMP power domain driver
> > >
> > > Rajan Vaja (3):
> > >   dt-bindings: power: Add ZynqMP power domain bindings
> > >   firmware: xilinx: Add APIs to control node status/power
> > >   firmware: xilinx: Add node IDs for zynqmp firmware
> > >
> > >  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
> > >  drivers/firmware/xilinx/Kconfig                    |   1 +
> > >  drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
> > >  drivers/soc/xilinx/Kconfig                         |   9 +
> > >  drivers/soc/xilinx/Makefile                        |   2 +
> > >  drivers/soc/xilinx/zynqmp_pm_domains.c             | 403
> > > +++++++++++++++++++++
> > >  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
> > >  include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
> > >  8 files changed, 659 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-
> > > genpd.txt
> > >  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
> > >  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> > >
> > > --
> > > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
