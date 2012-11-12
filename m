From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 20:44:13 +0000
Subject: [PATCH] ARM: integrator: use BUG_ON where possible
In-Reply-To: <1352406191-14303-6-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-6-git-send-email-sasha.levin@oracle.com>
Message-ID: <201211122044.13663.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Sasha Levin wrote:
> Just use BUG_ON() instead of constructions such as:
> 
> 	if (...)
> 		BUG()
> 
> A simplified version of the semantic patch that makes this transformation
> is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> - if (e) BUG();
> + BUG_ON(e);
> // </smpl>
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

Linus Walleij is doing most of the integrator work these days, maybe he
wants to apply the patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  arch/arm/mach-integrator/pci_v3.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
> index bbeca59..85938de 100644
> --- a/arch/arm/mach-integrator/pci_v3.c
> +++ b/arch/arm/mach-integrator/pci_v3.c
> @@ -191,12 +191,9 @@ static void __iomem *v3_open_config_window(struct pci_bus *bus,
>  	/*
>  	 * Trap out illegal values
>  	 */
> -	if (offset > 255)
> -		BUG();
> -	if (busnr > 255)
> -		BUG();
> -	if (devfn > 255)
> -		BUG();
> +	BUG_ON(offset > 255);
> +	BUG_ON(busnr > 255);
> +	BUG_ON(devfn > 255);
>  
>  	if (busnr == 0) {
>  		int slot = PCI_SLOT(devfn);
> -- 
> 1.7.10.4
> 
> 
