From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Mar 2017 13:03:48 +0100
Subject: [PATCH v1] soc: rockchip: power-domain: Fix clang warning about
 negative shift count
In-Reply-To: <20170311022153.139362-1-mka@chromium.org>
References: <20170311022153.139362-1-mka@chromium.org>
Message-ID: <1715023.AuHs9buZxh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Am Freitag, 10. M?rz 2017, 18:21:53 CET schrieb Matthias Kaehlcke:
> The following warning is generated when building with clang:
> 
> drivers/soc/rockchip/pm_domains.c:726:22: error: shift count is negative
> [-Werror,-Wshift-count-negative] [RK3399_PD_TCPD0]       = DOMAIN_RK3399(8,
> 8, -1, false),
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/rockchip/pm_domains.c:101:2: note: expanded from macro
> 'DOMAIN_RK3399' DOMAIN(pwr, status, req, req, req, wakeup)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/rockchip/pm_domains.c:88:27: note: expanded from macro 'DOMAIN'
>         .req_mask = (req >= 0) ? BIT(req) : 0,          \
>                                  ^~~~~~~~
> include/linux/bitops.h:6:24: note: expanded from macro 'BIT'
> 
> The BIT macro is evaluated with the negative value -1, even though the
> resulting value would not be assigned. To fix this we only pass values
> between 0 and 63 to BIT(). Unfortunately this means that we lose the
> benefit of the compiler checking for out of bounds errors.

I tend to disagree here. This looks more like a case of "fix your compiler".

That conditional seems perfectly valid as the BIT(req) will never be reached 
if req < 0 - your clang simply doesn't recognize the pattern somehow, while 
for example gcc does.

Catering to specific whims of specific compilers feels somehow wrong, as what 
will happen if some imaginary third compiler requires another different hack 
to be satisfied?


Heiko

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/soc/rockchip/pm_domains.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c
> b/drivers/soc/rockchip/pm_domains.c index 1c78c42416c6..6f2bb1222992 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -77,13 +77,15 @@ struct rockchip_pmu {
> 
>  #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain,
> genpd)
> 
> +#define RK_MASK(bit) ((bit >= 0) ? BIT(bit & 0x3f) : 0)
> +
>  #define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
> -{						\
> -	.pwr_mask = (pwr >= 0) ? BIT(pwr) : 0,		\
> -	.status_mask = (status >= 0) ? BIT(status) : 0,	\
> -	.req_mask = (req >= 0) ? BIT(req) : 0,		\
> -	.idle_mask = (idle >= 0) ? BIT(idle) : 0,	\
> -	.ack_mask = (ack >= 0) ? BIT(ack) : 0,		\
> +{							\
> +	.pwr_mask = RK_MASK(pwr),			\
> +	.status_mask = RK_MASK(status),			\
> +	.req_mask = RK_MASK(req),			\
> +	.idle_mask = RK_MASK(idle),			\
> +	.ack_mask = RK_MASK(ack),			\
>  	.active_wakeup = wakeup,			\
>  }
