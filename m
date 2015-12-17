From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 20:57:04 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <20151217194016.GD1530@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <7947081.psvz6dklxq@wuerfel> <20151217194016.GD1530@katana>
Message-ID: <7990730.tNeXHUrIig@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 20:40:17 Wolfram Sang wrote:
> > > My conclusion for now is:
> > > 
> > > There needs something to be done surely, but currently I don't have the
> > > bandwidth to do it or even play around with it. I am not fully happy
> > > with your patches as well because __maybe_unused has some kind of "last
> > > resort" feeling to me.
> > 
> > I generally like __maybe_unused, but it's a matter of personal preference.
> > We could avoid the __maybe_unused if the reg_slave/unreg_slave callback
> > pointers are always available in struct i2c_algorithm.
> 
> Yes, I was thinking in this direction, looking at how PM does it. Needs
> some playing around, though.

I think PM gets it slightly wrong, the way you have to use #ifdef leads
to subtle bugs all the time, and I actually have a patch that converts
a few dozen drivers to use __maybe_unused to shut up build warnings and
errors.

What you can do though is to use a reference like

#define __i2c_slave_ptr(x) (IS_ENABLED(CONFIG_I2C_SLAVE) ? (x) : NULL)

	...
	.reg_slave = __i2c_slave_ptr(em_i2c_reg_slave),
	.unreg_slave = __i2c_slave_ptr(em_i2c_unreg_slave),
	...

This has the same effect as the __maybe_unused annotation.

	Arnd
