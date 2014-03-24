From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Mar 2014 19:41:14 +0100
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <20140324170131.GB7524@katana>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
Message-ID: <20140324184114.GK23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
> > @@ -0,0 +1,34 @@
> > +* Energymicro efm32 i2c controller
> > +
> > +Required properties :
> > +
> > + - reg : Offset and length of the register set for the device
> > + - compatible : should be "efm32,i2c"
> 
> Ehrm, come to think of it, shouldn't that actually be "energymicro, efm32-i2c"
> or similar to match the "vendor,product" pattern?
yes.

> 
> > +config I2C_EFM32
> > +	tristate "EFM32 I2C controller"
> > +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)
> 
> Is EFM32 DT only? Do we need the dependency on OF?
yes, efm32 is DT only. Still for the COMPILE_TEST branch the OF is
needed.
 
> > +	help
> > +	  This driver supports the i2c block found in Energy Micro's EFM32
> > +	  SoCs.
> > +
> 
> ...
> 
> > +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> > +		struct i2c_msg *msgs, int num)
> > +{
> > +	struct efm32_i2c_ddata *ddata = i2c_get_adapdata(adap);
> > +	int ret;
> > +
> > +	if (ddata->msgs)
> > +		return -EBUSY;
> > +
> > +	ddata->msgs = msgs;
> > +	ddata->num_msgs = num;
> > +	ddata->current_word = 0;
> > +	ddata->current_msg = 0;
> > +	ddata->retval = -EIO;
> > +
> > +	reinit_completion(&ddata->done);
> > +
> > +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> > +			efm32_i2c_read32(ddata, REG_STATE),
> > +			efm32_i2c_read32(ddata, REG_STATUS));
> > +
> > +	efm32_i2c_send_next_msg(ddata);
> > +
> > +	wait_for_completion(&ddata->done);
> > +
> > +	if (ddata->current_msg >= ddata->num_msgs)
> > +		ret = ddata->num_msgs;
> > +	else
> > +		ret = ddata->retval;
> > +
> > +	ddata->msgs = NULL;
> 
> Setting NULL should not be needed?
Right, that's a left over from the locking stuff.
 
> > +
> > +	return ret;
> > +}
> > +
> 
> And checkpatch said:
> 
> WARNING: braces {} are not necessary for any arm of this statement
> #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> +		if (cur_msg->flags & I2C_M_RD) {
> ...
ok.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
