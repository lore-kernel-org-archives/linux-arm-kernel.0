From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Mar 2012 09:08:32 +0100
Subject: [PATCH 1/3] ARM i.MX: Move i.MX pwm driver to pwm framework
In-Reply-To: <20120316074902.GC7758@S2101-09.ap.freescale.net>
References: <1331802277-12477-1-git-send-email-s.hauer@pengutronix.de>
 <1331802277-12477-2-git-send-email-s.hauer@pengutronix.de>
 <20120316074902.GC7758@S2101-09.ap.freescale.net>
Message-ID: <20120316080832.GA6458@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> On Thu, Mar 15, 2012 at 10:04:35AM +0100, Sascha Hauer wrote:
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index e859c51..fc7571e 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -1,4 +1,5 @@
> >  obj-$(CONFIG_PWM)		+= core.o
> >  obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
> > +obj-$(CONFIG_PWM_IMX)		+= imx-pwm.o
> 
> s/imx-pwm.o/pwm-imx.o

Yes, I'll make that change when I integrate the patch in my series.

> > @@ -98,7 +98,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> >  		else
> >  			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
> >  
> > -		writel(cr, pwm->mmio_base + MX3_PWMCR);
> > +		writel(cr, imxpwm->mmio_base + MX3_PWMCR);
> >  	} else if (cpu_is_mx1() || cpu_is_mx21()) {
> 
> Since we are here, can we move one step further to get rid of these
> cpu_is_xxx()?  Then, we can remove <mach/hardware.h> inclusion from
> the driver.

I guess this could be handled by using several names for the driver and
handling the differences using a table of platform_device_id:s. Perhaps
you had something different in mind?

> >  static int __devinit mxc_pwm_probe(struct platform_device *pdev)
> 
> Should we take this opportunity to rename the driver from mxc_pwm to
> imx_pwm?

If we decide to rename maybe it should be done in two steps. First it can be
renamed internally and in the second step the name could be changed along
with all users. I just want to avoid too much churn in this series, which is
already growing way larger than I had hoped.

> Also, does mxc_pwm_init need necessarily to be an arch_initcall?
> Otherwise, we can have the following change.
> 
> -static int __init mxc_pwm_init(void)
> -{
> -       return platform_driver_register(&mxc_pwm_driver);
> -}
> -arch_initcall(mxc_pwm_init);
> -
> -static void __exit mxc_pwm_exit(void)
> -{
> -       platform_driver_unregister(&mxc_pwm_driver);
> -}
> -module_exit(mxc_pwm_exit);
> +module_platform_driver(imx_pwm_driver);

I assume that some platforms may require it to be initialized early because
other drivers may depend on the PWMs being present. However this can probably
be solved in a much better way by using deferred driver probing, which should
be available in 3.4.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/12a171b8/attachment.sig>
