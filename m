From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 16:37:07 +0200
Subject: [PATCH 1/4] ARM: mv78xx0: simplify ethernet device creation
In-Reply-To: <20160906140623.2853066-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Tue, 6 Sep 2016 16:06:20 +0200")
References: <20160906140623.2853066-1-arnd@arndb.de>
Message-ID: <87sht2bl9o.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., sept. 06 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> Out of the four ethernet devices on mv78xx0, only the first one
> has an error interrupt line, for the other ones we pass NO_IRQ
> and then ignore the argument.
>
> In order to get closer to complete remove of NO_IRQ, this simply
> drops the unused function arguments.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied on mvebu/soc with Reviewed-by tag from  Andrew Lunn

Thanks,

Gregory

> ---
>  arch/arm/mach-mv78xx0/common.c            | 9 ++-------
>  arch/arm/plat-orion/common.c              | 7 ++-----
>  arch/arm/plat-orion/include/plat/common.h | 7 ++-----
>  3 files changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
> index 6af5430d0d97..f72e1e9f5fc5 100644
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ b/arch/arm/mach-mv78xx0/common.c
> @@ -219,7 +219,6 @@ void __init mv78xx0_ge01_init(struct mv643xx_eth_platform_data *eth_data)
>  {
>  	orion_ge01_init(eth_data,
>  			GE01_PHYS_BASE, IRQ_MV78XX0_GE01_SUM,
> -			NO_IRQ,
>  			MV643XX_TX_CSUM_DEFAULT_LIMIT);
>  }
>  
> @@ -242,9 +241,7 @@ void __init mv78xx0_ge10_init(struct mv643xx_eth_platform_data *eth_data)
>  		eth_data->duplex = DUPLEX_FULL;
>  	}
>  
> -	orion_ge10_init(eth_data,
> -			GE10_PHYS_BASE, IRQ_MV78XX0_GE10_SUM,
> -			NO_IRQ);
> +	orion_ge10_init(eth_data, GE10_PHYS_BASE, IRQ_MV78XX0_GE10_SUM);
>  }
>  
>  
> @@ -266,9 +263,7 @@ void __init mv78xx0_ge11_init(struct mv643xx_eth_platform_data *eth_data)
>  		eth_data->duplex = DUPLEX_FULL;
>  	}
>  
> -	orion_ge11_init(eth_data,
> -			GE11_PHYS_BASE, IRQ_MV78XX0_GE11_SUM,
> -			NO_IRQ);
> +	orion_ge11_init(eth_data, GE11_PHYS_BASE, IRQ_MV78XX0_GE11_SUM);
>  }
>  
>  /*****************************************************************************
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index 78c8bf4043c0..7757f71fe709 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -354,7 +354,6 @@ static struct platform_device orion_ge01 = {
>  void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
>  			    unsigned long irq,
> -			    unsigned long irq_err,
>  			    unsigned int tx_csum_limit)
>  {
>  	fill_resources(&orion_ge01_shared, orion_ge01_shared_resources,
> @@ -404,8 +403,7 @@ static struct platform_device orion_ge10 = {
>  
>  void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
> -			    unsigned long irq,
> -			    unsigned long irq_err)
> +			    unsigned long irq)
>  {
>  	fill_resources(&orion_ge10_shared, orion_ge10_shared_resources,
>  		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> @@ -453,8 +451,7 @@ static struct platform_device orion_ge11 = {
>  
>  void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
> -			    unsigned long irq,
> -			    unsigned long irq_err)
> +			    unsigned long irq)
>  {
>  	fill_resources(&orion_ge11_shared, orion_ge11_shared_resources,
>  		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
> index 9e6d76ad48a9..8519727faa5e 100644
> --- a/arch/arm/plat-orion/include/plat/common.h
> +++ b/arch/arm/plat-orion/include/plat/common.h
> @@ -47,18 +47,15 @@ void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
>  void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
>  			    unsigned long irq,
> -			    unsigned long irq_err,
>  			    unsigned int tx_csum_limit);
>  
>  void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
> -			    unsigned long irq,
> -			    unsigned long irq_err);
> +			    unsigned long irq);
>  
>  void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
> -			    unsigned long irq,
> -			    unsigned long irq_err);
> +			    unsigned long irq);
>  
>  void __init orion_ge00_switch_init(struct dsa_platform_data *d,
>  				   int irq);
> -- 
> 2.9.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
