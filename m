From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 6 Dec 2010 16:42:10 +0530
Subject: [PATCH v9 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <AANLkTinwj27dSdv9Djs9Fv6QN5vv5JY+br4xCHk=8YEu@mail.gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
	<1291231949-23835-7-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFDD7E@dbde02.ent.ti.com>
	<AANLkTinMGvRS4N2rSRp43Osnn_Df=JRAJB0iBdZLzrZ-@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247B9A907@dbde02.ent.ti.com>
	<AANLkTinwj27dSdv9Djs9Fv6QN5vv5JY+br4xCHk=8YEu@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247C46537@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 22:40:44, Victor Rodriguez wrote:

>  arch/arm/mach-davinci/board-omapl138-hawk.c |   38 ++++++++++++++++++++------
>  1 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
> b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index da51136..8fc78f2 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -157,7 +157,7 @@ static __init void omapl138_hawk_mmc_init(void)
>       if (ret < 0) {
>               pr_warning("%s: can not open GPIO %d\n",
>                       __func__, DA850_HAWK_MMCSD_CD_PIN);
> -             return;
> +             goto exp_setup_cd_fail;
>       }
>
>       ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
> @@ -165,13 +165,23 @@ static __init void omapl138_hawk_mmc_init(void)
>       if (ret < 0) {
>               pr_warning("%s: can not open GPIO %d\n",
>                       __func__, DA850_HAWK_MMCSD_WP_PIN);
> -             return;
> +             goto exp_setup_wp_fail;
>       }
>
>       ret = da8xx_register_mmcsd0(&da850_mmc_config);
> -     if (ret)
> +     if (ret) {
>               pr_warning("%s: MMC/SD0 registration failed: %d\n",
>                       __func__, ret);
> +             goto exp_setup_mmcsd_fail;
> +     }
> +             return;

This return has extra indentation.

> +
> +exp_setup_mmcsd_fail:
> +     gpio_free(DA850_HAWK_MMCSD_WP_PIN);
> +exp_setup_wp_fail:
> +     gpio_free(DA850_HAWK_MMCSD_CD_PIN);
> +exp_setup_cd_fail:
> +             return;

This one too. Other than that, it all looks good to me.

Thanks,
Sekhar
