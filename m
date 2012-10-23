From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 20:57:06 +0300
Subject: [PATCH] i2c: omap: re-factor omap_i2c_init function
In-Reply-To: <CAM=Q2cs-+O_BFrZFX4fuBooogEZiQO2Zxbm8W40vN9hmampLCA@mail.gmail.com>
References: <1351006039-24332-1-git-send-email-shubhrajyoti@ti.com>
 <20121023171840.GA32167@arwen.pp.htv.fi>
 <CAM=Q2cs-+O_BFrZFX4fuBooogEZiQO2Zxbm8W40vN9hmampLCA@mail.gmail.com>
Message-ID: <20121023175706.GC32517@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 11:26:15PM +0530, Shubhrajyoti Datta wrote:
> >> @@ -1268,23 +1271,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
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
> >
> > this part is not on __omap_i2c_init() so you're potentially causing a
> > regression here.
> 
> iestate is set at init so cannot be zero. so the check was removed.

so you never read it back ? Then you need to add a note for that in
changelog, since this is a behavior change ;-)


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/5b08f585/attachment.sig>
