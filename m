From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 8 Sep 2012 13:37:59 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: pm_domain: Fix power domain name
 initialization
In-Reply-To: <1346924286-9584-3-git-send-email-t.figa@samsung.com>
References: <1346924286-9584-1-git-send-email-t.figa@samsung.com>
 <1346924286-9584-3-git-send-email-t.figa@samsung.com>
Message-ID: <CAJuYYwQWEN3FiNwQdugeKRV53cA65WdW79trcmP2kqqOPbz+sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2012 15:08, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch adds initialization of name field in generic power domain
> struct.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index d1abc1a..5b7ce7e 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -98,7 +98,8 @@ static __init int exynos_pm_dt_parse_domains(void)
>                         return -ENOMEM;
>                 }
>
> -               pd->name = np->name;
> +               pd->pd.name = kstrdup(np->name, GFP_KERNEL);
> +               pd->name = pd->pd.name;

Since device tree blob is always resident, why not just use np->name
instead of copying it to a new place?

>                 pd->base = of_iomap(np, 0);
>                 pd->pd.power_off = exynos_pd_power_off;
>                 pd->pd.power_on = exynos_pd_power_on;
> --
> 1.7.12
>
