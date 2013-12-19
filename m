From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 19 Dec 2013 13:06:47 +0100
Subject: [PATCH V2 5/5] i2c: riic: add driver
In-Reply-To: <1407973.m5fTNuo5v5@avalon>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-6-git-send-email-wsa@the-dreams.de>
 <1407973.m5fTNuo5v5@avalon>
Message-ID: <20131219120646.GA2563@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

thanks for the review!


> > +/*
> > + * This i2c core has a lot of interrupts, namely 8. We use their chaining
> > as
> > + * some kind of state machine.
> 
> I have mixed feelings about this. Wouldn't it be more efficient to have an 
> internal state machine (which you partially have already, using RIIC_INIT_MSG 
> for instance) instead of relying on enabling/disabling interrupts ? The latter 
> has a larger overhead.

I am not sure I get you here. I need the interrupts anyhow. For example,
after the last byte has been written to the 1-byte-FIFO in the
transmission_irq, I need to wait for the transmission_end_irq to ensure
the bits are already on the wire before I mark the message completed.

Polling for that condition is more overhead than just enabling the
proper interrupt (one write to ICIER). I don't need to switch ISR since
all the interrupts are seperate and have dedicated ISR.

> > +static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int
> > num)
> > +{
> > +	struct riic_dev *riic = i2c_get_adapdata(adap);
> > +	int i, ret;
> 
> One of my favorite bikeshedding comments is to ask for unsigned int when the 
> variable can't be negative :-)

OK.

> > +	/*
> > +	 * TODO: Implement formula to calculate the timing values depending on
> > +	 * variable parent clock rate and arbitrary bus speed
> > +	 */
> > +	rate = clk_get_rate(riic->clk);
> > +	if (rate != 33325000) {
> > +		dev_err(&riic->adapter.dev,
> > +			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
> 
> What about a "goto done;" here and below to avoid repeating the 
> clk_disable_unprepare() call ?

Yeah, can be argued that way. I was fine with both.

> 
> > +		clk_disable_unprepare(riic->clk);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Changing the order of accessing IICRST and ICE may break things! */
> > +	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
> > +	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
> > +
> > +	switch (spd) {
> > +	case 100000:
> > +		writeb(ICMR1_CKS(3), riic->base + RIIC_ICMR1);
> > +		writeb(ICBRH_SP100K, riic->base + RIIC_ICBRH);
> > +		writeb(ICBRL_SP100K, riic->base + RIIC_ICBRL);
> > +		break;
> > +	case 400000:
> > +		writeb(ICMR1_CKS(1), riic->base + RIIC_ICMR1);
> > +		writeb(ICBRH_SP400K, riic->base + RIIC_ICBRH);
> > +		writeb(ICBRL_SP400K, riic->base + RIIC_ICBRL);
> 
> Couldn't you compute the ICMR1, ICBRH and ICBRL values at runtime instead ?

As mentioned in the TODO above, this is scheduled for an incremental
update to this driver.

> > +	of_property_read_u32(np, "clock-frequency", &bus_rate);
> 
> As the property is mandatory, shouldn't you check the return value of this 
> function ? Another option would be to make the clock-frequency property 
> optional and use a default value. What do the other I2C bus drivers usually do 
> ?

bus_rate is initialized to 0 and if read_u32 fails, it will stay this
way. Then, the call to riic_init_hw() will fail and report the error.

There is no standard behaviour (use sane default or fail) yet. It is
somewhere on the I2C todo list :/

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/76f366bf/attachment.sig>
