From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 6 Oct 2009 23:08:02 +0200
Subject: [PATCH 7/8 v2] mfd: add U8500 STw4500 SPI device support
In-Reply-To: <1253735370.21542.179.camel@vinay-desktop>
References: <1253735353.21542.176.camel@vinay-desktop>
	<1253735370.21542.179.camel@vinay-desktop>
Message-ID: <20091006210802.GA26904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + * SPI protocol &  before it writes it packs the data
> + * in the below 24 bit frame format
> + *
> + *	 *|------------------------------------|
> + *	 *| 23|22...18|17.......10|9|8|7......0|
> + *	 *| r/w  bank       adr          data  |
> + *	 * ------------------------------------
> + *
> + * This function shouldn't be called from interrupt
> + * context
> + */
> +int stw4500_write(struct stw4500 *stw4500, unsigned char block,
> +		unsigned long addr, unsigned char data)
> +{
> +	struct spi_transfer xfer;
> +	struct spi_message	msg;
> +	int err;
> +	unsigned long spi_data =
> +		block << 18 | addr << 10 | data;
> +
> +	stw4500->tx_buf[0] = spi_data;
> +	stw4500->rx_buf[0] = 0;
> +
> +	xfer.tx_buf	= stw4500->tx_buf;
> +	xfer.rx_buf 	= NULL;
> +	xfer.len	= sizeof(unsigned long);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	mutex_lock(&stw4500->lock);
you put the lock here but you update the buffer upper
so how this is supposed to protect its content?
> +	err = spi_sync(stw4500->spi, &msg);
> +	mutex_unlock(&stw4500->lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(stw4500_write);
> +
> +int stw4500_read(struct stw4500 *stw4500, unsigned char block,
> +		unsigned long addr)
> +{
ditto here

Best Regards,
J.
