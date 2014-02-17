From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 17 Feb 2014 09:08:00 +0000
Subject: [PATCHv11 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <ca19105670be4af882ed72d3e004a6c7@BLUPR03MB472.namprd03.prod.outlook.com>
References: <1390209831-15679-1-git-send-email-b35083@freescale.com>
 <ca19105670be4af882ed72d3e004a6c7@BLUPR03MB472.namprd03.prod.outlook.com>
Message-ID: <de84e857254848fb86dfcffa65617f47@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Vinod,

    Could you please help merge this patch? We are having some other upstreaming
patches using the dma functionality pending the acceptance of the eDMA driver.
    Many thanks!

Best Regards,
Jingchang

> -----Original Message-----
> From: Lu Jingchang-B35083
> Sent: Monday, January 27, 2014 1:20 PM
> To: Lu Jingchang-B35083; vinod.koul at intel.com
> Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org;
> pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Wang Huan-B18965
> Subject: RE: [PATCHv11 2/2] dma: Add Freescale eDMA engine driver support
> 
> Hi, Vinod,
> 
>   Let me give some more explanation on the eDMA engine pause and
> termination here:
> The eDMA engine is a request-driven controller, it manage all channels in
> one engine and schedule them to perform each one's transfer when one's
> dma request arrive.
> When a dma request of a specific channel is received, the channel's
> appropriate TCD Parameter contents are loaded into the eDMA engine, and
> the appropriate reads and writes Perform until the minor byte transfer
> count has transferred, the number of bytes to transfer per request is
> determined by the salve's characteristics, such as the FIFO size, and the
> dma request condition is also determined by specific slave, such as FIFO
> empty.
> And to the transfer a bunch of data need many dma requests.
>   So if the dma request enable bit of a channel is cleared, there will be
> no further dma Request received by the eDMA engine, thus the channel will
> never be scheduled to run by the eDMA engine, the channel is paused,
> halted, also as stopped. If the channel need to transfer the remained
> data with the previous setting, just set the dma request enable bit, the
> transfer will complete with slave's dma request.(resume) If the
> parameters need be changed, corresponding register parameters can be
> reprogrammed, after all is ok, the dma request enable bit can be set to
> enable a new dma transfer.(terminate)
>   So is this ok and could it be merged, thanks!
> 
> 
> Best Regards,
> Jingchang
> 
> 
> > -----Original Message-----
> > From: Jingchang Lu [mailto:b35083 at freescale.com]
> > Sent: Monday, January 20, 2014 5:24 PM
> > To: vinod.koul at intel.com
> > Cc: dan.j.williams at intel.com; arnd at arndb.de; shawn.guo at linaro.org;
> > pawel.moll at arm.com; mark.rutland at arm.com; swarren at wwwdotorg.org; linux-
> > kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > devicetree at vger.kernel.org; Lu Jingchang-B35083; Wang Huan-B18965
> > Subject: [PATCHv11 2/2] dma: Add Freescale eDMA engine driver support
> >
> > Add Freescale enhanced direct memory(eDMA) controller support.
> > This module can be found on Vybrid and LS-1 SoCs.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > changes in v11:
> >  Add dma device_slave_caps definition.
> >
> > changes in v10:
> >  define fsl_edma_mutex in fsl_edma_engine instead of global.
> >  minor changes of binding description.
> >
> > changes in v9:
> >  define endian's operating functions instead of macro definition.
> >  remove the filter function, using dma_get_slave_channel instead.
> >
> > changes in v8:
> >  change the edma driver according eDMA dts change.
> >  add big-endian and little-endian handling.
> >
> >  no changes in v4 ~ v7.
> >
> >  changes in v3:
> >   add vf610 edma dt-bindings namespace with prefix VF610_*.
> >
> >  changes in v2:
> >   using generic dma-channels property instead of fsl,dma-channels.
> >
> >  Documentation/devicetree/bindings/dma/fsl-edma.txt |  76 ++
> >  drivers/dma/Kconfig                                |  10 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/fsl-edma.c                             | 975
> > +++++++++++++++++++++
> >  4 files changed, 1062 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
> >  create mode 100644 drivers/dma/fsl-edma.c
