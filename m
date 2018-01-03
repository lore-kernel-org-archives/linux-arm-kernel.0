From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 03 Jan 2018 12:27:22 +0100
Subject: [net-next: PATCH v2 1/5] device property: Introduce
 fwnode_get_mac_address()
In-Reply-To: <1514721520-18964-2-git-send-email-mw@semihalf.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-2-git-send-email-mw@semihalf.com>
Message-ID: <2588662.RyVCaj53xp@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 31, 2017 12:58:36 PM CET Marcin Wojtas wrote:
> Until now there were two almost identical functions for
> obtaining MAC address - of_get_mac_address() and, more generic,
> device_get_mac_address(). However it is not uncommon,
> that the network interface is represented as a child
> of the actual controller, hence it is not associated
> directly to any struct device, required by the latter
> routine.
> 
> This commit allows for getting the MAC address for
> children nodes in the ACPI world by introducing a new function -
> fwnode_get_mac_address(). This commit also changes
> device_get_mac_address() routine to be its wrapper, in order
> to prevent unnecessary duplication.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

The changes look reasonable to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/property.c  | 28 ++++++++++++++------
>  include/linux/property.h |  2 ++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 851b1b6..f261d1a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1153,11 +1153,11 @@ int device_get_phy_mode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_get_phy_mode);
>  
> -static void *device_get_mac_addr(struct device *dev,
> +static void *fwnode_get_mac_addr(struct fwnode_handle *fwnode,
>  				 const char *name, char *addr,
>  				 int alen)
>  {
> -	int ret = device_property_read_u8_array(dev, name, addr, alen);
> +	int ret = fwnode_property_read_u8_array(fwnode, name, addr, alen);
>  
>  	if (ret == 0 && alen == ETH_ALEN && is_valid_ether_addr(addr))
>  		return addr;
> @@ -1165,8 +1165,8 @@ static void *device_get_mac_addr(struct device *dev,
>  }
>  
>  /**
> - * device_get_mac_address - Get the MAC for a given device
> - * @dev:	Pointer to the device
> + * fwnode_get_mac_address - Get the MAC from the firmware node
> + * @fwnode:	Pointer to the firmware node
>   * @addr:	Address of buffer to store the MAC in
>   * @alen:	Length of the buffer pointed to by addr, should be ETH_ALEN
>   *
> @@ -1187,19 +1187,31 @@ static void *device_get_mac_addr(struct device *dev,
>   * In this case, the real MAC is in 'local-mac-address', and 'mac-address'
>   * exists but is all zeros.
>  */
> -void *device_get_mac_address(struct device *dev, char *addr, int alen)
> +void *fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr, int alen)
>  {
>  	char *res;
>  
> -	res = device_get_mac_addr(dev, "mac-address", addr, alen);
> +	res = fwnode_get_mac_addr(fwnode, "mac-address", addr, alen);
>  	if (res)
>  		return res;
>  
> -	res = device_get_mac_addr(dev, "local-mac-address", addr, alen);
> +	res = fwnode_get_mac_addr(fwnode, "local-mac-address", addr, alen);
>  	if (res)
>  		return res;
>  
> -	return device_get_mac_addr(dev, "address", addr, alen);
> +	return fwnode_get_mac_addr(fwnode, "address", addr, alen);
> +}
> +EXPORT_SYMBOL(fwnode_get_mac_address);
> +
> +/**
> + * device_get_mac_address - Get the MAC for a given device
> + * @dev:	Pointer to the device
> + * @addr:	Address of buffer to store the MAC in
> + * @alen:	Length of the buffer pointed to by addr, should be ETH_ALEN
> + */
> +void *device_get_mac_address(struct device *dev, char *addr, int alen)
> +{
> +	return fwnode_get_mac_address(dev_fwnode(dev), addr, alen);
>  }
>  EXPORT_SYMBOL(device_get_mac_address);
>  
> diff --git a/include/linux/property.h b/include/linux/property.h
> index f6189a3..35620e0 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -279,6 +279,8 @@ int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);
>  
> +void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> +			     char *addr, int alen);
>  struct fwnode_handle *fwnode_graph_get_next_endpoint(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
>  struct fwnode_handle *
> 
