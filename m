From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 21 Nov 2012 23:16:40 +0300
Subject: [PATCH 1/1] asix: use ramdom hw addr if the one read is not valid
In-Reply-To: <1353493362-30418-1-git-send-email-plagnioj@jcrosoft.com>
References: <1353493362-30418-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <50AD36A8.6000702@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/21/2012 01:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-usb at vger.kernel.org
> Cc: netdev at vger.kernel.org
> ---
>  drivers/net/usb/asix_devices.c |   24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 33ab824..7ebec5b 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -225,7 +225,13 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>  			   ret);
>  		goto out;
>  	}
> -	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +
> +	if (is_valid_ether_addr(buf)) {
> +		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +	} else {
> +		netdev_info(dev->net, "invalid hw address, using random\n");
> +		eth_hw_addr_random(dev->net);
> +	}
>  
>  	/* Initialize MII structure */
>  	dev->mii.dev = dev->net;
> @@ -423,7 +429,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  		netdev_dbg(dev->net, "Failed to read MAC address: %d\n", ret);
>  		return ret;
>  	}
> -	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +
> +	if (is_valid_ether_addr(buf)) {
> +		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +	} else {
> +		netdev_info(dev->net, "invalid hw address, using random\n");
> +		eth_hw_addr_random(dev->net);
> +	}
>  
>  	/* Initialize MII structure */
>  	dev->mii.dev = dev->net;
> @@ -777,7 +789,13 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
>  		netdev_dbg(dev->net, "Failed to read MAC address: %d\n", ret);
>  		return ret;
>  	}
> -	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +
> +	if (is_valid_ether_addr(buf)) {
> +		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +	} else {
> +		netdev_info(dev->net, "invalid hw address, using random\n");
> +		eth_hw_addr_random(dev->net);
> +	}
>  
>  	/* Initialize MII structure */
>  	dev->mii.dev = dev->net;

   Repeated thrice, this asks to be put into subroutine...

WBR, Sergei
