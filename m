From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 17 Dec 2014 17:16:43 +0100
Subject: [PATCH] ARM: SAMSUNG: remove dead #elif CONFIG_S3C24XX_DMAC
In-Reply-To: <1921250.jGHJ6gZqGf@wuerfel>
References: <1418830837-7422-1-git-send-email-stefan.hengelein@fau.de>
 <1921250.jGHJ6gZqGf@wuerfel>
Message-ID: <2864831.LEPnyFh3Il@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Dezember 2014, 16:52:40 schrieb Arnd Bergmann:
> On Wednesday 17 December 2014 16:40:37 Stefan Hengelein wrote:
> > The corresponding CPP-block can never be selected since there are
> > conflicting Kconfig constraints:
> > - CONFIG_S3C24XX_DMAC has a dependency on ARCH_S3C24XX
> > - The surrounding CPP-block needs CONFIG_S3C64XX_DEV_SPI0 to be defined.
> > 
> >   - CONFIG_S3C64XX_DEV_SPI0 is only selected by MACH_WLF_CRAGG_6410
> >   - MACH_WLF_CRAGG_6410 however has a dependency on ARCH_S3C64XX
> >   
> >     (through a surrounding if-statement in Kconfig)
> > 
> > - ARCH_S3C64XX and ARCH_S3C24XX are mutually exclusive since they are
> > 
> >   declared in the same choice and cannot be enabled at the same time.
> > 
> > Hence, the innner block
> > 
> >     "#elif defined(CONFIG_S3C24XX_DMAC)"
> > 
> > cannot be enabled at the same time with the surrounding block
> > 
> >     "#ifdef CONFIG_S3C64XX_DEV_SPI0"
> > 
> > and therefore is dead.
> > 
> > This (logical) defect has been found with the undertaker tool
> > (https://undertaker.cs.fau.de)
> 
> Nice catch!
> 
> > Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
> > ---
> > 
> >  arch/arm/plat-samsung/devs.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> > index 83c7d15..b38b601 100644
> > --- a/arch/arm/plat-samsung/devs.c
> > +++ b/arch/arm/plat-samsung/devs.c
> > @@ -1134,8 +1134,6 @@ void __init s3c64xx_spi0_set_platdata(int
> > (*cfg_gpio)(void), int src_clk_nr,> 
> >  	pd.filter = pl330_filter;
> >  
> >  #elif defined(CONFIG_S3C64XX_PL080)
> >  
> >  	pd.filter = pl08x_filter_id;
> > 
> > -#elif defined(CONFIG_S3C24XX_DMAC)
> > -	pd.filter = s3c24xx_dma_filter;
> > 
> >  #endif
> >  
> >  	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
> 
> This was introduced in 7f99ef2284b46f ("ARM: SAMSUNG: set
> s3c24xx_dma_filter for s3c64xx-spi0 device"), but never used on s3c24xx as
> far as I can tell. Heiko, can you comment on the patch? Did this
> simply get obsoleted by the DT conversion of s3c2416 and s3c2443?

We just have no in-tree users currently.

The S3C2416 and S3C2450 use the same type of spi controllers as the s3c64xx. 
When writing the s3c24xx dma driver I also used this to test the driver. The 
change was necessary to make the driver talk to my s3c2416 device, so it made 
sense at the time.

As the s3c24xx-dma driver currently is still lacking dt support [burried 
somewhere on my todo list], board files are also currently the only way to do 
fast spi on those at all.

So removing this is dependent on how hard we want to make it for downstream 
users [there seem to be a small number of those]. If this were part of 
removing all non-dt cruft from the driver after s3c64xx migrated to be dt-only 
I wouldn't object, but as it only affects the 2 lines of s3c24xx support, 
personally I'd like to keep it around :-) .


Heiko
