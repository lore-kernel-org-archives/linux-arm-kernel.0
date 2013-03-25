From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 13:44:25 +0800
Subject: [PATCH 2/8] ARM: sirf: fix prima2 interrupt lookup
In-Reply-To: <1363779679-16880-3-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-3-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4wRGw7=WD58VX6WiyuKjuN4XpRdCVuPQr6HGCXrqyar1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/20 Arnd Bergmann <arnd@arndb.de>:
> We must not read the interrupts property manually but instead
> use irq_of_parse_and_map() to guarantee that we get the correct
> interrupt number once we stop using the legacy IRQ domain.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Barry Song <Baohua.Song@csr.com>

> ---
>  arch/arm/mach-prima2/timer-prima2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-prima2/timer-prima2.c b/arch/arm/mach-prima2/timer-prima2.c
> index 6da584f..9829083 100644
> --- a/arch/arm/mach-prima2/timer-prima2.c
> +++ b/arch/arm/mach-prima2/timer-prima2.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <mach/map.h>
>  #include <asm/sched_clock.h>
> @@ -223,7 +224,6 @@ static struct of_device_id timer_ids[] = {
>  static void __init sirfsoc_of_timer_map(void)
>  {
>         struct device_node *np;
> -       const unsigned int *intspec;
>
>         np = of_find_matching_node(NULL, timer_ids);
>         if (!np)
> @@ -233,9 +233,7 @@ static void __init sirfsoc_of_timer_map(void)
>                 panic("unable to map timer cpu registers\n");
>
>         /* Get the interrupts property */
> -       intspec = of_get_property(np, "interrupts", NULL);
> -       BUG_ON(!intspec);
> -       sirfsoc_timer_irq.irq = be32_to_cpup(intspec);
> +       sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
>
>         of_node_put(np);
>  }
> --
> 1.8.1.2
