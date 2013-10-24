From: galak@kernel.crashing.org (Kumar Gala)
Date: Wed, 23 Oct 2013 23:11:07 -0500
Subject: [PATCH 02/12][v3] pci: fsl: add structure fsl_pci
In-Reply-To: <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
 <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 23, 2013, at 5:41 AM, Minghuan Lian wrote:

> PowerPC uses structure pci_controller to describe PCI controller,
> but ARM uses structure pci_sys_data. In order to support PowerPC
> and ARM simultaneously, the patch adds a structure fsl_pci that
> contains most of the members of the pci_controller and pci_sys_data.
> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> be implemented in architecture-specific PCI controller driver to
> convert pci_controller or pci_sys_data to fsl_pci.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> change log:
> v1-v3:
> Derived from http://patchwork.ozlabs.org/patch/278965/
> 
> Based on upstream master.
> Based on the discussion of RFC version here
> http://patchwork.ozlabs.org/patch/274487/
> 
> include/linux/fsl/pci-common.h | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

NAK.

We discussed this some at the ARM Summit this week and the feeling is we need to move to a common interface between the various ARCHs.

- k

> 
> diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
> index 5e4f683..e56a040 100644
> --- a/include/linux/fsl/pci-common.h
> +++ b/include/linux/fsl/pci-common.h
> @@ -102,5 +102,46 @@ struct ccsr_pci {
> 
> };
> 
> +/*
> + * Structure of a PCI controller (host bridge)
> + */
> +struct fsl_pci {
> +	struct list_head node;
> +	bool is_pcie;
> +	struct device_node *dn;
> +	struct device *dev;
> +
> +	int first_busno;
> +	int last_busno;
> +	int self_busno;
> +	struct resource busn;
> +
> +	struct pci_ops *ops;
> +	struct ccsr_pci __iomem *regs;
> +
> +	u32 indirect_type;
> +
> +	struct resource io_resource;
> +	resource_size_t io_base_phys;
> +	resource_size_t pci_io_size;
> +
> +	struct resource mem_resources[3];
> +	resource_size_t mem_offset[3];
> +
> +	int global_number;	/* PCI domain number */
> +
> +	resource_size_t dma_window_base_cur;
> +	resource_size_t dma_window_size;
> +
> +	void *sys;
> +};
> +
> +/*
> + * Convert architecture specific pci controller structure to fsl_pci
> + * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
> + * to describe pci controller.
> + */
> +extern struct fsl_pci *fsl_arch_sys_to_pci(void *sys);
> +
> #endif /* __PCI_COMMON_H */
> #endif /* __KERNEL__ */
> -- 
> 1.8.1.2
> 
