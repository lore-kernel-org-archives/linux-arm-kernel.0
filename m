From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 21 Sep 2011 15:04:02 +0200
Subject: [PATCH 2/7] s3c-adc: describe features via quirk constants
In-Reply-To: <005801cc785a$7e46a310$7ad3e930$%kim@samsung.com>
References: <201109182241.48858.heiko@sntech.de>
	<201109182243.40440.heiko@sntech.de>
	<005801cc785a$7e46a310$7ad3e930$%kim@samsung.com>
Message-ID: <201109211504.03287.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 21. September 2011, 14:32:14 schrieben Sie:
> Heiko St?bner wrote:
> > The adc blocks of S3C2410 through S5P have a multitude of
> > quirks, i.e. moved bits or whole new registers.
> > 
> > This patch tries to describe these individual features
> > through constants which can be used to describe an adc.
> > 
> > As SoCs sometimes share only some of these quirks defining
> > TYPE_ADCVx values for each one wouldn't scale well when
> > adding more variants.
> 
> Hi Heiko,
> 
> I don't have idea we really need to use QUIRK in this case...as I know, the
> QUIRK is used on other situation...
> 
> In addition, the TYPE_ADCVx can support each Samsung SoCs' ADC...but I need
> to check again.
The current types could not support the features of the 2443 and 2416/2450 - I 
checked the datasheets.

The mux register in base+0x18 does not exist on any of the current platforms.
Also the bit 3 in ADCCON to select the resolution is specific to the 2416/2450 
(see comments above constants and quirk definitions in patches 6 and 7).

So to support these SoCs would require the definition of two new types. 
Including these new types in the existing conditionals would introduce a lot 
of statements like
	if ( (TYPE_X || TYPE_Y) && !TYPE_Z)

In my opinion testing for specific features also describes the difference 
between implementations better if one reads the code later on.


I will change the styling of the "<<"s but am wondering why checkpatch did not 
complain, i.e. it complains for all other whitespace mistakes one can make but 
not these.

Heiko

> 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/plat-samsung/adc.c |   29 +++++++++++++++++++++++++++++
> >  1 files changed, 29 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> > index ee8deef..b209d58 100644
> > --- a/arch/arm/plat-samsung/adc.c
> > +++ b/arch/arm/plat-samsung/adc.c
> > @@ -45,6 +45,35 @@ enum s3c_cpu_type {
> > 
> >  	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
> >  
> >  };
> > 
> > +/*
> > + * Resolution of the ADC - 10 or 12 bit
> > + */
> 
> /* ... */
> 
> > +#define S3C_ADC_QUIRK_10BIT		0
> > +#define S3C_ADC_QUIRK_12BIT		(1<<0)
> 
> According to coding style, should be added blank around <<.
> 
> > +
> > +/*
> > + * 12bit ADC can switch resolution between 10 bit and 12 bit
> > + * ADCCON bit 03 for S3C2416
> > + * ADCCON bit 16 for S3C64XX and up
> > + */
> > +#define S3C_ADC_QUIRK_RESSEL03		(1<<1)
> > +#define S3C_ADC_QUIRK_RESSEL16		(1<<2)
> 
> Same as above.
> 
> > +
> > +/*
> > + * Input channel select can either be in
> > + * - reg ADCCON, bit for S3C24XX and S3C64XX
> > + * - reg base+0x18 for 2443/2416/2450
> > + * - reg base+0x1C for S5P
> > + */
> > +#define S3C_ADC_QUIRK_MUXADCCON		(1<<3)
> > +#define S3C_ADC_QUIRK_MUX18		(1<<4)
> > +#define S3C_ADC_QUIRK_MUX1C		(1<<5)
> 
> Same.
> 
> > +
> > +/*
> > + * CLRINT register on S3C64xx
> > + */
> 
> /* ... */
> 
> > +#define S3C_ADC_QUIRK_CLRINT		(1<<6)
> 
> Same.
> 
> > +
> > 
> >  struct s3c_adc_client {
> >  
> >  	struct platform_device	*pdev;
> >  	struct list_head	 pend;
> > 
> > --
> > 1.7.2.3
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
