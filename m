From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 16 Jul 2012 15:45:14 +0530
Subject: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add recursive
 usecount tracking
In-Reply-To: <1342189185-5306-3-git-send-email-t-kristo@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-3-git-send-email-t-kristo@ti.com>
Message-ID: <5003E9B2.8060504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain level and autoidle flag for clocks that
> are hardware controlled and should be skipped in usecount
> calculations.
>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>

Reviewed by: Rajendra Nayak <rnayak@ti.com>

> ---
>   arch/arm/mach-omap2/clkt_iclk.c         |   21 +++++++++++
>   arch/arm/mach-omap2/clockdomain.c       |   59 +++++++++++++++++++++++++++++-
>   arch/arm/mach-omap2/clockdomain.h       |    2 +
>   arch/arm/mach-omap2/dpll3xxx.c          |   19 ++++++++++
>   arch/arm/mach-omap2/powerdomain.c       |   35 ++++++++++++++++++
>   arch/arm/mach-omap2/powerdomain.h       |    5 +++
>   arch/arm/plat-omap/clock.c              |    6 +++
>   arch/arm/plat-omap/include/plat/clock.h |    2 +
>   8 files changed, 147 insertions(+), 2 deletions(-)
>

>
>   	list_add(&clk->node,&clocks);
> +	/*
> +	 * If clock has no ops, it is handled by hardware and thus will
> +	 * idle automatically
> +	 */
> +	if (clk->ops ==&clkops_null)
> +		clk->autoidle = true;

I was a little skeptical about this when I first saw it. But I am
sure you would have thought through :)
