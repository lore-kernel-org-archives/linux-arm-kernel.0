From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 15 Oct 2010 23:09:46 +0200
Subject: [PATCH 2/2] ARM: imx: Add POWER_KEY to mx51 babbage board
In-Reply-To: <1287173908-25758-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287173908-25758-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1287173908-25758-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4CB8C31A.3000000@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 15/10/2010 22:18, Dinh.Nguyen at freescale.com a ?crit :
> +/*!
> + * Power Key interrupt handler.
> + */
> +static irqreturn_t power_key_int(int irq, void *dev_id)
> +{
> +	printk(KERN_INFO "PWR key pressed\n");
> +	return 0;
> +}
> +
> +/*!
> + * Power Key initialization.
> + */
> +static int __init mxc_init_power_key(void)
> +{
> +	/* Set power key as wakeup resource */
> +	int irq, ret;
> +
> +	/* power key */
> +	ret = gpio_request(BABBAGE_POWER_KEY, "power-key");
> +	if (ret) {
> +		printk(KERN_ERR"failed to get BABBAGE_POWER_KEY: %d\n", ret);
> +		return ret;
> +	}
> +	gpio_direction_input(BABBAGE_POWER_KEY);
> +
> +	irq = IOMUX_TO_IRQ(BABBAGE_POWER_KEY);
> +	set_irq_type(irq, IRQF_TRIGGER_RISING);
> +	ret = request_irq(irq, power_key_int, 0, "power-key", 0);
> +	if (ret)
> +		pr_info("register on-off key interrupt failed\n");
> +	else
> +		enable_irq_wake(irq);
> +	return ret;
> +}
> +late_initcall(mxc_init_power_key);
> +
instead of doing this, you could use the gpio-keys driver which will configure 
the IRQ as a wakeup source and also send keys to the input layer.

You can have an example here :
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=blob;f=arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c;h=2b48f5190830c7cbe2f11676a628c55e1531c133;hb=imx-for-2.6.37#l98

Eric
