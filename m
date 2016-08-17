From: mingkai.hu@nxp.com (Mingkai Hu)
Date: Wed, 17 Aug 2016 09:49:20 +0000
Subject: Support for configurable PCIe endpoint
In-Reply-To: <57A31299.2040805@ti.com>
References: <57A18927.9070003@ti.com>
 <7c696488-eb78-d6d9-dc70-49fa5b4e3317@synopsys.com> <57A31299.2040805@ti.com>
Message-ID: <VI1PR04MB14544C83482106ABF1067D5F8E140@VI1PR04MB1454.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: Thursday, August 04, 2016 6:02 PM
> To: Joao Pinto <Joao.Pinto@synopsys.com>; bhelgaas at google.com; linux-
> pci at vger.kernel.org; arnd at arndb.de; Jingoo Han <jingoohan1@gmail.com>;
> Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Ley Foon Tan <lftan@altera.com>; Rob Herring <robh@kernel.org>;
> Tanmay Inamdar <tinamdar@apm.com>; Roy Zang <tie-
> fei.zang at freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Minghuan Lian <minghuan.Lian@freescale.com>; Richard Zhu
> <Richard.Zhu@freescale.com>; Lucas Stach <l.stach@pengutronix.de>;
> Murali Karicheri <m-karicheri2@ti.com>; Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com>; Jason Cooper
> <jason@lakedaemon.net>; Thierry Reding <thierry.reding@gmail.com>;
> Simon Horman <horms@verge.net.au>; Zhou Wang
> <wangzhou1@hisilicon.com>; Gabriele Paoloni
> <gabriele.paoloni@huawei.com>; Stanimir Varbanov <svarbanov@mm-
> sol.com>; David Daney <david.daney@cavium.com>; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; Carlos Palminha
> <CARLOS.PALMINHA@synopsys.com>
> Subject: Re: Support for configurable PCIe endpoint
> 
> Hi,
> 
> On Wednesday 03 August 2016 07:09 PM, Joao Pinto wrote:
> > Hi Kishon,
> >
> > On 8/3/2016 7:03 AM, Kishon Vijay Abraham I wrote:
> >> Hi,
> >>
> >> The PCIe controller present in TI's DRA7 SoC is capable of operating
> >> either in Root Complex mode or Endpoint mode. (It uses Synopsys
> >> Designware Core). I'd assume most of the PCIe controllers on other
> >> platforms that use Designware core should also be capable to operate
> >> in endpoint mode. But linux kernel right now supports only RC mode.
> >>
> >> PCIe endpoint support discussion came up briefly before [1] but it
> >> was felt the practical use case will find firmware more suitable and
> >> endpoint support in kernel can be used only for validation or demo.
> >>
> >> *) Modify platform driver to support EP mode (in my case pci-dra7xx.c).
> >>
> >> *) dt binding specific to EP mode should be created.
> >>
> >> Once I complete the implementation and start posting RFC patches, a
> >> lot of these will become clear. But I want to check if this sounds
> >> okay to you guys before starting the implementation.
> >>
> >> Let me know if you have some other ideas too.
> >>
> >> Cheers
> >> Kishon
> >>
> >> [1] -> http://www.spinics.net/lists/linux-pci/msg26026.html
> >>
> >
> > You are rising a topic that we are also addressing in Synopsys.
> >
> > For the PCIe RC hardware validation we are currently using the
> > standard pcie-designware and pcie-designware-plat drivers.
> >
> > For the Endpoint we have to use an internal software package. Its main
> > purpose is to initialize the IP registers, eDMA channels and make data
> > transfer to prove that the everything is working properly. This is
> > done in 2 levels, a custom driver built and loaded and an application
> > that makes some ioctl to the driver executing some interesting
> > functions to check the Endpoint status and make some data exchange.
> 
> hmm.. the platform I have doesn't have a DMA in PCIe IP
> (http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf). So in your testing does
> the EP access RC memory? i.e the driver in the RC allocates memory from it's
> DDR and gives it's DDR address to the EP. The EP then transfers data to this
> address. (This is a typical use case with ethernet PCIe cards). IIUC that's not
> simple with configurable EPs. I'd like to know more about your testing though.
> 

Hi Kishon,

This is a typical user case for EP to use DMA transfer data to/from RC memory.
In our case, we implement ring (like BD ring) or register in EP to communicate
The address allocated in RC memory, then EP can transfer data to/from RC memory.

Thanks,
Mingkai
