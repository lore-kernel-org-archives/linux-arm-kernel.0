From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 May 2012 19:51:14 +0100
Subject: [PATCH] ARM: EXYNOS: PD: Fix duplicate variable
In-Reply-To: <1336567828-9967-1-git-send-email-sangwook.lee@linaro.org>
References: <1336567828-9967-1-git-send-email-sangwook.lee@linaro.org>
Message-ID: <20120513185114.GB13947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 01:50:28PM +0100, Sangwook Lee wrote:
> struct generic_pm_domain already has a field for name. Use that field
> instead of creating another field in struct exynos_pm_domain

Argh.  No.

> @@ -99,7 +98,7 @@ static __init int exynos_pm_dt_parse_domains(void)
>  
>  		if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
>  			pd->is_off = true;
> -		pd->name = np->name;
> +		pd->pd.name = (char *)np->name;

Why this cast?  Why can't pd->pd.name be correctly typed in the first place?

I assume this is because np->name is const.  Never EVER cast away const.
It's wrong to do so.
