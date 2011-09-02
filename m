From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 2 Sep 2011 20:21:37 +0200
Subject: [PATCH] at91: add Atmel ISI and ov2640 support on m10/g45 board.
In-Reply-To: <1314960609-23396-1-git-send-email-josh.wu@atmel.com>
References: <1314960609-23396-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20110902182137.GL20128@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -194,6 +197,95 @@ static void __init ek_add_device_nand(void)
>  	at91_add_device_nand(&ek_nand_data);
>  }
>  
> +/*
> + *  ISI
> + */
> +#if defined(CONFIG_VIDEO_ATMEL_ISI) || defined(CONFIG_VIDEO_ATMEL_ISI_MODULE)
> +static struct isi_platform_data __initdata isi_data = {
> +	.frate		= ISI_CFG1_FRATE_CAPTURE_ALL,
> +	.has_emb_sync	= 0,
> +	.emb_crc_sync = 0,
> +	.hsync_act_low = 0,
> +	.vsync_act_low = 0,
> +	.pclk_act_falling = 0,
> +	/* to use codec and preview path simultaneously */
> +	.isi_full_mode = 1,
> +	.data_width_flags = ISI_DATAWIDTH_8 | ISI_DATAWIDTH_10,
> +};
> +
> +static void __init isi_set_clk(void)
> +{
> +	struct clk *pck1;
> +	struct clk *plla;
> +
> +	pck1 = clk_get(NULL, "pck1");
> +	plla = clk_get(NULL, "plla");
> +
> +	clk_set_parent(pck1, plla);
> +	clk_set_rate(pck1, 25000000);
> +	clk_enable(pck1);
you must not enable the clock always

you must enable it just when you need it

and manage the clock at the board level really so so

Best Regards,
J.
