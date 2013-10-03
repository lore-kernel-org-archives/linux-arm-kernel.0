From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 3 Oct 2013 10:50:58 -0300
Subject: [PATCH 2/2] ARM: kirkwood: remove ethernet clock gate workaround
In-Reply-To: <1380804294-13726-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1380804294-13726-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1380804294-13726-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131003135057.GB2388@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 02:44:54PM +0200, Sebastian Hesselbarth wrote:
> With a proper fix for Kirkwood ethernet IP MAC address clock gating
> issue, we can now remove the clock gating workaround that always
> enabled ethernet clocks.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-kirkwood/board-dt.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index a2974ad..a3bf0c7 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -41,7 +41,6 @@ static void __init kirkwood_legacy_clk_init(void)
>  	struct device_node *np = of_find_compatible_node(
>  		NULL, NULL, "marvell,kirkwood-gating-clock");
>  	struct of_phandle_args clkspec;
> -	struct clk *clk;
>  
>  	clkspec.np = np;
>  	clkspec.args_count = 1;
> @@ -53,19 +52,6 @@ static void __init kirkwood_legacy_clk_init(void)
>  	clkspec.args[0] = CGC_BIT_PEX1;
>  	orion_clkdev_add("1", "pcie",
>  			 of_clk_get_from_provider(&clkspec));
> -
> -	/*
> -	 * The ethernet interfaces forget the MAC address assigned by
> -	 * u-boot if the clocks are turned off. Until proper DT support
> -	 * is available we always enable them for now.
> -	 */
> -	clkspec.args[0] = CGC_BIT_GE0;
> -	clk = of_clk_get_from_provider(&clkspec);
> -	clk_prepare_enable(clk);
> -
> -	clkspec.args[0] = CGC_BIT_GE1;
> -	clk = of_clk_get_from_provider(&clkspec);
> -	clk_prepare_enable(clk);
>  }
>  
>  #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
> -- 
> 1.7.10.4
> 

Good!

And if this works, this patch effectively removes the
kirkwood_legacy_clk_init() call from this file.

I'll certainly give this a test later (not soon though).

Nice job!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
