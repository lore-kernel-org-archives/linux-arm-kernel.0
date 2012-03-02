From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 02 Mar 2012 01:09:41 -0600
Subject: [PATCH 2/4] ARM: kirkwood: fdt: absorb kirkwood_init()
In-Reply-To: <9d9a87361c05b8b85e1ee2cdabb46a365c7abca8.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <9d9a87361c05b8b85e1ee2cdabb46a365c7abca8.1330625877.git.jason@lakedaemon.net>
Message-ID: <20120302070941.851923E2D7B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  1 Mar 2012 18:20:53 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> We need to absorb kirkwood_init() into kirkwood_dt_init() so that as we
> convert drivers, we can remove the platform call, eg
> kirkwood_rtc_init().  This maintains compatibility with non-fdt
> configurations because they still call kirkwood_init() in common.c.
> 
> As drivers are converted, we will reinstate the 'static' qualifier in
> common.c.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/mach-kirkwood/board-dt.c |   30 +++++++++++++++++++++++++++++-
>  arch/arm/mach-kirkwood/common.c   |   12 ++++++------
>  arch/arm/mach-kirkwood/common.h   |    8 ++++++++
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 4960e63..a0cc28b 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -29,7 +29,9 @@
>  #include <linux/spi/orion_spi.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
>  #include <mach/kirkwood.h>
> +#include <mach/bridge-regs.h>
>  #include <plat/mvsdio.h>
>  #include "common.h"
>  #include "mpp.h"
> @@ -115,7 +117,33 @@ static void __init dreamplug_init(void)
>  
>  static void __init kirkwood_dt_init(void)
>  {
> -	kirkwood_init();
> +	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
> +		kirkwood_id(), kirkwood_tclk);

Nit: pr_info()

g.
