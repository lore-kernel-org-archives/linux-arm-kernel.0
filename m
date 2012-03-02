From: jason@lakedaemon.net (Jason)
Date: Fri, 2 Mar 2012 11:27:38 -0500
Subject: [PATCH 3/4] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <20120302071939.A1BE83E2D8A@localhost>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2c985a303f3b9b0cfcead25634b7e1db68d34ee3.1330625878.git.jason@lakedaemon.net>
 <20120302071939.A1BE83E2D8A@localhost>
Message-ID: <20120302162738.GH11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 01:19:39AM -0600, Grant Likely wrote:
> On Thu,  1 Mar 2012 18:20:54 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> > The comment at mach-kirkwood/common.c:469, says this device is in every
> > kirkwood board.  So, it is placed in kirkwood.dtsi.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  arch/arm/boot/dts/kirkwood.dtsi   |    6 ++++++
> >  arch/arm/mach-kirkwood/board-dt.c |    1 -
> >  arch/arm/mach-kirkwood/common.c   |    2 +-
> >  arch/arm/mach-kirkwood/common.h   |    1 -
> >  drivers/rtc/rtc-mv.c              |   19 +++++++++++++++++++
> >  5 files changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> > index 771c6bb..5fb185c 100644
> > --- a/arch/arm/boot/dts/kirkwood.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood.dtsi
> > @@ -2,5 +2,11 @@
> >  
> >  / {
> >  	compatible = "marvell,kirkwood";
> > +
> > +	rtc at f1010300 {
> > +		compatible = "marvell,rtc";
> > +		reg = <0xf1010300 0x1f>;
> > +		interrupts = <53>;
> > +	};
> >  };
> >  
> > diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > index a0cc28b..6fc41ae 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -135,7 +135,6 @@ static void __init kirkwood_dt_init(void)
> >  #endif
> >  
> >  	/* internal devices that every board has */
> > -	kirkwood_rtc_init();
> >  	kirkwood_wdt_init();
> >  	kirkwood_xor0_init();
> >  	kirkwood_xor1_init();
> > diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> > index 167b6c8..0c0375f 100644
> > --- a/arch/arm/mach-kirkwood/common.c
> > +++ b/arch/arm/mach-kirkwood/common.c
> > @@ -163,7 +163,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
> >  /*****************************************************************************
> >   * SoC RTC
> >   ****************************************************************************/
> > -void __init kirkwood_rtc_init(void)
> > +static void __init kirkwood_rtc_init(void)
> 
> This undoes the code changed in the previous patch.  If you reorder the patches then
> this change goes away in both.

My goal was to make sure the series could compile with and without fdt
no matter where a bisect might land in the series.  What would cause a
reorder?

> >  {
> >  	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
> >  }
> > diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> > index c382447..ca08826 100644
> > --- a/arch/arm/mach-kirkwood/common.h
> > +++ b/arch/arm/mach-kirkwood/common.h
> > @@ -53,7 +53,6 @@ void kirkwood_restart(char, const char *);
> >  
> >  char *kirkwood_id(void);
> >  void kirkwood_l2_init(void);
> > -void kirkwood_rtc_init(void);
> >  void kirkwood_wdt_init(void);
> >  void kirkwood_xor0_init(void);
> >  void kirkwood_xor1_init(void);
> > diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> > index 768e2ed..38abbf7 100644
> > --- a/drivers/rtc/rtc-mv.c
> > +++ b/drivers/rtc/rtc-mv.c
> > @@ -12,6 +12,8 @@
> >  #include <linux/bcd.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of.h>
> >  #include <linux/delay.h>
> >  #include <linux/gfp.h>
> >  #include <linux/module.h>
> > @@ -218,10 +220,15 @@ static int __devinit mv_rtc_probe(struct platform_device *pdev)
> >  {
> >  	struct resource *res;
> >  	struct rtc_plat_data *pdata;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	resource_size_t size;
> >  	u32 rtc_time;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	if (np)
> > +		of_address_to_resource(np, 0, res);
> > +
> 
> This should not be needed.  The of_platform_populate() code should have
> filled the platform_device with mem resources.

fixed in next version.

> >  	if (!res)
> >  		return -ENODEV;
> >  
> > @@ -257,6 +264,8 @@ static int __devinit mv_rtc_probe(struct platform_device *pdev)
> >  
> >  	pdata->irq = platform_get_irq(pdev, 0);
> >  
> > +	of_property_read_u32(np, "interrupts", &pdata->irq);
> > +
> 
> Definitely don't do this.  Same as with memory regions, the irq will be
> pre-populated in the platform device resource table.  platform_get_irq()
> should already work.

Same.

> >  	platform_set_drvdata(pdev, pdata);
> >  
> >  	if (pdata->irq >= 0) {
> > @@ -294,11 +303,21 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct of_device_id rtc_mv_of_match_table[] = {
> > +	{ .compatible = "marvell,rtc", },
> > +	{}
> > +};
> > +#else
> > +#define rtc_mv_of_match_table NULL
> > +#endif
> > +
> >  static struct platform_driver mv_rtc_driver = {
> >  	.remove		= __exit_p(mv_rtc_remove),
> >  	.driver		= {
> >  		.name	= "rtc-mv",
> >  		.owner	= THIS_MODULE,
> > +		.of_match_table = rtc_mv_of_match_table,
> 
> should be:
> 		.of_match_table = of_match_ptr(rtc_mv_of_match_table),
> 
> that would get rid of the #else clause above.

fixed across kirkwood patches so far.

Thanks for the review.

Jason.
