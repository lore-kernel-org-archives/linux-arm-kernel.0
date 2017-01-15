From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 15 Jan 2017 12:07:53 +0100
Subject: [PATCH net-next v3 07/10] net: Relocate dev_to_net_device() into
 core
In-Reply-To: <20170114214713.28109-8-f.fainelli@gmail.com>
References: <20170114214713.28109-1-f.fainelli@gmail.com>
 <20170114214713.28109-8-f.fainelli@gmail.com>
Message-ID: <20170115110753.GG26374@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 01:47:10PM -0800, Florian Fainelli wrote:
> dev_to_net_device() is moved from net/dsa/dsa.c to net/core/dev.c since
> it going to be used by net/dsa/dsa2.c and the namespace of the function
> justifies making it available to other users potentially.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/netdevice.h |  2 ++
>  net/core/dev.c            | 19 +++++++++++++++++++
>  net/dsa/dsa.c             | 18 ------------------
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 97ae0ac513ee..6d021c37b774 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4390,4 +4390,6 @@ do {								\
>  #define PTYPE_HASH_SIZE	(16)
>  #define PTYPE_HASH_MASK	(PTYPE_HASH_SIZE - 1)
>  
> +struct net_device *dev_to_net_device(struct device *dev);
> +
>  #endif	/* _LINUX_NETDEVICE_H */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ad5959e56116..7547e2ccc06b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8128,6 +8128,25 @@ const char *netdev_drivername(const struct net_device *dev)
>  	return empty;
>  }
>  
> +struct net_device *dev_to_net_device(struct device *dev)
> +{
> +	struct device *d;
> +
> +	d = device_find_class(dev, "net");
> +	if (d) {
> +		struct net_device *nd;
> +
> +		nd = to_net_dev(d);
> +		dev_hold(nd);
> +		put_device(d);
> +
> +		return nd;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dev_to_net_device);

This really isn't just a "struct device to net device cast" type
function, (otherwise a simple container_of() would work).  You are
walking the device tree and assuming it is in a specific order so that
this function works.  You better document the hell out of this,
otherwise people are going to try to use this and get very confused,
very quickly...

thanks,

greg k-h
