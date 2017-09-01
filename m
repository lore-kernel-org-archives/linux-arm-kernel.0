From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Fri, 1 Sep 2017 10:13:40 +0000
Subject: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
In-Reply-To: <AM5PR0401MB2545043022CAE0CDECA6267E9A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1504171424-15536-1-git-send-email-Bharat.Bhushan@nxp.com>
 <06c57ca4-edaa-df26-b1d9-1906141c5065@arm.com>
 <AM5PR0401MB2545B7C55F634D7B9CABAE629A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <10be1849-8071-64fc-5ee2-b6e429c64b9e@arm.com>
 <AM5PR0401MB2545043022CAE0CDECA6267E9A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Message-ID: <AM5PR0401MB2545BB069D90520FFE9CD3499A920@AM5PR0401MB2545.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Bharat Bhushan
> Sent: Thursday, August 31, 2017 4:53 PM
> To: Marc Zyngier <marc.zyngier@arm.com>; robh+dt at kernel.org; Mark
> Rutland <mark.rutland@arm.com>; will.deacon at arm.com;
> oss at buserror.net; Gang Liu <gang.liu@nxp.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; catalin.marinas at arm.com
> Subject: RE: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
> 
> 
> 
> > -----Original Message-----
> > From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> > Sent: Thursday, August 31, 2017 4:20 PM
> > To: Bharat Bhushan <bharat.bhushan@nxp.com>; robh+dt at kernel.org;
> Mark
> > Rutland <mark.rutland@arm.com>; will.deacon at arm.com;
> oss at buserror.net;
> > Gang Liu <gang.liu@nxp.com>; devicetree at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org; linux- kernel at vger.kernel.org;
> > catalin.marinas at arm.com
> > Subject: Re: [PATCH] RM64: dts: ls208xa: Add iommu-map property for
> > pci
> >
> > [Fixing Mark's address...]
> >
> > On 31/08/17 11:41, Bharat Bhushan wrote:
> > >
> > >> -----Original Message-----
> > >> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> > >> Sent: Thursday, August 31, 2017 3:02 PM
> > >> To: Bharat Bhushan <bharat.bhushan@nxp.com>; robh+dt at kernel.org;
> > >> ark.rutland at arm.com; will.deacon at arm.com; oss at buserror.net; Gang
> > Liu
> > >> <gang.liu@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> > >> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > >> catalin.marinas at arm.com
> > >> Subject: Re: [PATCH] RM64: dts: ls208xa: Add iommu-map property for
> > >> pci
> > >>
> > >> On 31/08/17 10:23, Bharat Bhushan wrote:
> > >>> This patch adds iommu-map property for PCIe, which enables SMMU
> > >>> for these devices on LS208xA devices.
> > >>>
> > >>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > >>> ---
> > >>>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
> > >>>  1 file changed, 4 insertions(+)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > >>> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > >>> index 94cdd30..67cf605 100644
> > >>> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > >>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> > >>> @@ -606,6 +606,7 @@
> > >>>  			num-lanes = <4>;
> > >>>  			bus-range = <0x0 0xff>;
> > >>>  			msi-parent = <&its>;
> > >>> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by
> > >> u-boot */
> > >>
> > >> What does this do when your version of u-boot doesn't fill this in for
> you?
> > >
> > > Good question, frankly I have not thought of this case before.
> > > But if we pass length = 0 in above property then no fixup happen
> > > with happen with older u-boot. In this case of_iommu_configure()
> > > will return NULL iommu-ops and it switch to swio-tlb. Will that work?
> > I really don't like this. You rely on having invalid data in the DT,
> > and that seems just wrong.
> >
> > Why can't u-boot just generate that property, and we leave the DT alone?
> 
> We do not have smmu phandle allowing uboot to generate this.
> 
> > Or even better, you provide the right information for the few boards
> > that are based on this SoC, not relying on u-boot for anything that is
> > in the kernel tree?
> 
> On our platforms we have a h/w table which converts RID->Device-Id. I will
> check what will happen if that table is not initialized, can RID be equal to
> device-id is that case.
> If that will be allowed than we can give right information that will work with
> u-boot not updating this property.

U-boot uses a stream-id allocator and programs the h/w mapping table (rid to sid mapping table). Also it updates iommu-map property accordingly.
But If u-boot does not update iommu-map than we cannot have a valid full proof solution as stream-id allocation can change in u-boot. 

So the other option of u-boot generating this entry seems correct solution. This requires u-boot to know iommu-phandle, something similar to "msi-parent" used for "msi-map"
Device-tree binding need change to add iommu-phandle/iommu-parent for this. 

Thanks
-Bharat

> 
> Will revert after confirming this.
> 
> Thanks
> -Bharat
> >
> > Thanks,
> >
> > M.
> > --
> > Jazz is not dead. It just smells funny...
