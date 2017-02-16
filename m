From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 16 Feb 2017 17:58:58 +0100
Subject: [PATCH] i2c: at91: ensure state is restored after suspending
In-Reply-To: <20170206143555.jo7y57y7gjw3ialm@rfolt0960.corp.atmel.com>
References: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
 <20170206143555.jo7y57y7gjw3ialm@rfolt0960.corp.atmel.com>
Message-ID: <20170216165858.pvs6c6gxbafq6xto@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2017 at 15:35:55 +0100, Ludovic Desroches wrote:
> On Mon, Jan 30, 2017 at 06:25:33PM +0100, Alexandre Belloni wrote:
> > When going to suspend, the I2C registers may be lost because the power to
> > VDDcore is cut. Save them and restore them when resuming.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/i2c/busses/i2c-at91.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > index 0b86c6173e07..633bdd899952 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -140,6 +140,12 @@ struct at91_twi_dev {
> >  	unsigned transfer_status;
> >  	struct i2c_adapter adapter;
> >  	unsigned twi_cwgr_reg;
> > +	struct {
> > +		u32 mmr;
> > +		u32 imr;
> > +		u32 fmr;
> > +		u32 fimr;
> > +	} cache;
> 
> Do we really need it?
> 
> For instance MMR is only written in at91_twi_xfer(). I am not sure we can
> continue the transfer when resuming. I assume we will need to perform a new
> transfer from a proper state.
> 
> Moreover at91_init_twi_bus() is called on resume, it will perform a reset and
> it seems it can lead to strange behaviors:
> "Note that issuing a software while transmitting might leave a slave in
> an unknown state holding the TWD line. In such case, a Bus Clear Command
> will allow to make the slave release the TWD line (the first frame
> sent afterwards might not be received properly by the slave)."
> 

Yeah, so basically because VDDcore is cut, we are not in a position
where continuing the transfer is possible.

I would simply call at91_init_twi_bus() in resume_noirq. I think it is
the proper thing to do.

> I think fimr is useless, AT91_TWI_FIER and AT91_TWI_FIDR are not used in
> the current code.
> 

You are right.

> Regards
> 
> Ludovic
> 
> >  	struct at91_twi_pdata *pdata;
> >  	bool use_dma;
> >  	bool use_alt_cmd;
> > @@ -1172,6 +1178,15 @@ static int at91_twi_runtime_resume(struct device *dev)
> >  
> >  static int at91_twi_suspend_noirq(struct device *dev)
> >  {
> > +	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
> > +
> > +	twi_dev->cache.mmr = at91_twi_read(twi_dev, AT91_TWI_MMR);
> > +	twi_dev->cache.imr = at91_twi_read(twi_dev, AT91_TWI_IMR);
> > +	if (twi_dev->fifo_size) {
> > +		twi_dev->cache.fmr = at91_twi_read(twi_dev, AT91_TWI_FMR);
> > +		twi_dev->cache.fimr = at91_twi_read(twi_dev, AT91_TWI_FIMR);
> > +	}
> > +
> >  	if (!pm_runtime_status_suspended(dev))
> >  		at91_twi_runtime_suspend(dev);
> >  
> > @@ -1180,6 +1195,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
> >  
> >  static int at91_twi_resume_noirq(struct device *dev)
> >  {
> > +	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
> >  	int ret;
> >  
> >  	if (!pm_runtime_status_suspended(dev)) {
> > @@ -1191,6 +1207,14 @@ static int at91_twi_resume_noirq(struct device *dev)
> >  	pm_runtime_mark_last_busy(dev);
> >  	pm_request_autosuspend(dev);
> >  
> > +	at91_init_twi_bus(twi_dev);
> > +	at91_twi_write(twi_dev, AT91_TWI_MMR, twi_dev->cache.mmr);
> > +	at91_twi_write(twi_dev, AT91_TWI_IER, twi_dev->cache.imr);
> > +	if (twi_dev->fifo_size) {
> > +		at91_twi_write(twi_dev, AT91_TWI_FMR, twi_dev->cache.fmr);
> > +		at91_twi_write(twi_dev, AT91_TWI_FIER, twi_dev->cache.fimr);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.11.0
> > 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
