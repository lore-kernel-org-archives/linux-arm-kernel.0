From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 11:00:41 +0200
Subject: [PATCH 2/3] mtd: hisilicon: add a new nand controller driver for
 hisilicon hip04 Soc
In-Reply-To: <1404115409-20200-3-git-send-email-wangzhou.bry@gmail.com>
References: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
 <1404115409-20200-3-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <6920327.DpBe6vKVPa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Overall a very nice driver. I didn't find any real bugs, but a few things
that could be changed for readability and micro-optimizations:

On Monday 30 June 2014 16:03:28 Zhou Wang wrote:

> +#define hinfc_read(_host, _reg)	readl(_host->iobase + (_reg))
> +#define hinfc_write(_host, _value, _reg)\
> +	writel((_value), _host->iobase + (_reg))

I'd recommend making these inline functions rather than macros.

> +struct hinfc_host {
> +	struct nand_chip	*chip;
> +	struct mtd_info		*mtd;

I notice that you allocate the nand_chip and mtd_info together
with the hinfc_host and then assign these pointers. A preferred
method is normally to just embed the structures in this case:

struct hinfc_host {
	struct nand_chip	chip;
	struct mtd_info		mtd;

so you avoid the pointer overhead, and can go back from these
two structures to the hinfc_host using container_of().

> +	struct device		*dev;
> +	void __iomem		*iobase;
> +	struct completion       cmd_complete;
> +	unsigned int		offset;
> +	unsigned int		command;
> +	int			chipselect;
> +	unsigned int		addr_cycle;
> +	unsigned int		addr_value[2];
> +	unsigned int		cache_addr_value[2];
> +	char			*buffer;
> +	dma_addr_t		dma_buffer;
> +	dma_addr_t		dma_oob;
> +	int			version;
> +	unsigned int            ecc_bits;
> +	unsigned int            irq_status; /* interrupt status */
> +
> +	int (*send_cmd_pageprog)(struct hinfc_host *host);
> +	int (*send_cmd_status)(struct hinfc_host *host);
> +	int (*send_cmd_readstart)(struct hinfc_host *host);
> +	int (*send_cmd_erase)(struct hinfc_host *host);
> +	int (*send_cmd_readid)(struct hinfc_host *host);
> +	int (*send_cmd_reset)(struct hinfc_host *host, int chipselect);
> +};

Why do you need function pointers here? The current version of the
driver you posted always assigns these to the same functions, so
it would be more efficient to just call those directly.

If you plan to add another variant later that uses a different set
of functions here, you can add the function pointers then, in a
separate patch. Also, a common style element is to have a separate
constant structure with the function pointers:

const struct hinfc_host_ops ops = {
	.send_cmd_pageprog = hisi_nfc_send_cmd_pageprog,
	...
};

if you actually end up needing function pointers. That simplifies
the code a bit and is slightly more robust to attacks overwriting
the function pointers.

> +
> +void wait_controller_finished(struct hinfc_host *host)
> +{
> +	unsigned long timeout = jiffies + HINFC504_NFC_TIMEOUT;
> +	int val;
> +
> +	while (time_before(jiffies, timeout)) {
> +		val = hinfc_read(host, HINFC504_STATUS);
> +		if (host->command == NAND_CMD_ERASE2) {
> +			/* nfc is ready */
> +			while (!(val & HINFC504_READY))	{
> +				usleep_range(500, 1000);
> +				val = hinfc_read(host, HINFC504_STATUS);
> +			}
> +			return;
> +		} else {
> +			if (val & HINFC504_READY)
> +				return;
> +		}
> +	}
> +
> +	/* wait cmd timeout */
> +	dev_err(host->dev, "Wait NAND controller exec cmd timeout.\n");
> +}

Since the timeout is much bigger than the wait time here, I guess you
can use a wider range for the usleep_range(), e.g.

	usleep_range(500, 50000);

which is nicer to other tasks. You will normally be woken up much earlier.

	Arnd
