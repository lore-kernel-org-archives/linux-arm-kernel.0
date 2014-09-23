From: agross@codeaurora.org (Andy Gross)
Date: Tue, 23 Sep 2014 14:26:13 -0500
Subject: [PATCH] spi: qup: Fix incorrect block transfers
In-Reply-To: <1411464267.18580.46.camel@iivanov-dev>
References: <1411360048-3388-1-git-send-email-agross@codeaurora.org>
 <1411464267.18580.46.camel@iivanov-dev>
Message-ID: <20140923192613.GA5975@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 12:24:27PM +0300, Ivan T. Ivanov wrote:
> 
> Hi Andy,
> 
> On Sun, 2014-09-21 at 23:27 -0500, Andy Gross wrote:
> > This patch fixes a number of errors with the QUP block transfer mode.  Errors
> > manifested themselves as input underruns, output overruns, and timed out
> > transactions.
> 
> At what speeds are you seeing those errors?

We've tried 25MHz and 50MHz.  Both fail in the same way.  Keep in mind this is
definitely a timing / race issue and it probably also dependent on the latency
of the attached device.  I cannot reproduce this at all on my IPQ8064 based
board, but others can.

This problem manifested itself while using spidev and a usermode flash
programming application (flashrom).

> 
> > 
> > The block mode does not require the priming that occurs in FIFO mode.  At the
> > moment that the QUP is placed into the RUN state, the QUP may immediately raise
> > an interrupt if the request is a write.  Therefore, there is no need to prime
> > the pump.
> > 
> > In addition, the block transfers require that whole blocks of data are
> > read/written at a time.  The last block of data that completes a transaction may
> > contain less than a full blocks worth of data.
> 
> Does this mean that block transfer will start only if the required
> bytes from block is written into buffer?

No, a better way of putting this is that immediately on setting RUN state,
you'll get a service interrupt to fill the FIFO in block mode.  So there is no
need to prime the FIFO from the non-isr context due to this behavior.

<snip>

> 
> > +static void qup_fill_read_buffer(struct spi_qup *controller,
> > +	struct spi_transfer *xfer, u32 data)
> 
> Please, could prefix this whit spi_ to be consistent with the
> rest of the code.

Good point.  I need to be consistent.

> >  {
> >  	u8 *rx_buf = xfer->rx_buf;
> > -	u32 word, state;
> > -	int idx, shift, w_size;
> > -
> > -	w_size = controller->w_size;
> > -
> > -	while (controller->rx_bytes < xfer->len) {
> > -
> > -		state = readl_relaxed(controller->base + QUP_OPERATIONAL);
> > -		if (0 == (state & QUP_OP_IN_FIFO_NOT_EMPTY))
> > -			break;
> > +	int idx, shift;
> > +	int read_len = min_t(int, xfer->len - controller->rx_bytes,
> > +				controller->w_size);
> 
> You should not need this check here. xfer->len is multiple of controller->w_size
> and you always read one word at time.

Ah I missed the __spi_validate where this is done.  I'll remove this.  Good
catch.

<snip>

> >  	const u8 *tx_buf = xfer->tx_buf;
> > -	u32 word, state, data;
> > -	int idx, w_size;
> > +	u32 val;
> > +	int idx;
> > +	int write_len = min_t(int, xfer->len - controller->tx_bytes,
> > +				controller->w_size);
> >  
> 
> Same here.

Agreed.

<snip>

> > -		word = 0;
> > -		for (idx = 0; idx < w_size; idx++, controller->tx_bytes++) {
> > +static void spi_qup_service_block(struct spi_qup *controller,
> > +	struct spi_transfer *xfer, bool is_read)
> > +{
> 
> Please, could you split this function to read and write, so we can use:
> 
> spi_qup_fifo_read() and spi_qup_fifo_write() in FIFO modes and 
> spi_qup_block_read() and spi_qup_block_write() for BLOCK mode.

Well I had it collapsed and the functions are identical except for the
read/write specific pieces, which amount to 2 lines.  I can resplit it out.  It
makes it symmetric.

> 
> > +	u32 data, words_per_blk, num_words, ack_flag, op_flag;
> > +	int i;
> > +
> > +	if (is_read) {
> > +		op_flag = QUP_OP_IN_BLOCK_READ_REQ;
> > +		ack_flag = QUP_OP_IN_SERVICE_FLAG;
> > +		num_words = DIV_ROUND_UP(xfer->len - controller->rx_bytes,
> > +					controller->w_size);
> 
> Same here and below.

Agreed.

> > +		words_per_blk = controller->in_blk_sz >> 2;
> > +	} else {
> > +		op_flag = QUP_OP_OUT_BLOCK_WRITE_REQ;
> > +		ack_flag = QUP_OP_OUT_SERVICE_FLAG;
> > +		num_words = DIV_ROUND_UP(xfer->len - controller->tx_bytes,
> > +					controller->w_size);
> > +		words_per_blk = controller->out_blk_sz >> 2;
> > +	}

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
