From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 17:27:51 +0200
Subject: [PATCH V2 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1473255233-154297-3-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <2175767.JxAh0qjf0L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 9:33:51 PM CEST Zhichang Yuan wrote:

> +
> +struct hisilpc_dev;
> +
> +/* This flag is specific to differentiate earlycon operations and the others */
> +#define FG_EARLYCON_LPC		(0x01U << 0)
> +/*
> + * this bit set means each IO operation will target to different port address;
> + * 0 means repeatly IO operations will be sticked on the same port, such as BT;
> + */
> +#define FG_INCRADDR_LPC		(0x01U << 1)

Better express the constants as

#define FG_EARLYCON_LPC	0x0001
#define FG_INCRADDR_LPC	0x0002

> +struct lpc_io_ops {
> +	unsigned int periosz;
> +	int (*lpc_iord)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
> +				unsigned long ptaddr, unsigned char *buf,
> +				unsigned long dlen);
> +	int (*lpc_iowr)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
> +				unsigned long ptaddr,
> +				const unsigned char *buf,
> +				unsigned long dlen);
> +};

The operations are not needed unless we also put the earlycon support
in, so maybe leave them out from the first patch and only add them
later (or drop the earlycon support if possible).

> +/**
> + * hisilpc_remove - the remove callback function for hisi lpc device.
> + * @pdev: the platform device corresponding to hisi lpc that is to be removed.
> + *
> + * Returns 0 on success, non-zero on fail.
> + *
> + */
> +static int hisilpc_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

It seems that it should not be possible to remove this driver,
please use builtin_platform_driver() then and remove this callback.

	Arnd
