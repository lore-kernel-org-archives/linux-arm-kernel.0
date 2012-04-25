From: tony@atomide.com (Tony Lindgren)
Date: Wed, 25 Apr 2012 09:47:26 -0700
Subject: [TMP] OMAP3EVM: Test gpmc nand & smsc911x
In-Reply-To: <bb95fec60401f7cf6ac77200a12baf3fc83852f5.1333640054.git.afzal@ti.com>
References: <cover.1333640054.git.afzal@ti.com>
 <bb95fec60401f7cf6ac77200a12baf3fc83852f5.1333640054.git.afzal@ti.com>
Message-ID: <20120425164726.GU3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120405 09:08]:
> @@ -114,6 +147,8 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
>  
>  static inline void __init omap3evm_init_smsc911x(void)
>  {
> +	struct gpmc_device_pdata *gpmc_smsc911x_info;
> +
>  	/* Configure ethernet controller reset gpio */
>  	if (cpu_is_omap3430()) {
>  		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
> @@ -122,7 +157,11 @@ static inline void __init omap3evm_init_smsc911x(void)
>  			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
>  	}
>  
> -	gpmc_smsc911x_init(&smsc911x_cfg);
> +	gpmc_smsc911x_info = gpmc_smsc911x_init(&smsc911x_cfg);
> +	if (gpmc_smsc911x_info)
> +		*gpmc_data_cur++ = gpmc_smsc911x_info;
> +	else
> +		pr_err("error: unable to initilaize gpmc smsc911x\n");
>  }
>  
>  #else

Obviously we can't merge any of this if until all the board-*.c files
are changed and tested.

Can you maybe still keep the old interfaces in addition to the new ones
so we can do the conversion one board-*.c file at a time while keeping
things working?

Regards,

Tony
