From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jan 2018 11:16:50 +0000
Subject: [PATCH] arch: drop duplicate exports of abort()
In-Reply-To: <20180102103311.706364-1-arnd@arndb.de>
References: <20180102103311.706364-1-arnd@arndb.de>
Message-ID: <20180102111650.GC28752@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 11:31:12AM +0100, Arnd Bergmann wrote:
> We now have exports in both architecture code in in common code,
> which causes a link failure when symbol versioning is eanbled, on
> four architectures:
> 
> kernel/exit.o: In function `__crc_abort':
> exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
> 
> This removes the four architecture specific exports and only
> leaves the export next to the __weak symbol.
> 
> Fixes: mmotm ("kernel/exit.c: export abort() to modules")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For arm:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
> Andrew, can you apply this to -mm on top of the other patch?
> ---
>  arch/arc/kernel/traps.c       | 1 -
>  arch/arm/kernel/traps.c       | 1 -
>  arch/m32r/kernel/traps.c      | 1 -
>  arch/unicore32/kernel/traps.c | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
> index 51a55b06cb2a..133a4dae41fe 100644
> --- a/arch/arc/kernel/traps.c
> +++ b/arch/arc/kernel/traps.c
> @@ -169,4 +169,3 @@ void abort(void)
>  {
>  	__asm__ __volatile__("trap_s  5\n");
>  }
> -EXPORT_SYMBOL(abort);
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index e344bdd2e5ac..5e3633c24e63 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -793,7 +793,6 @@ void abort(void)
>  	/* if that doesn't kill us, halt */
>  	panic("Oops failed to kill thread");
>  }
> -EXPORT_SYMBOL(abort);
>  
>  void __init trap_init(void)
>  {
> diff --git a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
> index cb79fba79d43..b88a8dd14933 100644
> --- a/arch/m32r/kernel/traps.c
> +++ b/arch/m32r/kernel/traps.c
> @@ -122,7 +122,6 @@ void abort(void)
>  	/* if that doesn't kill us, halt */
>  	panic("Oops failed to kill thread");
>  }
> -EXPORT_SYMBOL(abort);
>  
>  void __init trap_init(void)
>  {
> diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
> index 5f25b39f04d4..c4ac6043ebb0 100644
> --- a/arch/unicore32/kernel/traps.c
> +++ b/arch/unicore32/kernel/traps.c
> @@ -298,7 +298,6 @@ void abort(void)
>  	/* if that doesn't kill us, halt */
>  	panic("Oops failed to kill thread");
>  }
> -EXPORT_SYMBOL(abort);
>  
>  void __init trap_init(void)
>  {
> -- 
> 2.9.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
