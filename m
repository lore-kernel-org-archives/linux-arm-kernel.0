From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 12 Jan 2014 12:47:17 +0100
Subject: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
In-Reply-To: <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140112114717.GA31318@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2014-01-11 20:42:43, Tomasz Figa wrote:
> This patch removes name field from private s3c64xx_pm_domain struct and
> moves domain name to dedicated field of generic_pm_domain struct.
> 
> When at it, beautify the names a bit, since they are used by genpd core
> as message prefixes.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/pm.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> index 8cdb824..5238d66 100644
> --- a/arch/arm/mach-s3c64xx/pm.c
> +++ b/arch/arm/mach-s3c64xx/pm.c
> @@ -35,7 +35,6 @@
>  #include "regs-syscon-power.h"
>  
>  struct s3c64xx_pm_domain {
> -	char *const name;
>  	u32 ena;
>  	u32 pwr_stat;
>  	struct generic_pm_domain pd;
> @@ -76,7 +75,7 @@ static int s3c64xx_pd_on(struct generic_pm_domain *domain)
>  		} while (retry--);
>  
>  		if (!retry) {
> -			pr_err("Failed to start domain %s\n", pd->name);
> +			pr_err("Failed to start domain %s\n", pd->pd.name);
>  			return -EBUSY;
>  		}


So you changed text "failed to start domain I" to "failed to start
domain domain_i". Not sure that's an improvement...?

Could we get some more descriptive names for the domains?



>  static struct s3c64xx_pm_domain s3c64xx_pm_i = {
> -	.name = "I",
>  	.ena = S3C64XX_NORMALCFG_DOMAIN_I_ON,
>  	.pwr_stat = S3C64XX_BLKPWRSTAT_I,
>  	.pd = {
> +		.name = "domain_i",
>  		.power_off = s3c64xx_pd_off,
>  		.power_on = s3c64xx_pd_on,
>  	},
>  };

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
