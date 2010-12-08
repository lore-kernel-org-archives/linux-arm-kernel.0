From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 8 Dec 2010 10:50:19 +0530
Subject: [PATCH v10 4/6] davinci: MMC/SD support for Omapl138-Hawkboard
In-Reply-To: <1291760089-5818-5-git-send-email-vm.rod25@gmail.com>
References: <1291760089-5818-1-git-send-email-vm.rod25@gmail.com>
	<1291760089-5818-5-git-send-email-vm.rod25@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247C470AD@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:44:47, vm.rod25 at gmail.com wrote:

> +static __init void omapl138_hawk_mmc_init(void)
> +{
> +     int ret;
> +
> +     ret = davinci_cfg_reg_list(hawk_mmcsd0_pins);
> +     if (ret) {
> +             pr_warning("%s: MMC/SD0 mux setup failed: %d\n",
> +                     __func__, ret);
> +             return;
> +     }
> +
> +     ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
> +                     GPIOF_DIR_IN, "MMC CD");
> +     if (ret < 0) {
> +             pr_warning("%s: can not open GPIO %d\n",
> +                     __func__, DA850_HAWK_MMCSD_CD_PIN);
> +             goto mmc_setup_cd_fail;
> +     }

A goto is only used when there is some recovery
to be done. In this case, you should simply return
here. The USB patch needs the same correction.

Thanks,
Sekhar

> +
> +     ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
> +                     GPIOF_DIR_IN, "MMC WP");
> +     if (ret < 0) {
> +             pr_warning("%s: can not open GPIO %d\n",
> +                     __func__, DA850_HAWK_MMCSD_WP_PIN);
> +             goto mmc_setup_wp_fail;
> +     }
> +
> +     ret = da8xx_register_mmcsd0(&da850_mmc_config);
> +     if (ret) {
> +             pr_warning("%s: MMC/SD0 registration failed: %d\n",
> +                     __func__, ret);
> +             goto mmc_setup_mmcsd_fail;
> +     }
> +
> +mmc_setup_cd_fail:
> +     return;
> +
> +mmc_setup_mmcsd_fail:
> +     gpio_free(DA850_HAWK_MMCSD_WP_PIN);
> +mmc_setup_wp_fail:
> +     gpio_free(DA850_HAWK_MMCSD_CD_PIN);
> +}
> +
>  static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
>       .enabled_uarts = 0x7,
>  };
> @@ -127,6 +198,8 @@ static __init void omapl138_hawk_init(void)
>               pr_warning("%s: EDMA registration failed: %d\n",
>                       __func__, ret);
>
> +     omapl138_hawk_mmc_init();
> +
>       ret = da8xx_register_watchdog();
>       if (ret)
>               pr_warning("omapl138_hawk_init: "
> --
> 1.7.0.4
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>
