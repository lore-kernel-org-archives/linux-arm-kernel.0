From: avinashhm@ti.com (Avinash.H.M.)
Date: Tue, 31 May 2011 00:56:45 +0530
Subject: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
In-Reply-To: <1306737490.2117.24.camel@deskari>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
	<1306737490.2117.24.camel@deskari>
Message-ID: <20110530192645.GB4959@avinash-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 09:38:10AM +0300, Tomi Valkeinen wrote:
> On Fri, 2011-05-20 at 21:16 +0530, Avinash.H.M wrote:
> > The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> > special sequence to reset the module. The sequence is
> >  - Disable the I2C.
> >  - Write to SOFTRESET bit.
> >  - Enable the I2C.
> >  - Poll on the RESETDONE bit.
> > The sequence is implemented as a function and the i2c_class is updated with
> > the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> > which triggers the softreset by writing into sysconfig register. On following
> > this sequence, i2c module resets properly and timeouts are not seen.
> > 
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> > ---
> 
> <snip>
> 
> > diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
> > index 878d632..3ffb94e 100644
> > --- a/arch/arm/plat-omap/include/plat/i2c.h
> > +++ b/arch/arm/plat-omap/include/plat/i2c.h
> > @@ -23,6 +23,8 @@
> >  
> >  #include <linux/i2c.h>
> >  
> > +#include <plat/omap_hwmod.h>
> > +
> >  #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
> >  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
> >  				 struct i2c_board_info const *info,
> > @@ -52,4 +54,6 @@ struct omap_i2c_dev_attr {
> >  void __init omap1_i2c_mux_pins(int bus_id);
> >  void __init omap2_i2c_mux_pins(int bus_id);
> >  
> > +int omap_i2c_reset(struct omap_hwmod *oh);
> > +
> 
> It's not necessary to include omap_hwmod.h, just declare
> 
> struct omap_hwmod;

Hi Tomi ,

I agree to the comment, since it is a header file (i2c.h), no need to
include hwmod.h.  

I ll drop the file inclusion.  Thanks for reviewing.

B R ,

- Avinash


> 
>  Tomi
> 
> 
