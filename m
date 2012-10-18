From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 20:07:39 +0300
Subject: [RFC/NOT FOR MERGING 4/5] i2c: omap: don't re-enable IRQs after
 masking them
In-Reply-To: <874nlrg101.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-5-git-send-email-balbi@ti.com>
 <874nlrg101.fsf@deeprootsystems.com>
Message-ID: <20121018170739.GC6641@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 10:10:06AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > OMAP I2C driver will re-enable IRQs right after
> > masking them during suspend.
> >
> > That's not what we want. We want to keep IRQs
> > masked until our resume method is called.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index db31eae..7eeae11 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1247,14 +1247,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
> >  
> >  	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
> >  
> > -	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
> > -		iv = omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
> > -	} else {
> > -		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
> > -
> > -		/* Flush posted write */
> > -		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
> > -	}
> 
> Are you sure this re-enables the interrupt?  It looks to me like
> it's meant to clear the interrupt.    
> 
> > +	/* Flush posted write */
> > +	omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
> 
> Assuming the above is correct, should this be IE_REG?

indeed. My eyes failed. This patch can be thrown away. My bad.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/b4a51840/attachment.sig>
