From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 Nov 2016 15:39:34 -0800
Subject: [PATCH 2/4] spi: spi-fsl-dspi: Fix incorrect DMA setup
In-Reply-To: <20161118080403.GB1572@Sanchayan-Arch.localdomain>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
 <d83f4896d77f577ca92fd70534f6198bb3288d8a.1479384571.git.maitysanchayan@gmail.com>
 <bc8d9b808b99d3b217361df6fa8853ea@agner.ch>
 <20161118080403.GB1572@Sanchayan-Arch.localdomain>
Message-ID: <ace57f15ff4e6d1bfa9cc1957451799b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-18 00:04, maitysanchayan at gmail.com wrote:
> On 16-11-17 17:03:19, Stefan Agner wrote:
>> On 2016-11-17 04:16, Sanchayan Maity wrote:
>> > Currently dmaengine_prep_slave_single was being called with length
>> > set to the complete DMA buffer size. This resulted in unwanted bytes
>> > being transferred to the SPI register leading to clock and MOSI lines
>> > having unwanted data even after chip select got deasserted and the
>> > required bytes having been transferred.
>> >
>> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> > ---
>> >  drivers/spi/spi-fsl-dspi.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
>> > index b1ee1f5..aee8c88 100644
>> > --- a/drivers/spi/spi-fsl-dspi.c
>> > +++ b/drivers/spi/spi-fsl-dspi.c
>> > @@ -265,7 +265,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>> >
>> >  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
>> >  					dma->tx_dma_phys,
>> > -					DSPI_DMA_BUFSIZE, DMA_MEM_TO_DEV,
>> > +					dma->curr_xfer_len *
>> > +					DMA_SLAVE_BUSWIDTH_4_BYTES /
>> > +					(tx_word ? 2 : 1),
>> > +					DMA_MEM_TO_DEV,
>>
>> Hm, this is getting ridiculous, I think we convert curr_xfer_len from
>> bytes to DMA transfers in almost every use.
>>
>> Can we make it be transfer length in actual 4 byte transfers? We then
>> probably have to convert it to bytes once to subtract from
>> curr_remaining_bytes, but I think it would simplify code overall...
> 
> Will the below be acceptable fix?
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 41422cd..db7f091 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -217,15 +217,13 @@ static void dspi_rx_dma_callback(void *arg)
>         struct fsl_dspi *dspi = arg;
>         struct fsl_dspi_dma *dma = dspi->dma;
>         int rx_word;
> -       int i, len;
> +       int i;
>         u16 d;
>  
>         rx_word = is_double_byte_mode(dspi);
>  
> -       len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
> -
>         if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
> -               for (i = 0; i < len; i++) {
> +               for (i = 0; i < dma->curr_xfer_len; i++) {
>                         d = dspi->dma->rx_dma_buf[i];
>                         rx_word ? (*(u16 *)dspi->rx = d) :
>                                                 (*(u8 *)dspi->rx = d);
> @@ -242,14 +240,12 @@ static int /(struct
> fsl_dspi *dspi)
>         struct device *dev = &dspi->pdev->dev;
>         int time_left;
>         int tx_word;
> -       int i, len;
> +       int i;
>         u16 val;
>  
>         tx_word = is_double_byte_mode(dspi);
>  
> -       len = tx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
> -
> -       for (i = 0; i < len - 1; i++) {
> +       for (i = 0; i < dma->curr_xfer_len - 1; i++) {
>                 val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
>                 dspi->dma->tx_dma_buf[i] =
>                         SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
> @@ -267,7 +263,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  
>         dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
>                                         dma->tx_dma_phys,
> -                                       DSPI_DMA_BUFSIZE, DMA_MEM_TO_DEV,
> +                                       dma->curr_xfer_len *
> +                                       DMA_SLAVE_BUSWIDTH_4_BYTES,
> +                                       DMA_MEM_TO_DEV,
>                                         DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>         if (!dma->tx_desc) {
>                 dev_err(dev, "Not able to get desc for DMA xfer\n");
> @@ -283,7 +281,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  
>         dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
>                                         dma->rx_dma_phys,
> -                                       DSPI_DMA_BUFSIZE, DMA_DEV_TO_MEM,
> +                                       dma->curr_xfer_len *
> +                                       DMA_SLAVE_BUSWIDTH_4_BYTES,
> +                                       DMA_DEV_TO_MEM,
>                                         DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>         if (!dma->rx_desc) {
>                 dev_err(dev, "Not able to get desc for DMA xfer\n");
> @@ -330,17 +330,17 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>         struct device *dev = &dspi->pdev->dev;
>         int curr_remaining_bytes;
>         int bytes_per_buffer;
> -       int tx_word;
> +       int tx_word = 1;
>         int ret = 0;
>  
> -       tx_word = is_double_byte_mode(dspi);
> +       if (is_double_byte_mode(dspi))
> +               tx_word = 2;

I would try to be consistent with tx_word. In most other cases it is
used as boolean, whether this is a 2 byte word or not.

Here you change it to represent the length of a single transfer/frame.
Nothing wrong with that, just if you do such changes, also change the
name of the variable so the reader does not get miss lead from other
uses of "tx_word"...


But otherwise looks good, like this variant much better!

Maybe we should add a comment in struct fsl_dspi_dma:
/* Length of transfer in words of DSPI_FIFO_SIZE */

--
Stefan


>         curr_remaining_bytes = dspi->len;
> +       bytes_per_buffer = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
>         while (curr_remaining_bytes) {
>                 /* Check if current transfer fits the DMA buffer */
> -               dma->curr_xfer_len = curr_remaining_bytes;
> -               bytes_per_buffer = DSPI_DMA_BUFSIZE /
> -                               (DSPI_FIFO_SIZE / (tx_word ? 2 : 1));
> -               if (curr_remaining_bytes > bytes_per_buffer)
> +               dma->curr_xfer_len = curr_remaining_bytes / tx_word;
> +               if (dma->curr_xfer_len > bytes_per_buffer)
>                         dma->curr_xfer_len = bytes_per_buffer;
>  
>                 ret = dspi_next_xfer_dma_submit(dspi);
> @@ -349,7 +349,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
>                         goto exit;
>  
>                 } else {
> -                       curr_remaining_bytes -= dma->curr_xfer_len;
> +                       curr_remaining_bytes -= dma->curr_xfer_len * tx_word;
>                         if (curr_remaining_bytes < 0)
>                                 curr_remaining_bytes = 0;
>                         dspi->len = curr_remaining_bytes;
> 
> 
> Regards,
> Sanchayan.
>>
>> --
>> Stefan
>>
>>
>> >  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> >  	if (!dma->tx_desc) {
>> >  		dev_err(dev, "Not able to get desc for DMA xfer\n");
>> > @@ -281,7 +284,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>> >
>> >  	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
>> >  					dma->rx_dma_phys,
>> > -					DSPI_DMA_BUFSIZE, DMA_DEV_TO_MEM,
>> > +					dma->curr_xfer_len *
>> > +					DMA_SLAVE_BUSWIDTH_4_BYTES /
>> > +					(tx_word ? 2 : 1),
>> > +					DMA_DEV_TO_MEM,
>> >  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> >  	if (!dma->rx_desc) {
>> >  		dev_err(dev, "Not able to get desc for DMA xfer\n");
