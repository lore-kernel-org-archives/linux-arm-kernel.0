From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 8 Jun 2010 19:45:36 +0200
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <4c0e7d5a.0c3ddf0a.2771.ffffd485@mx.google.com>
References: <4c0e7d5a.0c3ddf0a.2771.ffffd485@mx.google.com>
Message-ID: <20100608174536.GW1743@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 08, 2010 at 08:24:40PM +0300, Dmytro Milinevskyy wrote:

> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
> index ad3f1ec..5d6797a 100644
> --- a/arch/arm/mach-kirkwood/openrd-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
> @@ -47,6 +47,14 @@ static struct mv643xx_eth_platform_data openrd_ge01_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(24),
>  };
>  
> +static struct mv643xx_eth_platform_data openrd_ultimate_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +static struct mv643xx_eth_platform_data openrd_ultimate_ge01_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
> +};
> +
>  static struct mv_sata_platform_data openrd_sata_data = {
>  	.n_ports	= 2,
>  };
> @@ -73,9 +81,14 @@ static void __init openrd_init(void)
>  
>  	kirkwood_ehci_init();
>  
> -	kirkwood_ge00_init(&openrd_ge00_data);
> -	if (machine_is_openrd_client())
> -		kirkwood_ge01_init(&openrd_ge01_data);
> +	if (machine_is_openrd_ultimate()) {
> +		kirkwood_ge00_init(&openrd_ultimate_ge00_data);
> +		kirkwood_ge01_init(&openrd_ultimate_ge01_data);
> +	} else {
> +		kirkwood_ge00_init(&openrd_ge00_data);
> +		if (machine_is_openrd_client())
> +			kirkwood_ge01_init(&openrd_ge01_data);
> +	}

Just write the PHY addresses into openrd_ge0[01]_data here iff
machine_is_openrd_ultimate()?
