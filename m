From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Mar 2012 10:27:39 +0100
Subject: [PATCH 1/3] ARM i.MX: Move i.MX pwm driver to pwm framework
In-Reply-To: <20120316081748.GF7758@S2101-09.ap.freescale.net>
References: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
 <1331802277-12477-2-git-send-email-s.hauer@pengutronix.de>
 <20120316074902.GC7758@S2101-09.ap.freescale.net>
 <20120316080832.GA6458@avionic-0098.mockup.avionic-design.de>
 <20120316081748.GF7758@S2101-09.ap.freescale.net>
Message-ID: <20120316092739.GH3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 04:17:51PM +0800, Shawn Guo wrote:
> On Fri, Mar 16, 2012 at 09:08:32AM +0100, Thierry Reding wrote:
> > * Shawn Guo wrote:
> > > On Thu, Mar 15, 2012 at 10:04:35AM +0100, Sascha Hauer wrote:
> > > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > > index e859c51..fc7571e 100644
> > > > --- a/drivers/pwm/Makefile
> > > > +++ b/drivers/pwm/Makefile
> > > > @@ -1,4 +1,5 @@
> > > >  obj-$(CONFIG_PWM)		+= core.o
> > > >  obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
> > > > +obj-$(CONFIG_PWM_IMX)		+= imx-pwm.o
> > > 
> > > s/imx-pwm.o/pwm-imx.o
> > 
> > Yes, I'll make that change when I integrate the patch in my series.
> > 
> Thanks for taking this on.
> 
> > > > @@ -98,7 +98,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> > > >  		else
> > > >  			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
> > > >  
> > > > -		writel(cr, pwm->mmio_base + MX3_PWMCR);
> > > > +		writel(cr, imxpwm->mmio_base + MX3_PWMCR);
> > > >  	} else if (cpu_is_mx1() || cpu_is_mx21()) {
> > > 
> > > Since we are here, can we move one step further to get rid of these
> > > cpu_is_xxx()?  Then, we can remove <mach/hardware.h> inclusion from
> > > the driver.
> > 
> > I guess this could be handled by using several names for the driver and
> > handling the differences using a table of platform_device_id:s. Perhaps
> > you had something different in mind?
> > 
> Same thing on my mind.
> 
> > > >  static int __devinit mxc_pwm_probe(struct platform_device *pdev)
> > > 
> > > Should we take this opportunity to rename the driver from mxc_pwm to
> > > imx_pwm?
> > 
> > If we decide to rename maybe it should be done in two steps. First it can be
> > renamed internally and in the second step the name could be changed along
> > with all users. I just want to avoid too much churn in this series, which is
> > already growing way larger than I had hoped.
> > 
> It seems I'm asking too much.  Okay, we can do that after it gets moved.

Indeed. The pwm driver became a horrible piece of code over time, it's
time to refactor it. I just wanted to make the move first, then look for
further cleanups.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
