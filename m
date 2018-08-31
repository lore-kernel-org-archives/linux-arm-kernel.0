From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 31 Aug 2018 12:54:39 -0700
Subject: [PATCH v2 15/29] net: split eth_platform_get_mac_address() into
 subroutines
In-Reply-To: <20180810080526.27207-16-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-16-brgl@bgdev.pl>
Message-ID: <20180831195439.GB62862@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I responded to the cover letter, but I'll put some notes here too.

On Fri, Aug 10, 2018 at 10:05:12AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want do add more sources from which to read the MAC address. In
> order to avoid bloating this function too much, start by splitting it
> into subroutines, each of which takes care of reading the MAC from
> one source.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 7f08105402c8..d01dd55de037 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -525,22 +525,50 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  	return NULL;
>  }
>  
> -int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>  {
>  	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *np;
>  
> -	dp = dev->of_node;
> -	addr = NULL;
> -	if (dp)
> -		addr = of_get_mac_address(dp);
> -	if (!addr)
> -		addr = arch_get_platform_mac_address();
> +	np = dev->of_node;
> +	if (!np)
> +		return -ENODEV;
>  
> +	addr = of_get_mac_address(np);
>  	if (!addr)
>  		return -ENODEV;
>  
> +	if (!addr || !is_valid_ether_addr(addr))
> +		return -ENODEV;
> +
>  	ether_addr_copy(mac_addr, addr);
>  	return 0;
>  }
> +
> +static int mac_address_from_arch(u8 *mac_addr)
> +{
> +	const unsigned char *addr;
> +
> +	addr = arch_get_platform_mac_address();
> +	if (!addr || !is_valid_ether_addr(addr))
> +		return -ENODEV;
> +
> +	ether_addr_copy(mac_addr, addr);
> +	return 0;
> +}
> +
> +int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +{
> +	int rv;
> +
> +	rv = mac_address_from_of(dev, mac_addr);

This could just be replaced with device_get_mac_address(). Then you
should be extending either fwnode_get_device_mac_address() or
device_get_mac_addres() in the next patch, not
eth_platform_get_mac_address().

Regards,
Brian

> +	if (!rv)
> +		return 0;
> +
> +	rv = mac_address_from_arch(mac_addr);
> +	if (!rv)
> +		return 0;
> +
> +	return -ENODEV;
> +}
>  EXPORT_SYMBOL(eth_platform_get_mac_address);
> -- 
> 2.18.0
> 
