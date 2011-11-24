From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 10:06:53 +0100
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77233A4E4@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124082903.GV19986@pengutronix.de>
 <20111124083747.GE8439@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F77233A4E4@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111124090653.GX19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 24, 2011 at 09:02:21AM +0000, Dong Aisheng-B29396 wrote:
> > > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > > b/drivers/i2c/busses/i2c-mxs.c index 7e78f7c..00f098f 100644
> > > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct
> > > > mxs_i2c_dev *i2c)
> > > >
> > > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf,
> > > > int len)  {
> > > > -	u32 data;
> > > > +	u32 data = 0;
> > > >  	int i;
> > > >
> > > >  	for (i = 0; i < len; i++) {
> > > Looks like a stupid compiler. Then better use
> > >
> > > 	u32 uninitialized_var(data);
> > 
> > Leave it as it is and fix the compiler? Will do another test later to
> > make sure.
> > 
> 
> Compiler is wrong?
> Just from the code that it seems to be right the 'data' might be used
> uninitialized.
> 
> Something I missed?
> 
> static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
> {
>         u32 data;
>         int i;
> 
>         for (i = 0; i < len; i++) {
>                 if ((i & 3) == 0) {
>                         if (mxs_i2c_wait_for_data(i2c))
>                                 return -ETIMEDOUT;
>                         data = readl(i2c->regs + MXS_I2C_QUEUEDATA);
>                 }
>                 buf[i] = data & 0xff;
>                 data >>= 8;
>         }
When data is used the first time, i is 0, so it went through the body of
the if above before which assigned data. So no, data is initialized when
used to assign buf[i].

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
