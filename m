From: karl@hiramoto.org (Karl Hiramoto)
Date: Tue, 03 Nov 2009 21:27:23 +0100
Subject: [PATCH] IXP4xx: Ensure index is positive
In-Reply-To: <4AF08014.4000704@gmail.com>
References: <4AF08014.4000704@gmail.com>
Message-ID: <4AF0922B.3030701@hiramoto.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roel Kluin wrote:
> The indexes are signed, make sure they are not negative
> when we read the array elements.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/arm/mach-ixp4xx/common.c     |    2 +-
>  arch/arm/mach-ixp4xx/ixp4xx_npe.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index cfd52fb..2df77bc 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -119,7 +119,7 @@ EXPORT_SYMBOL(gpio_to_irq);
>  
>  int irq_to_gpio(int irq)
>  {
> -	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
> +	int gpio = (irq < 32 && irq >= 0) ? irq2gpio[irq] : -EINVAL;
>  
>  	if (gpio == -1)
>  		return -EINVAL;
> diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> index 47ac69c..30e1456 100644
> --- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> +++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> @@ -667,7 +667,7 @@ err:
>  
>  struct npe *npe_request(int id)
>  {
> -	if (id < NPE_COUNT)
> +	if (id >= 0 && id < NPE_COUNT)
>  		if (npe_tab[id].valid)
>  			if (try_module_get(THIS_MODULE))
>  				return &npe_tab[id];
>
>   
changing npe_request() to unsigned would probably be better and  not add 
to bloat.   If your calling these functions with negative arguments, 
your code is buggy then.
