From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 01 May 2014 01:46:21 +0200
Subject: [PATCH 2/5] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
In-Reply-To: <E1WeP8Z-0000Uk-Uu@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8Z-0000Uk-Uu@rmk-PC.arm.linux.org.uk>
Message-ID: <2505558.z8rZrC7sx8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, April 27, 2014 02:28:55 PM Russell King wrote:
> pm_genpd_remove_device() should only be called with valid and present
> pm domain.  There are circumstances where we may end up with something
> that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> stuff.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ea91ea0e137b..9d8faecc060c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1531,7 +1531,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> -	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
> +	if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)
>  	    ||  IS_ERR_OR_NULL(dev->pm_domain)
>  	    ||  pd_to_genpd(dev->pm_domain) != genpd)
>  		return -EINVAL;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
