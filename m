From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Mar 2014 12:55:01 +0900
Subject: [PATCH 60/62] ARM: shmobile: work around CONFIG_PHYLIB=m
In-Reply-To: <1395257399-359545-61-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-61-git-send-email-arnd@arndb.de>
Message-ID: <20140320035501.GE10601@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:57PM +0100, Arnd Bergmann wrote:
> When phylib is set to be built as a module, the lager and koelsch
> boards fail to build:
> 
> arch/arm/mach-shmobile/built-in.o: In function `lager_ksz8041_fixup':
> :(.text+0x738): undefined reference to `mdiobus_read'
> :(.text+0x73c): undefined reference to `mdiobus_write'
> arch/arm/mach-shmobile/built-in.o: In function `koelsch_ksz8041_fixup':
> :(.text+0x7e8): undefined reference to `mdiobus_read'
> :(.text+0x7ec): undefined reference to `mdiobus_write'
> 
> To work around that problem, this changes the code to check for
> IS_BUILTIN rather than IS_ENABLED, turning the error into a runtime
> problem. It's now possible to build random configurations, but the
> phy may be set up incorrectly in this case.

I wonder if Kconfig for koelsch should be tightened up somehow to
ensure that PHYLIB is either unselected or builtin.

Also, a minor nit, I would prefer changes for different boards
in different patches. But I can split the patch myself if its
not going to be changed otherwise.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-sh at vger.kernel.org
> ---
>  arch/arm/mach-shmobile/board-koelsch.c | 2 +-
>  arch/arm/mach-shmobile/board-lager.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index 5a034ff..b724f33 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
> @@ -510,7 +510,7 @@ static void __init koelsch_init(void)
>  
>  	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
>  
> -	if (IS_ENABLED(CONFIG_PHYLIB))
> +	if (IS_BUILTIN(CONFIG_PHYLIB))
>  		phy_register_fixup_for_id("r8a7791-ether-ff:01",
>  					  koelsch_ksz8041_fixup);
>  }
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index f0104bf..67b1069 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -869,7 +869,7 @@ static void __init lager_init(void)
>  
>  	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
>  
> -	if (IS_ENABLED(CONFIG_PHYLIB))
> +	if (IS_BUILTIN(CONFIG_PHYLIB))
>  		phy_register_fixup_for_id("r8a7790-ether-ff:01",
>  					  lager_ksz8041_fixup);
>  }
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
