From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 17 May 2013 14:15:53 +0200
Subject: [PATCH 9/9] I2C: mv64xxx: fix race between FSM/interrupt and
 process context
In-Reply-To: <20130517100016.GB18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4xE-0004KB-2T@rmk-PC.arm.linux.org.uk>
 <20130517095149.GI17056@katana>
 <20130517100016.GB18614@n2100.arm.linux.org.uk>
Message-ID: <20130517121550.GB2939@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 11:00:16AM +0100, Russell King - ARM Linux wrote:
> On Fri, May 17, 2013 at 11:51:51AM +0200, Wolfram Sang wrote:
> > >  {
> > >  	switch(drv_data->action) {
> > >  	case MV64XXX_I2C_ACTION_SEND_RESTART:
> > > +		/* We should only get here if we have further messages */
> > > +		BUG_ON(drv_data->num_msgs == 0);
> > > +
> > 
> > ...
> > 
> > > @@ -453,16 +463,20 @@ static int
> > >  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> > >  {
> > >  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> > > -	int	i, rc;
> > > +	int rc, ret = num;
> > >  
> > > -	for (i = 0; i < num; i++) {
> > > -		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
> > > -						i == 0, i + 1 == num);
> > > -		if (rc < 0)
> > > -			return rc;
> > > -	}
> > > +	BUG_ON(drv_data->msgs != NULL);
> > 
> > Can't we handle this more gracefully than to halt the kernel? Like
> > WARN_ON and resetting the controller or disabling the bus or...
> 
> Well, the latter really is something which should never ever happen,
> and if it does happen it can only really be because something's
> screwed up in the locking in the I2C layer.

I'd think we should trust the layer here.

> The former is more probable, and I thought about that, but I don't
> have any good alternative solution.  Given the problems I've seen,
> I don't think resetting the controller is really an option, because
> that'll likely cause the bus to lock (that's the original problem
> which I'm trying to solve in this patch.)  The thing really does
> have to work according to the I2C protocol otherwise stuff goes
> irrecoverably wrong to the point of needing an entire system reset.

Fine with me for now. If somebody later has a setup where I2C slaves can
be reset (e.g. via GPIO), so a complete bus reset is possible, we might
need another solution, then.

Thanks,

   Wolfram
