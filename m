From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 23 Sep 2014 17:14:19 -0600
Subject: [PATCH v3 2/3] PCI: designware: Add get_msi_data() to
 pcie_host_ops
In-Reply-To: <1411482540-31297-4-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-4-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20140923231419.GA27357@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Mohit, Jingoo]

On Tue, Sep 23, 2014 at 10:28:59PM +0800, Minghuan Lian wrote:
> The patch adds get_msi_data() for some platforms to return their
> special MSI message data.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Change log:
> v3: no change
> v2: no change just derived from v1
> 
>  drivers/pci/host/pcie-designware.c | 7 ++++++-
>  drivers/pci/host/pcie-designware.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 1c09f814..c28ca05 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -366,7 +366,12 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
>  	else
>  		msg.address_lo = virt_to_phys((void *)pp->msi_data);
>  	msg.address_hi = 0x0;
> -	msg.data = pos;
> +
> +	if (pp->ops->get_msi_data)
> +		msg.data = pp->ops->get_msi_data(pp, pos);
> +	else
> +		msg.data = pos;
> +
>  	write_msi_msg(irq, &msg);
>  
>  	return 0;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 904e40a..c625675 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -71,6 +71,7 @@ struct pcie_host_ops {
>  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
>  	u32 (*get_msi_addr)(struct pcie_port *pp);
> +	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
>  	void (*scan_bus)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
>  };
> -- 
> 1.9.1
> 
