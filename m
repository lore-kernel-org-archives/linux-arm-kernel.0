From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 03 Jan 2018 12:27:56 +0100
Subject: [net-next: PATCH v2 2/5] device property: Introduce
 fwnode_get_phy_mode()
In-Reply-To: <1514721520-18964-3-git-send-email-mw@semihalf.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-3-git-send-email-mw@semihalf.com>
Message-ID: <8428717.xIdCg4rtFj@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 31, 2017 12:58:37 PM CET Marcin Wojtas wrote:
> Until now there were two almost identical functions for
> obtaining network PHY mode - of_get_phy_mode() and,
> more generic, device_get_phy_mode(). However it is not uncommon,
> that the network interface is represented as a child
> of the actual controller, hence it is not associated
> directly to any struct device, required by the latter
> routine.
> 
> This commit allows for getting the PHY mode for
> children nodes in the ACPI world by introducing a new function -
> fwnode_get_phy_mode(). This commit also changes
> device_get_phy_mode() routine to be its wrapper, in order
> to prevent unnecessary duplication.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/property.c  | 24 ++++++++++++++++----
>  include/linux/property.h |  1 +
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f261d1a..7c4a53d 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1126,21 +1126,21 @@ enum dev_dma_attr device_get_dma_attr(struct device *dev)
>  EXPORT_SYMBOL_GPL(device_get_dma_attr);
>  
>  /**
> - * device_get_phy_mode - Get phy mode for given device
> - * @dev:	Pointer to the given device
> + * fwnode_get_phy_mode - Get phy mode for given firmware node
> + * @fwnode:	Pointer to the given node
>   *
>   * The function gets phy interface string from property 'phy-mode' or
>   * 'phy-connection-type', and return its index in phy_modes table, or errno in
>   * error case.
>   */
> -int device_get_phy_mode(struct device *dev)
> +int fwnode_get_phy_mode(struct fwnode_handle *fwnode)
>  {
>  	const char *pm;
>  	int err, i;
>  
> -	err = device_property_read_string(dev, "phy-mode", &pm);
> +	err = fwnode_property_read_string(fwnode, "phy-mode", &pm);
>  	if (err < 0)
> -		err = device_property_read_string(dev,
> +		err = fwnode_property_read_string(fwnode,
>  						  "phy-connection-type", &pm);
>  	if (err < 0)
>  		return err;
> @@ -1151,6 +1151,20 @@ int device_get_phy_mode(struct device *dev)
>  
>  	return -ENODEV;
>  }
> +EXPORT_SYMBOL_GPL(fwnode_get_phy_mode);
> +
> +/**
> + * device_get_phy_mode - Get phy mode for given device
> + * @dev:	Pointer to the given device
> + *
> + * The function gets phy interface string from property 'phy-mode' or
> + * 'phy-connection-type', and return its index in phy_modes table, or errno in
> + * error case.
> + */
> +int device_get_phy_mode(struct device *dev)
> +{
> +	return fwnode_get_phy_mode(dev_fwnode(dev));
> +}
>  EXPORT_SYMBOL_GPL(device_get_phy_mode);
>  
>  static void *fwnode_get_mac_addr(struct fwnode_handle *fwnode,
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 35620e0..9b13332 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -279,6 +279,7 @@ int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);
>  
> +int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
>  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
>  			     char *addr, int alen);
>  struct fwnode_handle *fwnode_graph_get_next_endpoint(
> 
