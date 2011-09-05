From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 05 Sep 2011 14:11:12 +0400
Subject: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with
	graceful exit
In-Reply-To: <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4E64A040.4000801@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-09-2011 17:54, Santosh Shilimkar wrote:

> OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
> failure scenarios.

> Use WARN_ON() instead and allow graceful function exits.

> This was suggsted by Kevin Hilman<khilman@ti.com>  during
> OMAP4 PM code review.

> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap4-common.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 4791370..4904025 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -121,7 +121,8 @@ static int __init omap_l2_cache_init(void)
>
>   	/* Static mapping, never released */
>   	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> -	BUG_ON(!l2cache_base);
> +	if (WARN_ON(!l2cache_base))
> +		return -ENODEV;

    Rather ENOMEM...

WBR, Sergei
