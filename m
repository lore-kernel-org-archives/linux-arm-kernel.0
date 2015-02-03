From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Feb 2015 09:09:21 +0100
Subject: [PATCH] ARM: EXYNOS: Handle of of_iomap() failure
In-Reply-To: <054001d03f60$58535150$08f9f3f0$@kernel.org>
References: <1421077065-30175-1-git-send-email-k.kozlowski@samsung.com>
 <054001d03f60$58535150$08f9f3f0$@kernel.org>
Message-ID: <1422950961.10086.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-02-03 at 12:20 +0900, Kukjin Kim wrote:
> Krzysztof Kozlowski wrote:
> > 
> > Prevent possible NULL pointer dereference if of_iomap() fails. Handle
> > the error by skipping such power domain.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/mach-exynos/pm_domains.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> > index 20f267121b3e..fd7640a6b503 100644
> > --- a/arch/arm/mach-exynos/pm_domains.c
> > +++ b/arch/arm/mach-exynos/pm_domains.c
> > @@ -128,6 +128,13 @@ static __init int exynos4_pm_init_power_domain(void)
> >  		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
> >  		pd->name = pd->pd.name;
> >  		pd->base = of_iomap(np, 0);
> > +		if (!pd->base) {
> > +			dev_warn(&pdev->dev, "Failed to map memory\n");
> > +			kfree(pd);
> > +			of_node_put(np);
> > +			continue;
> > +		}
> > +
> >  		pd->pd.power_off = exynos_pd_power_off;
> >  		pd->pd.power_on = exynos_pd_power_on;
> > 
> > --
> 
> Looks good and applied.

Thanks!

> BTW if we need more error handling like this, how about
> error handling for failing of of_find_device_by_node() something like following?

I'll take a look into this.

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 20f2671..234f967 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -116,6 +116,10 @@ static __init int exynos4_pm_init_power_domain(void)
>  		struct device *dev;
> 
>  		pdev = of_find_device_by_node(np);
> +		if (!pdev) {
> +			/* error handling */
> +		}
> +
>  		dev = &pdev->dev;
> 
>  		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> 
> I mean I'm not sure how many error/exception handling is required...
> 
> Note you can see your patch in Samsung tree tonight in my time.
> 
> Thanks, Kukjin
