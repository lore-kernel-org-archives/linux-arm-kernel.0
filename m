From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 16:44:47 +0200
Subject: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset configurable
In-Reply-To: <20130612135735.GR18614@n2100.arm.linux.org.uk>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130612135735.GR18614@n2100.arm.linux.org.uk>
Message-ID: <20130612144447.GI16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Wed, Jun 12, 2013 at 02:57:35PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 12, 2013 at 10:07:11AM +0200, Maxime Ripard wrote:
> > The Allwinner i2c controller uses the same logic as the Marvell one, but
> > with slightly different register offsets.
> > 
> > Introduce a structure that will be passed by either the pdata or
> > associated to the compatible strings, and that holds the various
> > registers that might be needed.
> 
> I don't like this change.  It introduces further indirection where it's
> not really necessary, and it's also using platform data to specify this
> which is in the opposite direction to what's required for moving towards
> DT.

Well, some users of this aren't converted to DT, hence why I made the
changes to the platform_data.

> > @@ -154,13 +147,13 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
> >  static void
> >  mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
> >  {
> > -	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SOFT_RESET);
> > +	writel(0, drv_data->reg_base + drv_data->regs->soft_reset);
> 
> It'd be much better to copy the offsets themselves in drv_data.  You're
> only talking about 7 bytes here, so there's no worry about bloating the
> drv_data structure.

It was more about keeping things separated. Moreover, the probe
function gets smaller, since you have only a pointer to pass on, instead
of assigning those 7 bytes.

And since Gregory Clement is working on adding more registers, I believe
it makes more sense to have things separate.

> 
> > @@ -611,8 +619,9 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> >  		drv_data->freq_n = pdata->freq_n;
> >  		drv_data->irq = platform_get_irq(pd, 0);
> >  		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> > +		drv_data->regs = pdata->regs;
> >  	} else if (pd->dev.of_node) {
> > -		rc = mv64xxx_of_config(drv_data, pd->dev.of_node);
> > +		rc = mv64xxx_of_config(drv_data, &pd->dev);
> 
> I'd suggest making the default register offsets be the drivers existing
> offsets, and allowing it to be overriden.  That nicely sorts out the
> next comment below, and also gets rid of it in platform data.  Moreover,
> if you're going to re-use this driver, you should do it via a different
> "compatible" name in DT, which the driver can then use to identify the
> different register set layout.

The logic here will change quite a bit in the next iteration thanks to
the comments I received.

I'm now using a platform_device_id structure to match the name of the
driver just like what was done with the DT in that patchset. This also
removes the need to add the regs field to the platform data and ...

> 
> > +struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
> > +	.addr		= 0x00,
> > +	.ext_addr	= 0x10,
> > +	.data		= 0x04,
> > +	.control	= 0x08,
> > +	.status		= 0x0c,
> > +	.clock		= 0x0c,
> > +	.soft_reset	= 0x1c,
> > +};
> 
> No, this means every file which includes this header ends up defining
> this structure, which is globally visiable, and therefore its a recipe
> for link failures.

solves this as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
