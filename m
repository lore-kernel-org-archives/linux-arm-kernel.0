From: adam.cottrel@veea.com (Adam Cottrel)
Date: Thu, 18 Oct 2018 15:36:25 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <DM6PR04MB405906FA74124FFEBCA9188AF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>
 <DM6PR04MB405918E803AF4FCC34B12083F2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181015150912.GA8789@hc>
 <DM6PR04MB4059991247828ADBD6133D2FF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181015153926.GC8789@hc>
 <DM6PR04MB405906FA74124FFEBCA9188AF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
Message-ID: <DM6PR04MB40597DF28818CD395136EC17F2F80@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jan,

Sorry for the delay in getting back to you - the patch took longer than expected to finish.

 $ cat /proc/config.gz | gunzip | grep ERRATUM
CONFIG_ARM64_ERRATUM_826319=y
CONFIG_ARM64_ERRATUM_827319=y
CONFIG_ARM64_ERRATUM_824069=y
CONFIG_ARM64_ERRATUM_819472=y
CONFIG_ARM64_ERRATUM_832075=y
CONFIG_ARM64_ERRATUM_834220=y
CONFIG_ARM64_ERRATUM_845719=y
CONFIG_ARM64_ERRATUM_843419=y
CONFIG_CAVIUM_ERRATUM_22375=y
CONFIG_CAVIUM_ERRATUM_23144=y
CONFIG_CAVIUM_ERRATUM_23154=y
CONFIG_CAVIUM_ERRATUM_27456=y
CONFIG_CAVIUM_ERRATUM_28168=y                               <--------------------- HERE!!
CONFIG_CAVIUM_ERRATUM_30115=y
CONFIG_QCOM_FALKOR_ERRATUM_1003=y
CONFIG_QCOM_FALKOR_ERRATUM_1009=y
CONFIG_QCOM_QDF2400_ERRATUM_0065=y
CONFIG_FSL_ERRATUM_A008585=y
CONFIG_HISILICON_ERRATUM_161010101=y
CONFIG_ARM64_ERRATUM_858921=y

As you can see, the fix is enabled, but when I test, it is not making any difference to the original issue. The ath10k driver is still dropping inward DMA under memory pressure.

As an aside, I had to make one small change to the patch due to differences between earlier kernel versions. Please see cavium.diff attached. Is this an acceptable change?

Before we discount this as being a fix, please can you tell me how I can prove that the patch is actually working on my platform?

Best,
Adam

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Adam Cottrel
> Sent: 15 October 2018 16:51
> To: Jan Glauber <Jan.Glauber@cavium.com>
> Cc: Nair, Jayachandran <Jayachandran.Nair@cavium.com>; rric at kernel.org;
> Goutham, Sunil <Sunil.Goutham@cavium.com>; Will Deacon
> <will.deacon@arm.com>; Robin Murphy <robin.murphy@arm.com>; linux-
> arm-kernel at lists.infradead.org
> Subject: RE: DMA remote memcpy requests
> 
> Dear Jan,
> 
> > I'm not sure where that point would be where DMA request could be lost
> > here.
> > The MMC and PCIe only meet in the NCB (near coprocessor bus) which
> > goes to the Coherent memory interconnect and L2 cache.
> >
> > I've looked for any known errata but didn't find anything that would
> > match your problem.
> 
> For the purposes of debug, is it possible for me to turn off the MMC? Or the
> L2 cache? Or put it into pass through mode? Or get any kind of stack trace on
> its operation?
> 
> Best,
> Adam
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cavium.diff
Type: application/octet-stream
Size: 741 bytes
Desc: cavium.diff
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181018/b2b6c895/attachment.obj>
