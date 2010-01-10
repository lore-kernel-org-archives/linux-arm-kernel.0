From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 13:23:01 +0000
Subject: [PATCH 14/18] ARM: PNX4008: move i2c_adapter structure inside
	the drivers private data
In-Reply-To: <083DF309106F364B939360100EC290F804F5ADDEBB@eu1rdcrdc1wx030.exi.nxp.com>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
	<4a57839e2a45ef8dc845d1c35560cc07e64141ac.1262431163.git.rmk+kernel@arm.linux.org.uk>
	<083DF309106F364B939360100EC290F804F5ADDEBB@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100110132301.GB7716@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 10:07:51PM +0100, Kevin Wells wrote:
> All these changes in the patch series work on my hardware. A
> few comments below, but these can be updated once these changes
> are accepted.

> >  static struct i2c_pnx_data i2c2_data = {
> > -	.adapter = &pnx_adapter2,
> > +	.name = "USB-I2C",
> >  	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
> >  	.irq = USB_I2C_INT,
> >  };
> 
> This looks good. 'struct resource' can be used instead of the
> specialized i2c_pnx_data structure. The name field can be removed
> and the adapter name generically assigned in the driver based on
> the .id field in the platform_device structure. (The i2c2 interface
> won't have then "USB-I2C" name anymore, but thats really just another
> I2C interface, not specific to USB). This would simplify the
> platform code and driver a little more and bring it inline with how
> all the other platform drivers handle platform data. The REGION_SIZE
> macro in the i2c-pnx driver could be swapped out with the platform
> data size field instead.

I thought about that, but because of the naming differences, I decided to
leave alone.  This can be the subject of a separate patch.

> >  	/* Register this adapter with the I2C subsystem */
> > -	i2c_pnx->adapter->dev.parent = &pdev->dev;
> > -	i2c_pnx->adapter->nr = pdev->id;
> > -	ret = i2c_add_numbered_adapter(i2c_pnx->adapter);
> > +	ret = i2c_add_adapter(&alg_data->adapter);
> >  	if (ret < 0) {
> 
> If i2c_add_numbered_adapter isn't used, the alg_data->adapter.nr value
> will be re-assigned in the i2c-core driver.

This is the result of fixing the merge between my changes and your
155a493 change.

It highlights the problem of merge conflicts - it's very difficult
with the cvs/git conflict marking to work out what the right fixes for
any conflict is, especially when you aren't the author of both sets of
changes.  The problem is that you're given the original version and
your version to look at, and the problem comes when the right resolution
is to take a subset of lines from both versions.

I continue to absolutely detest git conflicts, and I suspect that's
never going to change.

Fixed now to use i2c_add_numbered_adapter() again.
