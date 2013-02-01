From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 16:59:44 +0530
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359651943-21752-4-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
Message-ID: <510BA728.4060300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Lorenzo,

On Thursday 31 January 2013 10:35 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> mach-socfpga is another platform that needs to use
> v7_invalidate_l1 to bringup additional cores. There was a comment that
> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Tested-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> ---
>   arch/arm/mach-imx/headsmp.S      |   47 -------------------------------------
>   arch/arm/mach-shmobile/headsmp.S |   48 --------------------------------------
>   arch/arm/mach-tegra/headsmp.S    |   43 ----------------------------------
>   arch/arm/mm/cache-v7.S           |   46 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 46 insertions(+), 138 deletions(-)
>
[..]

> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 7539ec2..15451ee 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -19,6 +19,52 @@
>   #include "proc-macros.S"
>
>   /*
> + * The secondary kernel init calls v7_flush_dcache_all before it enables
> + * the L1; however, the L1 comes out of reset in an undefined state, so
> + * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
> + * of cache lines with uninitialized data and uninitialized tags to get
> + * written out to memory, which does really unpleasant things to the main
> + * processor.  We fix this by performing an invalidate, rather than a
> + * clean + invalidate, before jumping into the kernel.
> + *
> + * This function is cloned from arch/arm/mach-tegra/headsmp.S, and needs
> + * to be called for both secondary cores startup and primary core resume
> + * procedures.
> + */
> +ENTRY(v7_invalidate_l1)
Now since we are moving the code under common place, probably we should
update this a function a bit so that it invalidates the CPU cache till
line of unification. Just to be consistent with other flush API.

Lorenzo,
Does that make sense ?

Regards,
Santosh
