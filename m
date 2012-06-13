From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jun 2012 05:04:58 -0700
Subject: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
In-Reply-To: <4FD6555D.4000508@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com>
Message-ID: <20120613120457.GO12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120611 13:34]:
> Hi Afzal,
> 
> On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> > A driver is being created out of GPMC code. This is being
> > attempted to acheive by not breaking existing interface,
> > necessitating requirement of GPMC peripherals being able
> > to work with as well as without the help of driver. To not
> > break existing, initcall is required as in old interface
> > GPMC is configured at arch initcall and GPMC should be
> > ready to handle old interface by that time
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |   19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index b471c2f..6dbddb9 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -902,7 +902,7 @@ postcore_initcall(gpmc_init);
> >  __init int omap_gpmc_init(struct gpmc_pdata *pdata)
> >  {
> >  	struct omap_hwmod *oh;
> > -	struct platform_device *pdev;
> > +	static struct platform_device *pdev;
> >  	char *name = "omap-gpmc";
> >  	char *oh_name = "gpmc";
> >  
> > @@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
> >  		return -ENODEV;
> >  	}
> >  
> > +	if (pdev != NULL) {
> > +		clk_put(gpmc_l3_clk);
> > +		omap_device_delete(pdev->archdata.od);
> > +		platform_device_unregister(pdev);
> > +	}
> > +
> 
> I am not sure if I am missing something, but it appears that pdev will
> always be NULL here as it is a local uninitialised variable.

This also creates a new warning:

arch/arm/mach-omap2/gpmc.c: In function ?gpmc_create_device?:
arch/arm/mach-omap2/gpmc.c:1434: warning: ?pdev? may be used uninitialized in this function

> Not sure I see the point in the above function. Why not declare the
> gpmc_device_data struct as static in the file and access it directly
> instead of passing it in omap_gpmc_init(). The postcore_init can then
> call omap_gpmc_init() directly.
> 
> Shouldn't the post_initcall be added in patch #4, when the driver is
> created?

There should no longer be any need to initialize GPMC early. It should
behave like any other device driver, and also work as a loadable module.

Regards,

Tony
