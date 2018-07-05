From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 5 Jul 2018 15:15:22 +0100
Subject: [PATCH 1/2] PCI: aardvark: Size bridges before resources
 allocation
In-Reply-To: <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
 <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
Message-ID: <20180705141522.GA13716@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 11:16:19AM +0200, Thomas Petazzoni wrote:
> From: Zachary Zhang <zhangzg@marvell.com>
> 
> The PCIE I/O and MEM resource allocation mechanism is that root bus
> goes through the following steps:
> 
> 1. Check PCI bridges' range and computes I/O and Mem base/limits.
> 
> 2. Sort all subordinate devices I/O and MEM resource requirements and
>    allocate the resources and writes/updates subordinate devices'
>    requirements to PCI bridges I/O and Mem MEM/limits registers.
> 
> Currently, PCI Aardvark driver only handles the second step and lacks
> the first step, so there is an I/O and MEM resource allocation failure
> when using a PCI switch. This commit fixes that by sizing bridges
> before doing the resource allocation.
> 
> Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
> [Thomas: edit commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 1 +
>  1 file changed, 1 insertion(+)

Hi Thomas,

I am queueing these two patches but this one seems a serious bug,
I reckon we should send it to stable kernels (and would be grateful
if you provide me with a Fixes tag and a kernel log to add to the
commit log).

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 486c41721c89..8e92231214e3 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1065,6 +1065,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  
>  	bus = bridge->bus;
>  
> +	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)
> -- 
> 2.14.4
> 
