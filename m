From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 30 Nov 2017 23:25:38 +0100
Subject: [PATCH 5/5] mtd: nand: add ->exec_op() implementation
In-Reply-To: <20171130215025.67f74437@bbrezillon>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-6-miquel.raynal@free-electrons.com>
 <20171130215025.67f74437@bbrezillon>
Message-ID: <20171130232538.140f17b1@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/drivers/mtd/nand/nand_base.c
> > b/drivers/mtd/nand/nand_base.c index 52965a8aeb2c..46bf31aff909
> > 100644 --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -689,6 +689,59 @@ static void nand_wait_status_ready(struct
> > mtd_info *mtd, unsigned long timeo) };
> >  
> >  /**
> > + * nand_soft_waitrdy - Read the status waiting for it to be ready
> > + * @chip: NAND chip structure
> > + * @timeout_ms: Timeout in ms
> > + *
> > + * Poll the status using ->exec_op() until it is ready unless it
> > takes too
> > + * much time.
> > + *
> > + * This helper is intended to be used by drivers without R/B pin
> > available to
> > + * poll for the chip status until ready and may be called at any
> > time in the
> > + * middle of any set of instruction. The READ_STATUS just need to
> > ask a single
> > + * time for it and then any read will return the status. Once the
> > READ_STATUS
> > + * cycles are done, the function will send a READ0 command to
> > cancel the
> > + * "READ_STATUS state" and let the normal flow of operation to
> > continue.
> > + *
> > + * This helper *cannot* send a WAITRDY command or ->exec_op()
> > implementations  
> 
> 					  ^ instruction
> 
> > + * using it will enter an infinite loop.  
> 
> Hm, not sure why this would be the case, but okay. Maybe you should
> move this comment outside the kernel doc header, since this is an
> implementation detail, not something the caller/user should be aware
> of.

Right.

> 
> There's another important aspect to mention here: this function can
> only be called from an ->exec_op() implementation if this
> implementation is re-entrant.

I do not agree with this statement: this function can be called from an
->exec_op() implementation even if it is not reentrant as long as it
does not send a WAITRDY instruction itself. No?

Or maybe you wanted to point that the entire ->exec_op()
implementation must be reentrant in order to use this function in it?

> 
> > + *
> > + * Return 0 if the NAND chip is ready, a negative error otherwise.
> > + */
> > +int nand_soft_waitrdy(struct nand_chip *chip, unsigned long
> > timeout_ms) +{
> > +	u8 status = 0;
> > +	int ret;
> > +
> > +	if (!chip->exec_op)
> > +		return -ENOTSUPP;
> > +
> > +	ret = nand_status_op(chip, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
> > +	do {
> > +		ret = nand_read_data_op(chip, &status,
> > sizeof(status), true);
> > +		if (ret)
> > +			break;
> > +
> > +		if (status & NAND_STATUS_READY)
> > +			break;
> > +
> > +		udelay(100);  
> 
> Sounds a bit high, especially for a read page which takes around 20us.

Well, this value is arbitrary but greping for NAND_OP_WAIT_RDY tells us
the different timeouts with which this function is usually called, to
get an idea of the possible wait periods: tR, tBERS, tFEAT, tPROG, tRST.

While a tR_max is 200us, a tRST_max is 250000us. That is why I choose
100us as period, which I found somehow well tuned for every timeout. But
if you think most of the time the delay will be smaller, I will update
the value to repeat the operation every 20us.

> 
> > +	} while	(time_before(jiffies, timeout_ms));
> > +
> > +	nand_exit_status_op(chip);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return status & NAND_STATUS_READY ? 0 : -ETIMEDOUT;
> > +};
> > +EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
> > +
