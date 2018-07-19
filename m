From: tpiepho@impinj.com (Trent Piepho)
Date: Thu, 19 Jul 2018 19:45:43 +0000
Subject: [PATCH 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
 <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1532029542.2283.157.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-19 at 15:51 +0900, Keiji Hayashibara wrote:
> 
> +config SPI_UNIPHIER
> +	tristate "Socionext UniPhier SPI Controller"
> +	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
> +	help
> +	  This driver supports the SPI controller on Socionext
> +	  UniPhier SoCs.

Perhaps add the bit that this is for the SCSSI and not MCSSI here?

> 
> +
> +#define BYTES_PER_WORD(x)			\
> +({						\
> +	int __x;				\
> +	__x = (x <= 8)  ? 1 :			\
> +	      (x <= 16) ? 2 : 4;		\
> +	__x;					\
> +})

Or:

static inline bytes_per_word(unsigned int bits) {
   return bits <= 8 ? 1 : (bits <= 16 ? 2 : 4);
}



> +
> +static inline void uniphier_spi_irq_enable(struct spi_device *spi, u32 mask)
> +{
> +	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	val = readl(priv->base + SSI_IE);
> +	val |= mask;
> +	writel(val, priv->base + SSI_IE);
> +}
> +
> +static inline void uniphier_spi_irq_disable(struct spi_device *spi, u32 mask)
> +{
> +	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	val = readl(priv->base + SSI_IE);
> +	val &= ~mask;
> +	writel(val, priv->base + SSI_IE);
> +}
> +
> +static void uniphier_spi_set_transfer_size(struct spi_device *spi, int size)
> +{
> +	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	val = readl(priv->base + SSI_TXWDS);
> +	val &= ~(SSI_TXWDS_WDLEN_MASK | SSI_TXWDS_DTLEN_MASK);
> +	val |= FIELD_PREP(SSI_TXWDS_WDLEN_MASK, size);
> +	val |= FIELD_PREP(SSI_TXWDS_DTLEN_MASK, size);
> +	writel(val, priv->base + SSI_TXWDS);
> +
> +	val = readl(priv->base + SSI_RXWDS);
> +	val &= ~SSI_RXWDS_DTLEN_MASK;
> +	val |= FIELD_PREP(SSI_RXWDS_DTLEN_MASK, size);
> +	writel(val, priv->base + SSI_RXWDS);
> +}
> +
> +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned int speed)
> +{
> +	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +	u32 val, ckrat;
> +
> +	/*
> +	 * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> +	 * round up as we look for equal or less speed
> +	 */
> +	ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> +	ckrat = roundup(ckrat, 2);
> +
> +	/* check if requested speed is too small */
> +	if (ckrat > SSI_MAX_CLK_DIVIDER)
> +		return -EINVAL;
> +
> +	if (ckrat < SSI_MIN_CLK_DIVIDER)
> +		ckrat = SSI_MIN_CLK_DIVIDER;
> +
> +	val = readl(priv->base + SSI_CKS);
> +	val &= ~SSI_CKS_CKRAT_MASK;
> +	val |= ckrat & SSI_CKS_CKRAT_MASK;
> +	writel(val, priv->base + SSI_CKS);
> +
> +	return 0;
> +}
> +
> +static int uniphier_spi_setup_transfer(struct spi_device *spi,
> +				       struct spi_transfer *t)
> +{
> +	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +	u32 val;
> +	int ret;
> +
> +	priv->error = 0;
> +	priv->tx_buf = t->tx_buf;
> +	priv->rx_buf = t->rx_buf;
> +	priv->tx_bytes = priv->rx_bytes = t->len;
> +
> +	if (priv->bits_per_word != t->bits_per_word) {
> +		uniphier_spi_set_transfer_size(spi, t->bits_per_word);
> +		priv->bits_per_word = t->bits_per_word;
> +	}
> +
> +	if (priv->speed_hz != t->speed_hz) {
> +		ret = uniphier_spi_set_baudrate(spi, t->speed_hz);
> +		if (ret)
> +			return ret;
> +		priv->speed_hz = t->speed_hz;
> +	}
> +
> +	/* reset FIFOs */
> +	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
> +	writel(val, priv->base + SSI_FC);
> +
> +	return 0;
> +}
> +
> +static void uniphier_spi_send(struct uniphier_spi_priv *priv)
> +{
> +	int i, loop;
> +	u32 val = 0;
> +
> +	loop = BYTES_PER_WORD(priv->bits_per_word);
> +	if (priv->tx_bytes < loop)
> +		loop = priv->tx_bytes;
> +
> +	priv->tx_bytes -= loop;
> +
> +	if (priv->tx_buf)
> +		for (i = 0; i < loop; i++) {
> +			val |= (*(const u8 *)priv->tx_buf)
> +						<< (BITS_PER_BYTE * i);

priv->tx_buf is already a const u8*, no need to cast it.  Also in recv,
no need to cast the pointer.  It'll just hide errors if someone changes
the type of the field.

> +			(const u8 *)priv->tx_buf++;
> +		}
> +
> +	writel(val, priv->base + SSI_TXDR);
> +}

