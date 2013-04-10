From: robherring2@gmail.com (Rob Herring)
Date: Wed, 10 Apr 2013 13:33:37 -0500
Subject: [PATCHv8 04/19] of/pci: Add of_pci_get_devfn() function
In-Reply-To: <1365541601-14095-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365541601-14095-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5165B081.1030105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2013 04:06 PM, Thomas Petazzoni wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> 
> This function can be used to parse the device and function number from a
> standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> the returned value obtain the device and function numbers respectively.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/of/of_pci.c    |   34 +++++++++++++++++++++++++++++-----
>  include/linux/of_pci.h |    1 +
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index ebb408b..b77e8d8 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -9,14 +9,15 @@
>  #endif
>  
>  static inline int __of_pci_pci_compare(struct device_node *node,
> -				       unsigned int devfn)
> +				       unsigned int data)
>  {
> -	unsigned int size;
> -	const __be32 *reg = of_get_property(node, "reg", &size);
> +	int devfn;
>  
> -	if (!reg || size < 5 * sizeof(__be32))
> +	devfn = of_pci_get_devfn(node);
> +	if (devfn < 0)
>  		return 0;
> -	return ((be32_to_cpup(&reg[0]) >> 8) & 0xff) == devfn;
> +
> +	return devfn == data;
>  }
>  
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
> @@ -208,3 +209,26 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  	}
>  }
>  #endif
> +
> +/**
> + * of_pci_get_devfn() - Get device and function numbers for a device node
> + * @np: device node
> + *
> + * Parses a standard 5-cell PCI resource and returns an 8-bit value that can
> + * be passed to the PCI_SLOT() and PCI_FUNC() macros to extract the device
> + * and function numbers respectively. On error a negative error code is
> + * returned.
> + */
> +int of_pci_get_devfn(struct device_node *np)
> +{
> +	unsigned int size;
> +	const __be32 *reg;
> +
> +	reg = of_get_property(np, "reg", &size);
> +
> +	if (!reg || size < 5 * sizeof(__be32))
> +		return -EINVAL;
> +
> +	return (be32_to_cpup(reg) >> 8) & 0xff;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_devfn);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index e56182f..302aca0 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -11,6 +11,7 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
>  struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
> +int of_pci_get_devfn(struct device_node *np);
>  
>  void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  			struct device_node *dev, int primary);
> 
