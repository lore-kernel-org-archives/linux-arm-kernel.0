From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:58:05 +0100
Subject: [PATCH 06/10] ux500: added snowball-netev with latest fixes
In-Reply-To: <1299884892-6766-7-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-7-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121058.05897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:08 mathieu.poirier at linaro.org wrote:
> +int sbnet_init(void)
> +{
> +       volatile u32 *ptr = ioremap(0x80000000, 0x10000);

I suppose you mean "u32 __iomem *" here, not "volatile u32 *ptr".

> +       if (!machine_is_snowball()) {
> +               printk("no netdev: no snowball\n");
> +               return 0;
> +       }
> +       printk("init netdev: is snowball\n");

And pr_debug() instead of printk(), or just remove the
output entirely.

> +       /*
> +        * Horribly, fix all the configuration by hand
> +        */
> +       /* Turn on the FSMC device */
> +       *(ptr + 0xf000 / 4) = 1;
> +       *(ptr + 0xf008 / 4) = 1;
> +
> +       /* Configure the FSMC device */
> +       *(ptr + 0x0000 / 4) = 0x0000305b;
> +       *(ptr + 0x0004 / 4) = 0x01010110;
> +
> +       /* Fix some gpio bits */
> +       *(ptr + 0xe120 / 4) &= ~0x7f8;
> +       *(ptr + 0xe124 / 4) |=  0x7f8;

These need to be writel(), but it would really be
better to pass the configuration in the platform data
and let the driver do it, or do it all in the
firmware.

> +       iounmap(ptr);
> +
> +       return platform_device_register(&sbnet_dev);
> +}

Better use platform_device_register_simple() instead of
the static device.

	Arnd
