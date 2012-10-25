From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 10:03:50 +0300
Subject: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
In-Reply-To: <CAM=Q2cvzQ7fVL1-vUpWZdwhGk3s0GpO3uG3MH9CAzBvyeSftKQ@mail.gmail.com>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
 <20121025063608.GA5084@arwen.pp.htv.fi>
 <CAM=Q2cvzQ7fVL1-vUpWZdwhGk3s0GpO3uG3MH9CAzBvyeSftKQ@mail.gmail.com>
Message-ID: <20121025070349.GA5259@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 12:23:56PM +0530, Shubhrajyoti Datta wrote:
> >> @@ -1268,23 +1276,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
> >>  {
> >>       struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
> >>
> >> -     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> >> -     }
> >> -
> >> -     /*
> >> -      * Don't write to this register if the IE state is 0 as it can
> >> -      * cause deadlock.
> >> -      */
> >> -     if (_dev->iestate)
> >> -             omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
> >> +     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
> >> +             __omap_i2c_init(_dev);
> >>
> >>       return 0;
> >>  }
> >
> > you continue to miss the changes in omap_i2c_xfer_msg() and your
> > explanation of why not doing it wasn't good enough IMHO.
> 
> Will do that . I am preparing a seperate patch for moving the
> calculation to a seperate function.

why do you need yet another function ? omap_i2c_init() does all
calculation and __omap_i2c_init() doesn't do any calculations. What's
the point for yet another function ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/5b6583bd/attachment-0001.sig>
