From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Mar 2018 08:41:15 +0100
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
 <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Message-ID: <20180308074115.GB15748@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
> Sorry for asking a trivial question - looking into dma_configure() I see that
> PCI is used in the start and the end of the API.
> In the end part pci_put_host_bridge_device() is called.
> So are two bus callbacks something like 'dma_config_start' & 'dma_config_end'
> will be required where the former one will return "dma_dev"?

I'd just use dma_configure as the callback.

Currently the of_dma_configure and acpi_dma_configure are only used
for PCI anyway, as no one else sets a non-NULL dma dev.   For fsl-mc
I suspect only of_dma_configure is relevanet, so just call that directly.
If at some point we get enough busses with either OF or ACPI we could
create a helper called from ->dma_configure for that.
