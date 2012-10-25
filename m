From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 15:01:40 +0300
Subject: [PATCH 2/8] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
In-Reply-To: <CAM=Q2cvUeLbS20HScrGTOcraSUrCzhzCi8MQLxd9MOb_7ZFFYA@mail.gmail.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-3-git-send-email-balbi@ti.com>
 <CAM=Q2cvUeLbS20HScrGTOcraSUrCzhzCi8MQLxd9MOb_7ZFFYA@mail.gmail.com>
Message-ID: <20121025120140.GP21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 05:10:10PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Oct 22, 2012 at 3:16 PM, Felipe Balbi <balbi@ti.com> wrote:
> > just a cleanup patch trying to make exit path
> > more straightforward. No changes otherwise.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index c07d9c4..bea0277 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> >  {
> >         struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> >         unsigned long timeout;
> > +       int ret;
> >         u16 w;
> >
> >         dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
> > @@ -582,31 +583,38 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> >         dev->buf_len = 0;
> >         if (timeout == 0) {
> >                 dev_err(dev->dev, "controller timed out\n");
> > -               omap_i2c_init(dev);
> > -               return -ETIMEDOUT;
> > +               ret = -ETIMEDOUT;
> > +               goto err_i2c_init;
> >         }
> >
> > -       if (likely(!dev->cmd_err))
> > -               return 0;
> > -
> >         /* We have an error */
> >         if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >                             OMAP_I2C_STAT_XUDF)) {
> > -               omap_i2c_init(dev);
> > -               return -EIO;
> > +               ret = -EIO;
> > +               goto err_i2c_init;
> >         }
> >
> >         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
> >                 if (msg->flags & I2C_M_IGNORE_NAK)
> >                         return 0;
> > +
> >                 if (stop) {
> >                         w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
> >                         w |= OMAP_I2C_CON_STP;
> >                         omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> >                 }
> > -               return -EREMOTEIO;
> > +
> > +               ret = -EREMOTEIO;
> > +               goto err;
> 
> This adds reset to nack may be that can be removed.

great catch. I will respin this series.

thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/ee1f2e15/attachment-0001.sig>
