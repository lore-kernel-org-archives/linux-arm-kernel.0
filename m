From: alex@digriz.org.uk (Alexander Clouter)
Date: Wed, 9 Jun 2010 21:37:20 +0100
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <4c0ff6b2.0c3ddf0a.2185.2e09@mx.google.com>
References: <4c0ff6b2.0c3ddf0a.2185.2e09@mx.google.com>
Message-ID: <20100609203720.GK7660@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Dmytro Milinevskyy <milinevskyy@gmail.com> [2010-06-09 23:14:39+0300]:
>
> This patch adds support for the OpenRD Ultimate machine(could be found 
> at http://www.arm.linux.org.uk/developer/machines/list.php?id=2884)
> 
> Besides adding machine description this patch adds correction for PHY 
> address for Ultimate version.
> 
> Differences from the previous attempt:
>  - Applied suggestion from Lennert Buytenhek to change PHY addresses 
>  in instances of mv643xx_eth_platform_data in case of ultimate 
>  version.
> 
> Signed-off-by: Dmytro Milinevskyy <milinevskyy@gmail.com>
> ---
>  
> +	if (machine_is_openrd_ultimate()) {
> +		openrd_ge00_data.phy = 0;
> +		openrd_ge01_data.phy = 1;
> +	}
> +
>
Does this even work?  Surely you mean the following instead:
----
if (machine_is_openrd_ultimate()) {
	openrd_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
	openrd_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(1);
}
----

>  	kirkwood_ge00_init(&openrd_ge00_data);
> -	if (machine_is_openrd_client())
> +	if (machine_is_openrd_client() ||      \__same line
> +		machine_is_openrd_ultimate())  /
>  		kirkwood_ge01_init(&openrd_ge01_data);
> +  <------- REMOVE
>  	kirkwood_sata_init(&openrd_sata_data);
>  	kirkwood_sdio_init(&openrd_mvsdio_data);
>  
As that 'if()' clause is still less than 77 chars wide:
----
kirkwood_ge00_init(&openrd_ge00_data);
if (machine_is_openrd_client() || machine_is_openrd_ultimate())
	kirkwood_ge01_init(&openrd_ge01_data);
kirkwood_sata_init(&openrd_sata_data);
kirkwood_sdio_init(&openrd_mvsdio_data);
----

Cheers

-- 
Alexander Clouter
.sigmonster says: People respond to people who respond.
