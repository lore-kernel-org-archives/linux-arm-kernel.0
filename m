From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Jan 2017 16:22:04 -0800
Subject: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
In-Reply-To: <1484266817-6725-1-git-send-email-aospan@netup.ru>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
Message-ID: <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2017 04:20 PM, Abylay Ospan wrote:
> pcie->dev->of_node not always defined (NULL) and can cause crash:
> 
> [   19.053195] Unable to handle kernel NULL pointer dereference at
> virtual address 00000020
> [<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
> (iproc_pcie_setup+0x30c/0xce0)
> 
> this patch adds sanity check to prevent crash.

Humm, how can it not be defined based on your earlier comment that you
are using this on NSP which is Device Tree exclusively? I would agree if
this was seen on e.g: MIPS/BCMA (47xx).

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
>  	parser->node = node;
>  	parser->pna = of_n_addr_cells(node);
>  	parser->np = parser->pna + na + ns;
> 


-- 
Florian
