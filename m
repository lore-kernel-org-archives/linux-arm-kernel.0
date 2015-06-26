From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 Jun 2015 13:55:47 -0700
Subject: [PATCH] ARM: BCM: Enable NAND support for iProc SoCs
In-Reply-To: <1432861754-26606-1-git-send-email-rjui@broadcom.com>
References: <1432861754-26606-1-git-send-email-rjui@broadcom.com>
Message-ID: <558DBC53.3050100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/15 18:09, Ray Jui wrote:
> Select CONFIG_MTD_NAND_BRCMNAND for all iProc SoCs

In fact, this patch creates an unmet dependency problem, we also need to
select MTD and MTD_NAND otherwise we run into a linking error while
building the brcmnand driver:

  LD      init/built-in.o
drivers/built-in.o: In function `brcmnand_remove':
/home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:2234:
undefined reference to `nand_release'
drivers/built-in.o: In function `brcmnand_init_cs':
/home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:1933:
undefined reference to `nand_scan_ident'
/home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:1958:
undefined reference to `nand_scan_tail'
Makefile:931: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

I will take care of that and send a fix for 4.2.

> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> ---
>  arch/arm/mach-bcm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8b11f44..1268e35 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select PINCTRL
> +	select MTD_NAND_BRCMNAND
>  	help
>  	  This enables support for systems based on Broadcom IPROC architected SoCs.
>  	  The IPROC complex contains one or more ARM CPUs along with common
> 


-- 
Florian
