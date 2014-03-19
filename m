From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Mar 2014 18:02:51 +0100
Subject: [PATCH 2/2] v1 ARM: sun4i: spi: Allow Tx transfers larger than
 FIFO size
In-Reply-To: <1521319.la1khlz7Zz@nukelap.gtech>
References: <1521319.la1khlz7Zz@nukelap.gtech>
Message-ID: <20140319170251.GK27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 05:04:36PM -0500, Alexandru Gagniuc wrote:
> Enable and use the Tx FIFO 3/4 interrupt to replenish the FIFO on
> large SPI bursts. This requires more care in when the interrupt is
> left enabled, as this interrupt will continually trigger when the FIFO
> is less than 1/4 full, even though we acknowledge it.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 09d4b54..174736c 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -48,6 +48,7 @@
>  
>  #define SUN4I_INT_CTL_REG		0x0c
>  #define SUN4I_INT_CTL_RF_F34			BIT(4)
> +#define SUN4I_INT_CTL_TF_E34			BIT(12)
>  #define SUN4I_INT_CTL_TC			BIT(16)
>  
>  #define SUN4I_INT_STA_REG		0x10
> @@ -100,6 +101,21 @@ static inline void sun4i_spi_write(struct sun4i_spi 
> *sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
>  
> +static inline int sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)

return an u32 here

> +{
> +	u32 reg;
> +	reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
> +	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
> +	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
> +}
> +
> +static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u32 
> intm)

Please rename the variable "mask" here, and add a matching
enable_interrupt function for consistency.

> +{
> +	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
> +	reg &= ~intm;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
> +}
> +
>  static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
>  {
>  	u32 reg, cnt;
> @@ -181,10 +197,6 @@ static int sun4i_spi_transfer_one(struct spi_master 
> *master,
>  	if (tfr->len > SUN4I_MAX_XFER_SIZE)
>  		return -EINVAL;
>  
> -	/* We only support read transfers larger than the FIFO */
> -	if ((tfr->len > SUN4I_FIFO_DEPTH) && tfr->tx_buf)
> -		return -EINVAL;
> -
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf = tfr->tx_buf;
>  	sspi->rx_buf = tfr->rx_buf;
> @@ -280,8 +292,11 @@ static int sun4i_spi_transfer_one(struct spi_master 
> *master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
>  
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> -						 SUN4I_INT_CTL_RF_F34);
> +	reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
> +	/* Only enable Tx FIFO interrupt if we really need it */
> +	if (tx_len > SUN4I_FIFO_DEPTH)
> +		reg |= SUN4I_INT_CTL_TF_E34;
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);

I'd be much dumber than that. Why don't you just enable both
interrupts all the time if we need larger transfers ?


>  	/* Start the transfer */
>  	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -306,6 +321,7 @@ static irqreturn_t sun4i_spi_handler(int irq, void 
> *dev_id)
>  {
>  	struct sun4i_spi *sspi = dev_id;
>  	u32 status = sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
> +	u32 cnt;
>  
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
> @@ -323,6 +339,22 @@ static irqreturn_t sun4i_spi_handler(int irq, void 
> *dev_id)
>  		return IRQ_HANDLED;
>  	}
>  
> +	/* Transmit FIFO 3/4 empty */
> +	if (status & SUN4I_INT_CTL_TF_E34) {
> +		/* See how much data can fit */
> +		cnt = SUN4I_FIFO_DEPTH - sun4i_spi_get_tx_fifo_count(sspi);
> +		sun4i_spi_fill_fifo(sspi, cnt);

Making sure that you don't write to much data should be part of
_fill_fifo

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/0f1aab98/attachment-0001.sig>
