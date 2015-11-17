From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 11:19:51 +0100
Subject: [PATCH 2/3] ASoC: s3c24xx-i2s: pass DMA channels as platform data
In-Reply-To: <564A84AE.2000502@samsung.com>
References: <5466463.9HBcuLFGQf@wuerfel> <4171669.Y8FyLG5WLL@wuerfel>
 <564A84AE.2000502@samsung.com>
Message-ID: <5663555.neFjt3nUNJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 10:36:46 Krzysztof Kozlowski wrote:
> On 14.11.2015 02:23, Arnd Bergmann wrote:
> > This is a minor cleanup to make the s3c2412-i2s and s3c24xx-i2s
> > drivers independent of the mach/dma.h header file and to allow
> > removing the dependency on the specific dmaengine driver in the
> > next patch.
> > 
> > As a side not, only the s3c24xx-i2s driver seems to still be
> > used, while the definition of the s3c2412-i2s platform device was
> > removed in commit 6d259a25b56d ("ARM: SAMSUNG: use static
> > declaration when it is not used in other files") after it had
> > never been referenced since its introduction in f0fba2ad1b6b
> > ("ASoC: multi-component - ASoC Multi-Component Support").
> > 
> > Apparently it should have been used by mach-jive.c, but that
> > never happened. My patch at this point leaves the current state
> > unchanged, we can decide whether to fix or delete the jive
> > driver and s3c2412-i2s another time.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> > index 3ce234f4c872..e5e91669dd2b 100644
> > --- a/arch/arm/plat-samsung/devs.c
> > +++ b/arch/arm/plat-samsung/devs.c
> > @@ -571,6 +571,11 @@ static struct resource s3c_iis_resource[] = {
> >  	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
> >  };
> >  
> > +static struct s3c_audio_pdata s3c_iis_platdata = {
> > +	.dma_playback = (void *)DMACH_I2S_OUT,
> > +	.dma_capture = (void *)DMACH_I2S_IN,
> 
> Why casting? Is it needed?

s3c64xx uses strings here, but s3c24xx uses integer indexes into an array.
I thought about changing the indexes to direct pointers to entries in
the array, but decided to leave that for another day.

> > @@ -454,6 +454,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
> >  {
> >  	int ret = 0;
> >  	struct resource *res;
> > +	struct s3c_audio_pdata *pdata = dev_get_platdata(&pdev->dev);
> 
> Maybe:
> if (!pdata) {
> 	pr_err("bla bla bla");
> 	return -EINVAL;
> }

Yes, that might be helpful in case there are any out of tree users, or
I missed one of the in-tree users.

	Arnd
