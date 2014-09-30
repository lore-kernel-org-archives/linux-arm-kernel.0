From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 30 Sep 2014 15:28:00 +0300
Subject: [Patch v2] spi: qup: Fix incorrect block transfers
In-Reply-To: <1411592698-30952-1-git-send-email-agross@codeaurora.org>
References: <1411592698-30952-1-git-send-email-agross@codeaurora.org>
Message-ID: <1412080080.26751.15.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andy, just few comments.

On Wed, 2014-09-24 at 16:04 -0500, Andy Gross wrote:

<snip>

> +static void spi_qup_fifo_read(struct spi_qup *controller,
> +			    struct spi_transfer *xfer)
> +{
> +	u32 data;
> +
> +	/* clear service request */
> +	writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
> +		controller->base + QUP_OPERATIONAL);
> +

Please, could you indent function parameters to open brace, when
they can not fit into one line.

> +	while (controller->rx_bytes < xfer->len) {
> +		if (!(readl_relaxed(controller->base + QUP_OPERATIONAL) &
> +			QUP_OP_IN_FIFO_NOT_EMPTY))

Should be aligned just after first open brace.

> +			break;
> +
> +		data = readl_relaxed(controller->base + QUP_INPUT_FIFO);
> +
> +		spi_qup_fill_read_buffer(controller, xfer, data);
>  	}
>  }
>  

> +static void spi_qup_block_read(struct spi_qup *controller,
> +	struct spi_transfer *xfer)
> +{
> +	u32 data;
> +	u32 words_per_blk = controller->in_blk_sz >> 2;

I have been confused from the variable name. These are number of 
32 bits reads, not SPI words, right? 

> +	u32 num_words = (xfer->len - controller->rx_bytes) / controller->w_size;
> +	int i;
> +
> +	do {
> +		/* ACK by clearing service flag */
> +		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
> +			controller->base + QUP_OPERATIONAL);
> +
> +		/* transfer up to a block size of data in a single pass */
> +		for (i = 0; num_words && i < words_per_blk; i++, num_words--) {
> +
> +			/* read data and fill up rx buffer */
> +			data = readl_relaxed(controller->base + QUP_INPUT_FIFO);
> +			spi_qup_fill_read_buffer(controller, xfer, data);
>  		}
>  
> -		writel_relaxed(word, controller->base + QUP_OUTPUT_FIFO);
> -	}
> +		/* check to see if next block is ready */
> +		if (!(readl_relaxed(controller->base + QUP_OPERATIONAL) &
> +			QUP_OP_IN_BLOCK_READ_REQ))
> +			break;
> +
> +	} while (num_words);
> +
> +	/*
> +	 * Due to extra stickiness of the QUP_OP_IN_SERVICE_FLAG during block
> +	 * reads, it has to be cleared again at the very end
> +	 */
> +	if (readl_relaxed(controller->base + QUP_OPERATIONAL) &
> +		QUP_OP_MAX_INPUT_DONE_FLAG)
> +		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
> +			controller->base + QUP_OPERATIONAL);
> +
> +}
> +
>  
>  static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
> @@ -285,9 +370,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  
>  	writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
>  	writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
> -	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
>  
>  	if (!xfer) {
> +		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
>  		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
>  				    qup_err, spi_err, opflags);
>  		return IRQ_HANDLED;
> @@ -315,11 +400,19 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
>  		error = -EIO;
>  	}
>  
> -	if (opflags & QUP_OP_IN_SERVICE_FLAG)
> -		spi_qup_fifo_read(controller, xfer);
> +	if (opflags & QUP_OP_IN_SERVICE_FLAG) {
> +		if (opflags & QUP_OP_IN_BLOCK_READ_REQ)
> +			spi_qup_block_read(controller, xfer);
> +		else
> +			spi_qup_fifo_read(controller, xfer);
> +	}
>  
> -	if (opflags & QUP_OP_OUT_SERVICE_FLAG)
> -		spi_qup_fifo_write(controller, xfer);
> +	if (opflags & QUP_OP_OUT_SERVICE_FLAG) {
> +		if (opflags & QUP_OP_OUT_BLOCK_WRITE_REQ)
> +			spi_qup_block_write(controller, xfer);
> +		else
> +			spi_qup_fifo_write(controller, xfer,1);
> +	}

ERROR: space required after that ',' (ctx:VxV)
#414: FILE: drivers/spi/spi-qup.c:414:
+			spi_qup_fifo_write(controller, xfer,1);
 			                                   ^

You don't really need this last parameter, right?

Regards,
Ivan
