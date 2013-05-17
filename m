From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 10:34:49 +0100
Subject: [PATCH 3/9] I2C: mv64xxx: use devm_ioremap_resource()
In-Reply-To: <20130517112316.12a3ddc3@armhf>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4rN-0004Jc-CL@rmk-PC.arm.linux.org.uk> <20130517112316.12a3ddc3@armhf>
Message-ID: <20130517093449.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 11:23:16AM +0200, Jean-Francois Moine wrote:
> On Thu, 16 May 2013 21:33:09 +0100
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Eliminate reg_base_p and reg_size, mv64xxx_i2c_unmap_regs() and an
> > unchecked ioremap() return from this driver by using the devm_*
> > API for requesting and ioremapping resources.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/i2c/busses/i2c-mv64xxx.c |   46 +++++---------------------------------
> >  1 files changed, 6 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> > index 0339cd8..19cc9bf 100644
> > --- a/drivers/i2c/busses/i2c-mv64xxx.c
> > +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> 	[snip]
> > @@ -704,7 +671,6 @@ mv64xxx_i2c_remove(struct platform_device *dev)
> >  
> >  	rc = i2c_del_adapter(&drv_data->adapter);
> >  	free_irq(drv_data->irq, drv_data);
> > -	mv64xxx_i2c_unmap_regs(drv_data);
> >  #if defined(CONFIG_HAVE_CLK)
> >  	/* Not all platforms have a clk */
> >  	if (!IS_ERR(drv_data->clk)) {
> 
> The patch does not apply: it seems it lacks:

I should've mentioned that the patches are against v3.9, not v3.10-rc1.

> +	int rc;
> 
> -	i2c_del_adapter(&drv_data->adapter);
> +	rc = i2c_del_adapter(&drv_data->adapter);
> 
> -	return 0;
> +	return rc;
> 
> BTW, is this return code useful?

No it isn't.  Removals *can't* fail.  Once the remove function is called,
the device _will_ be unbound no matter what the return value of that
function is.  The module will also be unloaded (if that's why it's being
unbound) whether or not you return an error.

So, removals must always succeed.  Why their return type hasn't been void
from the start I've no idea - but that's a question for Patrick Mochel
who implemented the original driver model design.
