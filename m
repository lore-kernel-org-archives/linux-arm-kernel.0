From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 19 Dec 2013 16:33:41 +0100
Subject: [PATCH V2 5/5] i2c: riic: add driver
In-Reply-To: <20131219120646.GA2563@katana>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1407973.m5fTNuo5v5@avalon> <20131219120646.GA2563@katana>
Message-ID: <2069590.SA4Ef3s3BZ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thursday 19 December 2013 13:06:47 Wolfram Sang wrote:
> Hi Laurent,
> 
> thanks for the review!
> 
> > > +/*
> > > + * This i2c core has a lot of interrupts, namely 8. We use their
> > > chaining as some kind of state machine.
> > 
> > I have mixed feelings about this. Wouldn't it be more efficient to have an
> > internal state machine (which you partially have already, using
> > RIIC_INIT_MSG for instance) instead of relying on enabling/disabling
> > interrupts ? The latter has a larger overhead.
> 
> I am not sure I get you here. I need the interrupts anyhow. For example,
> after the last byte has been written to the 1-byte-FIFO in the
> transmission_irq, I need to wait for the transmission_end_irq to ensure the
> bits are already on the wire before I mark the message completed.
> 
> Polling for that condition is more overhead than just enabling the proper
> interrupt (one write to ICIER). I don't need to switch ISR since all the
> interrupts are seperate and have dedicated ISR.

I haven't expressed myself clearly. Polling is of course a bad option. My 
point was that I understood your comment as meaning that you enable and 
disable interrupts at runtime and use that as a state machine, while I was 
wondering whether it wouldn't be simpler to keep all interrupts enabled at all 
time and handle the synchronization explicitly.

Please scratch the comment about the larger overhead though, that was a 
mistake due to reading the code too fast.

> > > +static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> > > int num)
> > > +{
> > > +	struct riic_dev *riic = i2c_get_adapdata(adap);
> > > +	int i, ret;
> > 
> > One of my favorite bikeshedding comments is to ask for unsigned int when
> > the variable can't be negative :-)
> 
> OK.
> 
> > > +	/*
> > > +	 * TODO: Implement formula to calculate the timing values depending 
on
> > > +	 * variable parent clock rate and arbitrary bus speed
> > > +	 */
> > > +	rate = clk_get_rate(riic->clk);
> > > +	if (rate != 33325000) {
> > > +		dev_err(&riic->adapter.dev,
> > > +			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
> > 
> > What about a "goto done;" here and below to avoid repeating the
> > clk_disable_unprepare() call ?
> 
> Yeah, can be argued that way. I was fine with both.
> 
> > > +		clk_disable_unprepare(riic->clk);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Changing the order of accessing IICRST and ICE may break things! 
*/
> > > +	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
> > > +	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
> > > +
> > > +	switch (spd) {
> > > +	case 100000:
> > > +		writeb(ICMR1_CKS(3), riic->base + RIIC_ICMR1);
> > > +		writeb(ICBRH_SP100K, riic->base + RIIC_ICBRH);
> > > +		writeb(ICBRL_SP100K, riic->base + RIIC_ICBRL);
> > > +		break;
> > > +	case 400000:
> > > +		writeb(ICMR1_CKS(1), riic->base + RIIC_ICMR1);
> > > +		writeb(ICBRH_SP400K, riic->base + RIIC_ICBRH);
> > > +		writeb(ICBRL_SP400K, riic->base + RIIC_ICBRL);
> > 
> > Couldn't you compute the ICMR1, ICBRH and ICBRL values at runtime instead
> > ?
> 
> As mentioned in the TODO above, this is scheduled for an incremental
> update to this driver.

Nice :-)

> > > +	of_property_read_u32(np, "clock-frequency", &bus_rate);
> > 
> > As the property is mandatory, shouldn't you check the return value of this
> > function ? Another option would be to make the clock-frequency property
> > optional and use a default value. What do the other I2C bus drivers
> > usually do ?
> 
> bus_rate is initialized to 0 and if read_u32 fails, it will stay this
> way. Then, the call to riic_init_hw() will fail and report the error.

That's the part I wasn't sure to like, but it will be reworked when making 
clock speed computation dynamic anyway, so we can keep it as-is for now.

> There is no standard behaviour (use sane default or fail) yet. It is
> somewhere on the I2C todo list :/

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/2ff7bf40/attachment.sig>
