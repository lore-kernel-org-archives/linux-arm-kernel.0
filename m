From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 26 Jun 2014 11:12:49 +0800
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Message-ID: <20140626031247.GN2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.

We may not want to add a random delay into the driver before we
understand the root cause of the issue.

Do you see this issue with FSL kernel?

Shawn

> 
> Suggested-by: David M?ller <d.mueller@elsoft.ch>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I am happy to get feedback on how to properly fix this.
> 
> Thanks
> 
>  drivers/pci/host/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index a568efa..669f771 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -507,6 +507,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
>  
> +	usleep_range(25000, 30000);
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");
> -- 
> 1.8.3.2
> 
