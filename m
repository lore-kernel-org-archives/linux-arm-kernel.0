From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Tue, 6 Mar 2018 04:41:56 +0000
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
Message-ID: <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, March 06, 2018 0:22
> 
> On 05/03/18 18:39, Christoph Hellwig wrote:
> > On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
> >> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's
> >> software-discoverable and the only thing described in DT is the bus "host",
> >> thus we need the same sort of thing as for PCI to map from the child
> >> devices back to the bus root in order to find the appropriate firmware
> >> node. Worse than PCI, though, we wouldn't even have the option of
> >> describing child devices statically in firmware at all, since it's actually
> >> one of these runtime-configurable "build your own network accelerator"
> >> hardware pools where userspace gets to create and destroy "devices" as it
> >> likes.
> >
> > I really hate the PCI special case just as much.  Maybe we just
> > need a dma_configure method on the bus, and move PCI as well as fsl-mc
> > to it.
> 
> Hmm, on reflection, 100% ack to that idea. It would neatly supersede
> bus->force_dma *and* mean that we don't have to effectively pull pci.h
> into everything, which I've never liked. In hindsight dma_configure()
> does feel like it's grown into this odd choke point where we munge
> everything in just for it to awkwardly unpick things again.
> 
> Robin.

+1 to the idea.

Sorry for asking a trivial question - looking into dma_configure() I see that
PCI is used in the start and the end of the API.
In the end part pci_put_host_bridge_device() is called.
So are two bus callbacks something like 'dma_config_start' & 'dma_config_end'
will be required where the former one will return "dma_dev"?

Regards,
Nipun
