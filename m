From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 01:07:55 +0100
Subject: [PATCH] ARM: mmp: map sram as MT_MEMORY rather than MT_DEVICE
In-Reply-To: <20110822164740.5682541b@queued.net>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
	<20110822164740.5682541b@queued.net>
Message-ID: <20110823000755.GE3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 04:47:40PM -0700, Andres Salomon wrote:
> The sram code allocates memory with ioremap, which assumes MT_DEVICE
> for memory protections.  This explodes when we map sram for power
> management purposes and then attempt to execute it (jump_to_lp_sram)
> on the OLPC XO-1.75.  Instead, we want to specify MT_MEMORY, which
> doesn't set the L_PTE_XN bit.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  arch/arm/mach-mmp/sram.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> Eric, this patch is against the devel branch of your pxa tree.
> 
> diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
> index 4304f95..ca4d3c1 100644
> --- a/arch/arm/mach-mmp/sram.c
> +++ b/arch/arm/mach-mmp/sram.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/genalloc.h>
> +#include <asm/mach/map.h>
>  
>  #include <mach/sram.h>
>  
> @@ -87,7 +88,8 @@ static int __devinit sram_probe(struct platform_device *pdev)
>  
>  	info->sram_phys   = (phys_addr_t)res->start;
>  	info->sram_size   = resource_size(res);
> -	info->sram_virt   = ioremap(info->sram_phys, info->sram_size);
> +	info->sram_virt   = __arm_ioremap(info->sram_phys, info->sram_size,
> +					  MT_MEMORY);

Not a good idea fiddling about under the covers like that.  The reason
that MT_MEMORY is not in asm/io.h is to stop it being used like this -
MT_MEMORY etc are not meant for general purpose use.

It needs to be looked at properly rather than working behind the APIs,
and making my life a misery by doing so, preventing me from making
changes where necessary by this kind of back-door use.

I guess we need a new ioremap_xxx() variant to cope with this.
