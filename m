From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Jul 2018 18:42:18 +0200
Subject: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-5-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
Message-ID: <20180718164218.GD12477@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		if (!IS_ERR(nvmem)) {
> +			addr = nvmem_cell_read(nvmem, &alen);
> +			if (!IS_ERR(addr)) {
> +				from = "nvmem";
> +				/* Don't use ether_addr_copy() in case we
> +				 * didn't get the right size.
> +				 */

Please verify the size. A short read can still give a valid MAC
address, so the is_valid_ether_addr(addr) is not sufficient.

> +				memcpy(addrbuf, addr, alen);

Another reason to check the length is that you appear to have a buffer
overflow here, if alen > 6.

	 Andrew

> +				kfree(addr);
> +				addr = addrbuf;
> +			}
> +
> +			nvmem_cell_put(nvmem);
> +		}
> +	}
> +
>  	if (!addr || !is_valid_ether_addr(addr))
>  		return -ENODEV;
>  
> -- 
> 2.17.1
> 
