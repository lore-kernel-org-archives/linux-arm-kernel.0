From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 00:10:40 +0200
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
Message-ID: <20120613221040.GJ30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, Jun 12, 2012 at 11:57:07AM +0100, viresh kumar wrote:
> Hi Paul/Russell,
> 
> On Wed, May 23, 2012 at 12:46 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > Hi Viresh,
> >
> > The above listed commit, in linux-next as:
> >
> > commit ebbf0cb5d39cc3e22ef4c425475e76b7f45027de
> >
> > ? ?"clk: add non CONFIG_HAVE_CLK routines"
> >
> > shows up as failures in the netx_defconfig, since there
> > are duplicate stub functions between your changes and the
> > file below:
> >
> > ?arch/arm/mach-netx/fb.c:72:6: error: redefinition of 'clk_disable'
> > ?include/linux/clk.h:299:51: note: previous definition of 'clk_disable' was here
> > ?arch/arm/mach-netx/fb.c:76:5: error: redefinition of 'clk_set_rate'
> > ?include/linux/clk.h:306:50: note: previous definition of 'clk_set_rate' was here
> > ?arch/arm/mach-netx/fb.c:81:5: error: redefinition of 'clk_enable'
> > ?include/linux/clk.h:294:50: note: previous definition of 'clk_enable' was here
> > ?arch/arm/mach-netx/fb.c:86:13: error: redefinition of 'clk_get'
> > ?include/linux/clk.h:280:58: note: previous definition of 'clk_get' was here
> > ?arch/arm/mach-netx/fb.c:91:6: error: redefinition of 'clk_put'
> > ?include/linux/clk.h:290:51: note: previous definition of 'clk_put' was here
> > ?make[2]: *** [arch/arm/mach-netx/fb.o] Error 1
> 
> Following are present in mach-netx/fb.c:
> 
> 
> void clk_disable(struct clk *clk)
> {
> }
> 
> int clk_set_rate(struct clk *clk, unsigned long rate)
> {
> 	return 0;
> }
> 
> int clk_enable(struct clk *clk)
> {
> 	return 0;
> }
> 
> void clk_put(struct clk *clk)
> {
> }
> 
> struct clk *clk_get(struct device *dev, const char *id)
> {
> 	return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> }
> 
> I can remove first four without any issues, but just can't remove the last one.
> The dummy clk_get() always returns NULL, whereas this one returns NULL only for
> fb device.
> 
> How should I fix this?

As the netx does not have fb support in mainline you can just drop this
one aswell. It has no use.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
