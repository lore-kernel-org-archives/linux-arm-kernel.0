From: agross@codeaurora.org (Andy Gross)
Date: Tue, 30 Sep 2014 14:55:44 -0500
Subject: [Patch v2] spi: qup: Fix incorrect block transfers
In-Reply-To: <1412080080.26751.15.camel@iivanov-dev>
References: <1411592698-30952-1-git-send-email-agross@codeaurora.org>
 <1412080080.26751.15.camel@iivanov-dev>
Message-ID: <20140930195544.GA26928@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 03:28:00PM +0300, Ivan T. Ivanov wrote:
> 
> Hi Andy, just few comments.
> 
> On Wed, 2014-09-24 at 16:04 -0500, Andy Gross wrote:
> 
> <snip>
> 
> > +static void spi_qup_fifo_read(struct spi_qup *controller,
> > +			    struct spi_transfer *xfer)
> > +{
> > +	u32 data;
> > +
> > +	/* clear service request */
> > +	writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
> > +		controller->base + QUP_OPERATIONAL);
> > +
> 
> Please, could you indent function parameters to open brace, when
> they can not fit into one line.

Missed this.  Fixed.

> > +	while (controller->rx_bytes < xfer->len) {
> > +		if (!(readl_relaxed(controller->base + QUP_OPERATIONAL) &
> > +			QUP_OP_IN_FIFO_NOT_EMPTY))
> 
> Should be aligned just after first open brace.

Agreed.
 
> > +			break;
> > +
> > +		data = readl_relaxed(controller->base + QUP_INPUT_FIFO);
> > +
> > +		spi_qup_fill_read_buffer(controller, xfer, data);
> >  	}
> >  }
> >  
> 
> > +static void spi_qup_block_read(struct spi_qup *controller,
> > +	struct spi_transfer *xfer)
> > +{
> > +	u32 data;
> > +	u32 words_per_blk = controller->in_blk_sz >> 2;
> 
> I have been confused from the variable name. These are number of 
> 32 bits reads, not SPI words, right? 

Correct.  Naming is always a little funky when words can mean more than one
thing.  Let me change this to reads(writes)_per_blk.

> > +	u32 num_words = (xfer->len - controller->rx_bytes) / controller->w_size;
> > +	int i;
> > +
> > +	do {

<snip>

> > +		/* ACK by clearing service flag */
> > -		spi_qup_fifo_write(controller, xfer);
> > +	if (opflags & QUP_OP_OUT_SERVICE_FLAG) {
> > +		if (opflags & QUP_OP_OUT_BLOCK_WRITE_REQ)
> > +			spi_qup_block_write(controller, xfer);
> > +		else
> > +			spi_qup_fifo_write(controller, xfer,1);
> > +	}
> 
> ERROR: space required after that ',' (ctx:VxV)
> #414: FILE: drivers/spi/spi-qup.c:414:
> +			spi_qup_fifo_write(controller, xfer,1);
>  			                                   ^
> 
> You don't really need this last parameter, right?

Fixed.  Sorry, that shouldn't have remained.

> 
> Regards,
> Ivan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
