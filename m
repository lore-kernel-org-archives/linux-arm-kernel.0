From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 14:00:05 +0200
Subject: [PATCH] ARM: ux500: get rid of static maps
In-Reply-To: <1431514387-26209-1-git-send-email-linus.walleij@linaro.org>
References: <1431514387-26209-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3099510.cFvmYp6QHQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 12:53:07 Linus Walleij wrote:
> The static mappings of the GPIO blocks, clock/reset controller
> and MTU timer are clearly superfluous. These are all probed
> exclusively from the device tree. Tested on the U8500.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC-guys: please apply this single clean-up patch
> directly to the ARM SoC-tree where apropriate.

Applied to next/cleanup, very nice!

>  arch/arm/mach-ux500/cpu-db8500.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 6f63954c8bde..537a7753afc1 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -48,25 +48,14 @@ static struct map_desc u8500_uart_io_desc[] __initdata = {
>         __IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
>         __IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
>  };
> +
>  /*  U8500 and U9540 common io_desc */
>  static struct map_desc u8500_common_io_desc[] __initdata = {
>         /* SCU base also covers GIC CPU BASE and TWD with its 4K page */
>         __IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
>         __IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
>         __IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
> -       __IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
>         __IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),

Could you have a look at removing the other ones as well? I think
that would be a nice cleanup. I think it can be done like this:

U8500_UART?_BASE: obsolete if you call debug_ll_io_init() or have an empty
  map_io function

U8500_SCU_BASE: add a local variable in platsmp.c and use of_iomap, or
  ioremap with a fixed physical address if the DT node is missing

U8500_GIC_DIST_BASE: I don't really understand what's going on. We could
  just move the two users into local functions of the cpuidle driver and
  use ioremap of the GIC, but there might be a proper solution.

U8500_L2CC_BASE: it looks like ux500_l2x0_unlock() can be deleted, the
  l2x0_of_init() function already does this in l2c_unlock

U8500_BACKUPRAM0_BASE: the right solution is probably to use the generic
  sram, but ioremap() of the physical address in wakeup_secondary would
  also work

U8500_PRCMU_BASE: use a local variable in ux500_init_irq, and do an
  of_iomap() to pass a virtual address. Currently the callee already 
  does an ioremap, so it's probably not needed.

U8500_PRCMU_TCDM_BASE: unused?

	Arnd