The loop to read the data will likely be somewhat slow.  It might be
faster to use:

    val = get_unaligned_le32(priv->tx_buf);

To support different sizes a switch can be used:

    switch (MIN(BYTES_PER_WORD(priv->bits_per_word), priv->tx_bytes)) {
    case 1:
         val = *priv->tx_buf; break;
    case 2:
         val = get_unaligned_le16(priv->tx_buf); break;
    case 4:
         val = get_unaligned_le32(priv->tx_buf); break;
    }

However, I don't think either the existing code or this code is
correctly handling word sizes that are not an even number of bytes.  I
think it needs to left shift the data, but of course it also depends on
what the uniphier hardware expected in the TXDR register.


> +static void uniphier_spi_recv(struct uniphier_spi_priv *priv)
> +{
> +	int i, loop;
> +	u32 val;
> +
> +	loop = BYTES_PER_WORD(priv->bits_per_word);
> +	if (priv->rx_bytes < loop)
> +		loop = priv->rx_bytes;
> +
> +	priv->rx_bytes -= loop;
> +
> +	val = readl(priv->base + SSI_RXDR);
> +
> +	if (priv->rx_buf)
> +		for (i = 0; i < loop; i++) {
> +			val = val >> (BITS_PER_BYTE * i);
> +			*(u8 *)priv->rx_buf = val & GENMASK(7, 0);
> +			(u8 *)priv->rx_buf++;
> +		}



> +}+static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
> +{
> +	unsigned int tx_count;
> +	int bytes_per_word = BYTES_PER_WORD(priv->bits_per_word);
> +	u32 val;
> +
> +	tx_count = priv->tx_bytes / bytes_per_word;
> +	if (tx_count > SSI_FIFO_DEPTH)
> +		tx_count = SSI_FIFO_DEPTH;
> +
> +	/* set fifo threthold */
> +	val = readl(priv->base + SSI_FC);
> +	val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
> +	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, tx_count);
> +	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, tx_count);
> +	writel(val, priv->base + SSI_FC);
> +
> +	while (tx_count--)
> +		uniphier_spi_send(priv);
> +}

If you have 24 bits per word, 3 words, that's 9 bytes. 
BYTES_PER_WORD(24) is 4.  tx_count = 9/4 = 2.  Looks like your tx_count
rounds incorrectly, as it will only send 8 of the 9 bytes.

> +static int uniphier_spi_setup(struct spi_device *spi)
> +{

> +
> +	writel(val1, priv->base + SSI_CKS);
> +	writel(val2, priv->base + SSI_FPS);
> +
> +	val1 = 0;
> +	if (spi->mode & SPI_LSB_FIRST)
> +		val1 |= FIELD_PREP(SSI_TXWDS_TDTF_MASK, 1);
> +	writel(val1, priv->base + SSI_TXWDS);
> +	writel(val1, priv->base + SSI_RXWDS);

Did you see this in the spi docs?

        Unless each SPI slave has its own configuration registers, don't
        change them right away ... otherwise drivers could corrupt I/O
        that's in progress for other SPI devices.

                ** BUG ALERT:  for some reason the first version of
                ** many spi_master drivers seems to get this wrong.
                ** When you code setup(), ASSUME that the controller
                ** is actively processing transfers for another device.

You have one chipselect, so maybe this is ok.  Until you want to
support more than one chipselect.

With gpio lines as chip selects, there's really no reason any spi
master can't support multiple slaves.
