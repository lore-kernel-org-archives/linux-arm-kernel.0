From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 15:02:07 +0000
Subject: [PATCH v3 1/7] serial: pxa: add OF support
In-Reply-To: <1331001730-13429-1-git-send-email-haojian.zhuang@marvell.com>
References: <201203051255.37311.arnd@arndb.de>
 <1331001730-13429-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201203061502.08097.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 March 2012, Haojian Zhuang wrote:

> @@ -51,7 +54,7 @@ struct uart_pxa_port {
>  	unsigned char           mcr;
>  	unsigned int            lsr_break_flag;
>  	struct clk		*clk;
> -	char			*name;
> +	char			name[PXA_NAME_LEN];
>  };

This looks better now

>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
> @@ -781,6 +784,33 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
>  };
>  #endif
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id serial_pxa_dt_ids[] = {
> +	{ .compatible = "mrvl,pxa-uart", },
> +	{ .compatible = "mrvl,mmp-uart", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
> +#endif

If you do this, you have to use of_match_ptr for referencing
serial_pxa_dt_ids or you will get a link error when CONFIG_OF is
disabled.

> @@ -850,6 +876,7 @@ static int serial_pxa_remove(struct platform_device *dev)
>  	platform_set_drvdata(dev, NULL);
>  
>  	uart_remove_one_port(&serial_pxa_reg, &sport->port);
> +	kfree(sport->name);
>  	clk_put(sport->clk);
>  	kfree(sport);
>  

And this must be removed now that sport->name is allocated as part of sport.

	Arnd
