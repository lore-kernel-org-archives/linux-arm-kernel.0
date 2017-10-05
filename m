From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 5 Oct 2017 12:25:45 -0500
Subject: [PATCH v2 2/7] PCI: aardvark: set PIO_ADDR_LS correctly in
 advk_pcie_rd_conf()
In-Reply-To: <20170928125838.11887-3-thomas.petazzoni@free-electrons.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-3-thomas.petazzoni@free-electrons.com>
Message-ID: <20171005172545.GQ25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 02:58:33PM +0200, Thomas Petazzoni wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> When setting the PIO_ADDR_LS register during a configuration read, we
> were properly passing the device number, function number and register
> number, but not the bus number, causing issues when reading the
> configuration of PCIe devices.
> 
> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Reviewed-by: Wilson Ding <dingwei@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> [Thomas: tweak commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index da2881ba7737..af7a9c4a61a4 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -459,7 +459,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	advk_writel(pcie, reg, PIO_CTRL);
>  
>  	/* Program the address registers */
> -	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
> +	reg = PCIE_CONF_ADDR(bus->number, devfn, where);

I think PCIE_BDF() is now unused and should be removed.

>  	advk_writel(pcie, reg, PIO_ADDR_LS);
>  	advk_writel(pcie, 0, PIO_ADDR_MS);
>  
> -- 
> 2.13.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
