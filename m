From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Apr 2013 15:56:05 +0530
Subject: [PATCH v2 1/3] media: davinci: vpss: enable vpss clocks
In-Reply-To: <1364903044-13752-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1364903044-13752-1-git-send-email-prabhakar.csengg@gmail.com>
 <1364903044-13752-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <51629B3D.4080905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2013 5:14 PM, Prabhakar lad wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> By default the VPSS clocks were enabled in capture driver
> for davinci family which creates duplicates for dm355/dm365/dm644x.
> This patch adds support to enable the VPSS clocks in VPSS driver,
> which avoids duplication of code and also adding clock aliases.
> 
> This patch uses PM runtime API to enable/disable instead common clock
> framework. con_ids for master and slave clocks of vpss is added in pm_domain

Common clock framework in not (yet) used on DaVinci, so this is misleading.

> diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
> index c90250e..445b10b 100644
> --- a/arch/arm/mach-davinci/pm_domain.c
> +++ b/arch/arm/mach-davinci/pm_domain.c
> @@ -53,7 +53,7 @@ static struct dev_pm_domain davinci_pm_domain = {
>  
>  static struct pm_clk_notifier_block platform_bus_notifier = {
>  	.pm_domain = &davinci_pm_domain,
> -	.con_ids = { "fck", NULL, },
> +	.con_ids = { "fck", "master", "slave", NULL, },

NULL is sentinel so you can drop the ',' after that. Apart from that,
for the mach-davinci parts:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
