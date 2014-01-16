From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 16 Jan 2014 15:37:24 +0200
Subject: [PATCH v2 2/2] i2c: New bus driver for the QUP I2C controller
In-Reply-To: <20140115164604.GI14405@codeaurora.org>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140115164604.GI14405@codeaurora.org>
Message-ID: <1389879444.2794.44.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wed, 2014-01-15 at 08:46 -0800, Stephen Boyd wrote: 
> On 01/13, Bjorn Andersson wrote:
> > +/*
> > + * QUP driver for Qualcomm MSM platforms
> > + *
> > + */
> 
> This comment seems redundant, we know what file we're looking at.
> 
> > +
> > +struct qup_i2c_dev {
> > +	struct device		*dev;
> > +	void __iomem		*base;
> > +	struct pinctrl		*pctrl;
> 
> This is unused.
> 
> > +	int			irq;
> > +	struct clk		*clk;
> > +	struct clk		*pclk;
> > +	struct i2c_adapter	adap;
> > +
> > +	int			clk_freq;
> 
> This is only ever used in probe, so why do we need to store it
> away?
> 
> > +	int			clk_ctl;
> > +	int			one_bit_t;
> > +	int			out_fifo_sz;
> > +	int			in_fifo_sz;
> > +	int			out_blk_sz;
> > +	int			in_blk_sz;
> > +	unsigned long		xfer_time;
> > +	unsigned long		wait_idle;
> > +
> > +	struct i2c_msg		*msg;
> > +	/* Current possion in user message buffer */
> 
> s/possion/position/?
> 
> > +	int			pos;
> > +	/* Keep number of bytes left to be transmitted */
> > +	int			cnt;
> > +	/* I2C protocol errors */
> > +	u32			bus_err;
> > +	/* QUP core errors */
> > +	u32			qup_err;
> > +	/*
> > +	 * maximum bytes that could be send (per iterration). could be
> 
> s/iterration/iteration/?
> 
> > +	 * equal of fifo size or block size (in block mode)
> > +	 */
> > +	int			chunk_sz;
> > +	struct completion	xfer;
> > +};
> > +
> > +static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> > +{
> > +	struct qup_i2c_dev *qup = dev;
> > +	u32 bus_err;
> > +	u32 qup_err;
> > +	u32 opflags;
> > +
> [...]
> > +
> > +	if (opflags & QUP_OUT_SVC_FLAG)
> > +		writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> > +
> > +	if (!(qup->msg->flags == I2C_M_RD))
> 
> Should this be?
> 
> 	if (!(qup->msg->flags & I2C_M_RD))
> 
> Otherwise it should be
> 
> 	if (qup->msg->flags != I2C_M_RD)
> 

This check is actually broken. Intention was that if this is read
transaction and there is no QUP_MX_INPUT_DONE or QUP_IN_SVC_FLAG
to exit without wakeup transfer thread. As is it now it will never
complete write transactions.

Regards,
Ivan

> > +		return IRQ_HANDLED;
> > +
> > +	if ((opflags & QUP_MX_INPUT_DONE) || (opflags & QUP_IN_SVC_FLAG))
> > +		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> > +
> > +done:
> > +	qup->qup_err = qup_err;
> > +	qup->bus_err = bus_err;
> > +	complete(&qup->xfer);
> > +	return IRQ_HANDLED;
> > +}
> > +
