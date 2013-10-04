From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 04 Oct 2013 12:14:42 +0200
Subject: [PATCH v3] ARM: kirkwood: remove ethernet clock gate workaround
In-Reply-To: <1380881630-24439-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1380826568-18587-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1380881630-24439-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <524E9512.8020809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 12:13 PM, Sebastian Hesselbarth wrote:
> With a proper fix for Kirkwood ethernet IP MAC address clock gating
> issue, we can now remove the clock gating workaround that always
> enabled ethernet clocks.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Damn, wrong patch.

> ---
> Changelog:
> v2->v3:
> - make use of new public clk_is_enabled, adds dependency to [1]
> - add warning about gated clock && missing MAC property
>    (Suggested by Jason Gunthorpe)
> v1->v2:
> - check for gated clock before accessing eth registers
>    (Suggested by Andrew Lunn)
>
> [1] http://www.spinics.net/lists/arm-kernel/msg277392.html
>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   arch/arm/mach-kirkwood/board-dt.c |   14 --------------
>   1 file changed, 14 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 28e952b..6925de8 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -41,7 +41,6 @@ static void __init kirkwood_legacy_clk_init(void)
>   	struct device_node *np = of_find_compatible_node(
>   		NULL, NULL, "marvell,kirkwood-gating-clock");
>   	struct of_phandle_args clkspec;
> -	struct clk *clk;
>
>   	clkspec.np = np;
>   	clkspec.args_count = 1;
> @@ -53,19 +52,6 @@ static void __init kirkwood_legacy_clk_init(void)
>   	clkspec.args[0] = CGC_BIT_PEX1;
>   	orion_clkdev_add("1", "pcie",
>   			 of_clk_get_from_provider(&clkspec));
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
>   }
>
>   #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
>
