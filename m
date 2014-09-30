From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 30 Sep 2014 15:45:06 +0100
Subject: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
In-Reply-To: <706416181.hbVGLDA3o6@wuerfel>
References: <706416181.hbVGLDA3o6@wuerfel>
Message-ID: <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 02:19:05PM +0100, Arnd Bergmann wrote:
> The pci_register_io_range() and pci_pio_to_address() were recently
> introduced to generalize the handling of memory mapped PCI I/O space,
> but they are only valid when CONFIG_OF is set, leading to a possible
> build error:
> 
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_setup_window':
> drivers/pci/host/pcie-rcar.c:340:3: error: implicit declaration of function 'pci_pio_to_address' [-Werror=implicit-function-declaration]
>    res_start = pci_pio_to_address(res->start);
>    ^
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_probe':
> drivers/pci/host/pcie-rcar.c:945:3: error: implicit declaration of function 'of_pci_range_to_resource' [-Werror=implicit-function-declaration]
>    err = of_pci_range_to_resource(&range, pdev->dev.of_node,
>    ^
> cc1: some warnings being treated as errors
> 
> This provides inline dummy implementations for the case that
> CONFIG_OF is disabled, to allow better build testing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 279c5dd046 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Is that triggered by shmobile_defconfig?

Best regards,
Liviu

> 
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 7ebb877b07c2..851097aab115 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -71,6 +71,11 @@ static inline const __be32 *of_get_address(struct device_node *dev, int index,
>  	return NULL;
>  }
>  
> +static inline phys_addr_t pci_pio_to_address(unsigned long pio)
> +{
> +	return 0;
> +}
> +
>  static inline int of_pci_range_parser_init(struct of_pci_range_parser *parser,
>  			struct device_node *node)
>  {
> @@ -144,6 +149,12 @@ static inline const __be32 *of_get_pci_address(struct device_node *dev,
>  {
>  	return NULL;
>  }
> +static inline int of_pci_range_to_resource(struct of_pci_range *range,
> +					   struct device_node *np,
> +					   struct resource *res)
> +{
> +	return -ENOSYS;
> +}
>  #endif /* CONFIG_OF_ADDRESS && CONFIG_PCI */
>  
>  #endif /* __OF_ADDRESS_H */
> 
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
