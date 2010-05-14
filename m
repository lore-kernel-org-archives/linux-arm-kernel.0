From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 14 May 2010 10:00:00 +0100
Subject: [PATCH v2 10/11] ARM: SAMSUNG: Remove the TYPE and replace
	it with a Feature
In-Reply-To: <3932674.42191273825061253.JavaMail.weblogic@epml22>
References: <3932674.42191273825061253.JavaMail.weblogic@epml22>
Message-ID: <20100514090000.GD27571@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 08:17:41AM +0000, NAVEEN KRISHNA CHATRADHI wrote:
> Hi Ben, 
> ------- Original Message -------
> Sender : Ben Dooks<ben@trinity.fluff.org> 
> Date   : May 14, 2010 12:38 (GMT+05:00)
> Title  : Re: [PATCH v2 10/11] ARM: SAMSUNG: Remove the TYPE and replace it	with
>  a Feature
> 
> On Fri, May 14, 2010 at 04:25:23PM +0900, Kukjin Kim wrote:
> > From: Naveen Krishna <ch.naveen@samsung.com>
> > 
> > This patch makes changes in the core files to remove the TYPE
> > and replace it with a Feature bit field instead.
> 
> not quite what I had in mind, I was just considering replacing the
> TYPE_S3C in the device_id_table with a features flag in the driver
> itself, and not altering any of the platform data.
> According to your comment on the previous patchset, this was my 
> understanding.  Now, if my understanding is right. 
> You mean to say, keep the ts_device.name in plat & TYPEs in driver
> same & based on the device.name given by machine set the FEATURE bit
> and use it. 
> 
> But, What would happen if the SoC supports 2 or more features.
> like one IRQ, 2 TS I/F, Etc then we need to add more Feature bit isit. 
> and making these changes in Driver would make the driver complex.

not really, the features area a bitfield eeach part of the driver can
check when doing a function that may be changed.

By the way, I don't think the TS driver actually needs to worry a lot
about whether it has 2 TS interfaces, since most of that will need to
be handled by the ADC layer.
 
> Instead i added a feature field in the IP_Info structure and enabling it 
> based on Machine.
>
> Some misunderstanding, Could you please elloborate. 
> 
> Note, platform data really should be for the per-board information
> not for soc info... I'm sort of sorry now that we ended up passing
> a pile of what I now belive to be SoC specific data for the SDHCI
> block via the platform-data, it only makes life difficult for everyone
> else.
>  
> > Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > 
> > This 2 new patches which require the previous 9 patches to be applied. (0010 & 0011)
> > This patch set of 9 patches contains core changes & driver changes into seperate patches.
> > The 2 new patches would remove the TYPE from the core and driver file and replace it with 
> > Feature field as suggested by Ben Dooks.
> > 
> >  arch/arm/mach-s3c64xx/mach-smdk6410.c   |    1 +
> >  arch/arm/mach-s3c64xx/s3c6410.c         |    1 -
> >  arch/arm/mach-s5p6440/cpu.c             |    1 -
> >  arch/arm/mach-s5p6440/mach-smdk6440.c   |    1 +
> >  arch/arm/mach-s5pv210/cpu.c             |    1 -
> >  arch/arm/mach-s5pv210/mach-smdkv210.c   |    1 +
> >  arch/arm/plat-samsung/dev-ts.c          |    1 +
> >  arch/arm/plat-samsung/include/plat/ts.h |    1 +
> >  8 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > index fb186c9..a8ead39 100644
> > --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > @@ -604,6 +604,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> >  	.delay			= 10000,
> >  	.presc			= 49,
> >  	.oversampling_shift	= 2,
> > +	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
> >  };
> >  
> >  static void __init smdk6410_map_io(void)
> > diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
> > index 4390ecb..31e53fa 100644
> > --- a/arch/arm/mach-s3c64xx/s3c6410.c
> > +++ b/arch/arm/mach-s3c64xx/s3c6410.c
> > @@ -55,7 +55,6 @@ void __init s3c6410_map_io(void)
> >  
> >  	s3c_device_adc.name      = "s3c64xx-adc";
> >  	s3c_device_nand.name = "s3c6400-nand";
> > -	s3c_device_ts.name	= "s3c64xx-ts";
> >  }
> >  
> >  void __init s3c6410_init_clocks(int xtal)
> > diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
> > index e461955..78c0e47 100644
> > --- a/arch/arm/mach-s5p6440/cpu.c
> > +++ b/arch/arm/mach-s5p6440/cpu.c
> > @@ -61,7 +61,6 @@ static void s5p6440_idle(void)
> >  void __init s5p6440_map_io(void)
> >  {
> >  	/* initialize any device information early */
> > -	s3c_device_ts.name      = "s3c64xx-ts";
> >  	s3c_device_adc.name	= "s3c64xx-adc";
> >  }
> >  
> > diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
> > index 177701b..afb53b1 100644
> > --- a/arch/arm/mach-s5p6440/mach-smdk6440.c
> > +++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
> > @@ -94,6 +94,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> >  	.delay			= 10000,
> >  	.presc			= 49,
> >  	.oversampling_shift	= 2,
> > +	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
> >  };
> >  
> >  static void __init smdk6440_map_io(void)
> > diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> > index dd3dcca..8391342 100644
> > --- a/arch/arm/mach-s5pv210/cpu.c
> > +++ b/arch/arm/mach-s5pv210/cpu.c
> > @@ -74,7 +74,6 @@ static void s5pv210_idle(void)
> >  
> >  void __init s5pv210_map_io(void)
> >  {
> > -	s3c_device_ts.name      = "s5pv210-ts";
> >  	s3c_device_adc.name	= "s3c64xx-adc";
> >  
> >  	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
> > diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
> > index 1440cb2..a0b0a67 100644
> > --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> > +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> > @@ -82,6 +82,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> >  	.delay			= 10000,
> >  	.presc			= 49,
> >  	.oversampling_shift	= 2,
> > +	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
> >  };
> >  
> >  static void __init smdkv210_map_io(void)
> > diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
> > index 8d7cefb..7571691 100644
> > --- a/arch/arm/plat-samsung/dev-ts.c
> > +++ b/arch/arm/plat-samsung/dev-ts.c
> > @@ -13,6 +13,7 @@
> >  
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/slab.h>
> >  
> >  #include <mach/map.h>
> >  #include <mach/irqs.h>
> > diff --git a/arch/arm/plat-samsung/include/plat/ts.h b/arch/arm/plat-samsung/include/plat/ts.h
> > index 26fdb22..82c0eaf 100644
> > --- a/arch/arm/plat-samsung/include/plat/ts.h
> > +++ b/arch/arm/plat-samsung/include/plat/ts.h
> > @@ -14,6 +14,7 @@ struct s3c2410_ts_mach_info {
> >         int             delay;
> >         int             presc;
> >         int             oversampling_shift;
> > +	int	feature;
> >  	void    (*cfg_gpio)(struct platform_device *dev);
> >  };
> >  
> > -- 
> > 1.6.2.5
> > 
> 
> -- 
> -- 
> Ben
> 
> Q:      What's a light-year?
> A:      One-third less calories than a regular year.
> 
> 
> 
> Thanks & Best Regards,
> Naveen Krishna Ch
> SE @ SLG Div, DS LABs, Samsung, India.

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
