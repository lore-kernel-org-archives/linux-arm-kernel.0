From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Oct 2010 23:15:07 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101019205251.082848683@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
Message-ID: <20101019211507.GA28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 10:42:54PM +0200, Arnaud Patard wrote:
> read board id value from the GPIO3_16/17/11
> 
>  
> +/*   PCBID2  PCBID1 PCBID0  STATE
> +	1       1      1    ER1:rev1.1
> +	1       1      0    ER2:rev1.2
> +	1       0      1    ER3:rev1.3
> +	1       0      0    ER4:rev1.4
> +*/
> +static void __init mx51_efikamx_board_id(void)
> +{
> +	int id;
> +
> +	/* things are taking time to settle */
> +	msleep(500);

Is it really necessary to delay the boot process such a long time?

> +
> +	gpio_request(EFIKAMX_PCBID0, "pcbid0");
> +	gpio_direction_input(EFIKAMX_PCBID0);
> +	gpio_request(EFIKAMX_PCBID1, "pcbid1");
> +	gpio_direction_input(EFIKAMX_PCBID1);
> +	gpio_request(EFIKAMX_PCBID2, "pcbid2");
> +	gpio_direction_input(EFIKAMX_PCBID2);
> +
> +	id = gpio_get_value(EFIKAMX_PCBID0);
> +	id |= gpio_get_value(EFIKAMX_PCBID1) << 1;
> +	id |= gpio_get_value(EFIKAMX_PCBID2) << 2;
> +
> +	switch (id) {
> +	case 7:
> +		system_rev = 0x11;
> +		break;
> +	case 6:
> +		system_rev = 0x12;
> +		break;
> +	case 5:
> +		system_rev = 0x13;
> +		break;
> +	case 4:
> +		system_rev = 0x14;
> +		break;
> +	default:
> +		system_rev = 0x10;
> +		break;
> +	}
> +
> +	if	((system_rev == 0x10)

Please replace the tab after 'if' with a space

> +		|| (system_rev == 0x12)
> +		|| (system_rev == 0x14)) {
> +		printk(KERN_WARNING
> +			"EfikaMX: Unsupported board revision 1.%u!\n",
> +			system_rev & 0xf);
> +	}

I know nothing about the versioning scheme, but what about 1.1? Is it
supported?

> +}
> +
>  static void __init mxc_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
>  					ARRAY_SIZE(mx51efikamx_pads));
> +	mx51_efikamx_board_id();
>  	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
>  	mxc_init_imx_uart();
>  }
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
