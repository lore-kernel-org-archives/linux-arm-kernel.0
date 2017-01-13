From: ray.jui@broadcom.com (Ray Jui)
Date: Thu, 12 Jan 2017 16:45:49 -0800
Subject: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
In-Reply-To: <1484266817-6725-1-git-send-email-aospan@netup.ru>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
Message-ID: <5c51f96f-1c49-3768-d3ef-1deb40bef713@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/12/2017 4:20 PM, Abylay Ospan wrote:
> pcie->dev->of_node not always defined (NULL) and can cause crash:

Ah I guess this can happen with the BCMA based platforms that do not use
device tree for PCIe?

> 
> [   19.053195] Unable to handle kernel NULL pointer dereference at
> virtual address 00000020
> [<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
> (iproc_pcie_setup+0x30c/0xce0)
> 
> this patch adds sanity check to prevent crash.
> 
> Signed-off-by: Abylay Ospan <aospan@netup.ru>
> ---
>  drivers/pci/host/pcie-iproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 3ebc025..f2836a9 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>  	const int na = 3, ns = 2;
>  	int rlen;
>  
> +	if (!node)
> +		return -ENOENT;
> +

Looks like a valid check to me.

Acked-by: Ray Jui <ray.jui@broadcom.com>

>  	parser->node = node;
>  	parser->pna = of_n_addr_cells(node);
>  	parser->np = parser->pna + na + ns;
> 
