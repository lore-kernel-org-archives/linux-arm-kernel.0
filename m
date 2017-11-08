From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 08 Nov 2017 11:29:14 +0200
Subject: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <2970055.FM06l9ul3d@dabox>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509984581.25007.47.camel@linux.intel.com>
 <a0265848-2496-d347-a40f-ce83e7dfd945@electromag.com.au>
 <2970055.FM06l9ul3d@dabox>
Message-ID: <1510133354.25007.97.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-08 at 09:29 +0100, Tim Sander wrote:

> > > How do we switch pinctrl back to the native function? Is it
> > > guaranteed
> > > by pinctrl framework and all underneath drivers?
> > That is a good question. I don't have an understanding of how the
> > pinctrl
> > framework works with respect to requesting gpios.
> > My device (Intel / Altera Cyclone V SOC) doesn't have a pinctrl for
> > the i2c
> > / gpio mux as yet.
> 
> According to the documentation from Intel/Altera it is not allowed to
> change 
> the pinmux while running.

The driver is used on many platforms and requesting GPIO function while
running _is_ a pinmux change.

>  My guess is that they are using a shift chain, so 
> the output values of all pins in the chain are not stable. I think
> they have 
> been lazy and just used the io config for fpgas with an jtag
> controller and 
> connected the shift chain for pinconfig to this controller. So
> unfortunatly it 
> is not possible to switch single pins on the run without interfering
> with 
> other pins.

...for this certain SoC.

> > It's all setup by the bootloader and they don't expect
> > you to change it. I'm using two separate GPIO's "wired" to the i2c
> > bus via
> > the SOC FPGA for the recovery. Tim was doing the same.
> 
> Yes, i think thats the only way. But it is annoying that the i2c
> controllers 
> of 201x have no way to recover from such bus errors >:-(.

Yep, it's pity, and we need to cope somehow with it.

So, my understanding of the current case is that either this change goes in only for certain SoC(s), or waiting until there is a guarantee from pinctrl subsystem to return function to native back when recovery finished.

My personal vote is for latter.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
