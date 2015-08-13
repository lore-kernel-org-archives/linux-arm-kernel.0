From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 13 Aug 2015 12:57:07 +0100
Subject: [PATCH 1/2] Add a matching set of device_ functions for
 determining mac/phy
In-Reply-To: <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
Message-ID: <55CC8613.1040709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 12/08/15 23:06, Jeremy Linton wrote:
[...]
> +static void *device_get_mac_addr(struct device *dev,
> +				 const char *name, char *addr,
> +				 int alen)
> +{
> +	int ret = device_property_read_u8_array(dev, name, addr, alen);
> +
> +	if (ret == 0 && is_valid_ether_addr(addr))
> +		return addr;
> +	return NULL;
> +}

Not sure I understand the logic here - "return the same thing we were 
given if we updated it, or null if we didn't". It's only indicating 
success/failure (the caller can perfectly well cast its own buffer to a 
void * if it needs to), so why wouldn't you just return a normal int 
error code?

> +/**
> + * Search the device tree for the best MAC address to use.  'mac-address' is
> + * checked first, because that is supposed to contain to "most recent" MAC
> + * address. If that isn't set, then 'local-mac-address' is checked next,
> + * because that is the default address.  If that isn't set, then the obsolete
> + * 'address' is checked, just in case we're using an old device tree.
> + *
> + * Note that the 'address' property is supposed to contain a virtual address of
> + * the register set, but some DTS files have redefined that property to be the
> + * MAC address.
> + *
> + * All-zero MAC addresses are rejected, because those could be properties that
> + * exist in the device tree, but were not set by U-Boot.  For example, the
> + * DTS could define 'mac-address' and 'local-mac-address', with zero MAC
> + * addresses.  Some older U-Boots only initialized 'local-mac-address'.  In
> + * this case, the real MAC is in 'local-mac-address', and 'mac-address' exists
> + * but is all zeros.
> +*/
> +void *device_get_mac_address(struct device *dev, char *addr, int alen)
> +{
> +	addr = device_get_mac_addr(dev, "mac-address", addr, alen);
> +	if (addr)
> +		return addr;
> +
> +	addr = device_get_mac_addr(dev, "local-mac-address", addr, alen);
> +	if (addr)
> +		return addr;
> +
> +	return device_get_mac_addr(dev, "address", addr, alen);
> +}
> +EXPORT_SYMBOL(device_get_mac_address);

Same here, it's not at all apparent why this should return a void * 
instead of an int (or even possibly bool). of_get_mac_address is giving 
its caller back a _new_ pointer they didn't know about before; this isn't.

Robin.
