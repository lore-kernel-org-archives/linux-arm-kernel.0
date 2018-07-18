From: davem@davemloft.net (David Miller)
Date: Thu, 19 Jul 2018 08:10:54 +0900 (KST)
Subject: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-2-brgl@bgdev.pl>
Message-ID: <20180719.081054.2060054138371290633.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jul 2018 18:10:31 +0200

> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;
>  
> -	if (dev_is_pci(dev))
> -		dp = pci_device_to_OF_node(to_pci_dev(dev));
> -	else
> -		dp = dev->of_node;
> -

Reverse christmas tree is why the assignments are in the body of
the function instead of the declaration area.

Please don't do this, thanks.
