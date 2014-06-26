From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 26 Jun 2014 10:41:25 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Message-ID: <1403772085.4254.1.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Dienstag, den 24.06.2014, 16:18 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
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

I would suspect the issue to be somewhere in imx6_pcie_host_init(). Can
you move the delay there (and to different positions in this function)
to narrow down where the hang happens?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
