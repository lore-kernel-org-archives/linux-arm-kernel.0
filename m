From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Oct 2016 11:22:05 +0100
Subject: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
In-Reply-To: <VI1PR04MB161582C628C5EA4CD08B15C6E8AB0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
 <0416d929-dfef-da09-8d9a-d1db8575afef@arm.com>
 <VI1PR04MB161582C628C5EA4CD08B15C6E8AB0@VI1PR04MB1615.eurprd04.prod.outlook.com>
Message-ID: <20161026102152.GB19965@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 06:55:22AM +0000, M.H. Lian wrote:
> Hi Robin,
> 
> Please see my comments inline.
> 
> Thanks,
> Minghuan
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy at arm.com]
> > Sent: Tuesday, October 25, 2016 9:01 PM
> > To: M.H. Lian <minghuan.lian@nxp.com>; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > devicetree at vger.kernel.org
> > Cc: Marc Zyngier <marc.zyngier@arm.com>; Stuart Yoder
> > <stuart.yoder@nxp.com>; Leo Li <leoyang.li@nxp.com>; Scott Wood
> > <scott.wood@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Mingkai Hu
> > <mingkai.hu@nxp.com>
> > Subject: Re: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG
> > MSI
> > 
> > On 25/10/16 13:35, Minghuan Lian wrote:
> > > 1. The different version of a SoC may have different MSI
> > > implementation. But compatible "fsl,<soc-name>-msi" can not describe
> > > the SoC version.
> > 
> > Can't it?
> > 
> > 	compatible = "fsl-ls1043a-rev11-msi";
> > 
> > Oh, I guess it can!
> > 
> > Joking aside, if there are multiple versions of a piece of hardware which
> > require *different* treatment by drivers, then it is obviously wrong to use
> > the same compatible string because *they are not compatible*.
> > 
> [Minghuan Lian]  Yes, but Rev1.0 and Rev1.1 SoC will use the same dts files.
> We cannot create different dts files for each revision of the same kind of SoC.

... why?

The DT should describe the hardware; if hardware differs then it should
have a different DT.

> It means that there are different variants in the different versions
> of the same SoC that will use the same compatible string.

Why can you not add a string for each variant, in addition to the SoC
string? We do that elsewhere.

> So I have to use SoC match interface to get the versions.
> 
> I'm too radical. I do not want to first check SoC family via
> compatible string and then check revision via SoC match or SVR.

You can have *both* in the the compatible string list, e.g. at the top
level:

	compatible = "vendor,soc-rev", "vendor-soc";

For devices which differ, this can be encoded similarly in the device
compatible string list.

> I selected the "SoC match" like the following to get the related information at only one place. 
> 
> static struct soc_device_attribute soc_msi_matches[] = {
> 	{ .family = "QorIQ LS1021A",
> 	  .data = &ls1021_msi_cfg },
> 	{ .family = "QorIQ LS1012A",
> 	  .data = &ls1021_msi_cfg },
> 	{ .family = "QorIQ LS1043A", .revision = "1.0",
> 	  .data = &ls1021_msi_cfg },
> 	{ .family = "QorIQ LS1043A", .revision = "1.1",
> 	  .data = &ls1043_rev11_msi_cfg },
> 	{ .family = "QorIQ LS1046A",
> 	  .data = &ls1046_msi_cfg },
> 	{ },
> };
> 
> I will remain the SoC related compatible and try to describe the
> difference via some kind of the property.

As commented on the driver side, this should be described with DT
properties on the devices.

Thanks,
Mark.
