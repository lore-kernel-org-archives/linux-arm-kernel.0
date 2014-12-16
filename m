From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 15 Dec 2014 17:18:51 -0700
Subject: [PATCH v3 2/2] arm: pcibios: move to generic PCI domains
In-Reply-To: <1416569367-29409-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1416569367-29409-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20141216001851.GA1991@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 11:29:26AM +0000, Lorenzo Pieralisi wrote:

> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index b1315e1..dc2ed4d 100644
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -101,9 +101,7 @@ struct mvebu_pcie {
>  	struct mvebu_pcie_port *ports;
>  	struct msi_chip *msi;
>  	struct resource io;
> -	char io_name[30];
>  	struct resource realio;
> -	char mem_name[30];
>  	struct resource mem;
>  	struct resource busn;
>  	int nports;
> @@ -722,18 +720,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct mvebu_pcie *pcie = sys_to_pcie(sys);
>  	int i;
> -	int domain = 0;
>  
> -#ifdef CONFIG_PCI_DOMAINS
> -	domain = sys->domain;
> -#endif
> -
> -	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
> -		 domain);
> -	pcie->mem.name = pcie->mem_name;
> -
> -	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
> -	pcie->realio.name = pcie->io_name;
> +	pcie->mem.name = "PCI MEM";
> +	pcie->realio.name = "PCI I/O";
>  
>  	if (request_resource(&iomem_resource, &pcie->mem))
>  		return 0;

For the mvebu section:

Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason
