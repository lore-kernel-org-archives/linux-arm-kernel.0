From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 02 Oct 2011 16:38:18 +0900
Subject: [PATCH 2/7] s3c-adc: describe features via quirk constants
In-Reply-To: <201109211504.03287.heiko@sntech.de>
References: <201109182241.48858.heiko@sntech.de>
	<201109182243.40440.heiko@sntech.de>
	<005801cc785a$7e46a310$7ad3e930$%kim@samsung.com>
	<201109211504.03287.heiko@sntech.de>
Message-ID: <001a01cc80d6$40bf7e70$c23e7b50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Hi,
> 
> Am Mittwoch, 21. September 2011, 14:32:14 schrieben Sie:
> > Heiko St?bner wrote:
> > > The adc blocks of S3C2410 through S5P have a multitude of
> > > quirks, i.e. moved bits or whole new registers.
> > >
> > > This patch tries to describe these individual features
> > > through constants which can be used to describe an adc.
> > >
> > > As SoCs sometimes share only some of these quirks defining
> > > TYPE_ADCVx values for each one wouldn't scale well when
> > > adding more variants.
> >
> > Hi Heiko,
> >
> > I don't have idea we really need to use QUIRK in this case...as I know,
the
> > QUIRK is used on other situation...
> >
> > In addition, the TYPE_ADCVx can support each Samsung SoCs' ADC...but I
> need
> > to check again.
> The current types could not support the features of the 2443 and 2416/2450
- I
> checked the datasheets.
> 
> The mux register in base+0x18 does not exist on any of the current
platforms.
> Also the bit 3 in ADCCON to select the resolution is specific to the
2416/2450
> (see comments above constants and quirk definitions in patches 6 and 7).
> 
> So to support these SoCs would require the definition of two new types.
> Including these new types in the existing conditionals would introduce a
lot
> of statements like
> 	if ( (TYPE_X || TYPE_Y) && !TYPE_Z)
> 
> In my opinion testing for specific features also describes the difference
> between implementations better if one reads the code later on.
> 
> 
> I will change the styling of the "<<"s but am wondering why checkpatch did
not
> complain, i.e. it complains for all other whitespace mistakes one can make
but
> not these.
> 

Hi Heiko,

How about following? I think following is also not bad...

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ee8deef..f5c6703 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -41,6 +41,8 @@
 
 enum s3c_cpu_type {
 	TYPE_ADCV1, /* S3C24XX */
+	TYPE_ADCV11, /* S3C2416 */
+	TYPE_ADCV12, /* S3C2443 */
 	TYPE_ADCV2, /* S3C64XX, S5P64X0, S5PC100 */
 	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
 };
@@ -98,13 +100,17 @@ static inline void s3c_adc_select(struct adc_device
*adc,
 
 	client->select_cb(client, 1);
 
-	con &= ~S3C2410_ADCCON_MUXMASK;
+	if (cpu == TYPE_ADCV1 || cpu == TYPE_ADCV2)
+		con &= ~S3C2410_ADCCON_MUXMASK;
 	con &= ~S3C2410_ADCCON_STDBM;
 	con &= ~S3C2410_ADCCON_STARTMASK;
 
 	if (!client->is_ts) {
 		if (cpu == TYPE_ADCV3)
 			writel(client->channel & 0xf, adc->regs +
S5P_ADCMUX);
+		elif (cpu == TYPE_ADCV12)
+			writel(client->channel & 0xf,
+				adc->regs + S3C2443_ADCMUX);
 		else
 			con |= S3C2410_ADCCON_SELMUX(client->channel);
 	}
@@ -293,13 +299,13 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 
 	client->nr_samples--;
 
-	if (cpu != TYPE_ADCV1) {
-		/* S3C64XX/S5P ADC resolution is 12-bit */
-		data0 &= 0xfff;
-		data1 &= 0xfff;
-	} else {
+	if (cpu == TYPE_ADCV1 || cpu == TYPE_ADCV12) {
 		data0 &= 0x3ff;
 		data1 &= 0x3ff;
+	} else {
+		/* S3C2416, S3C64XX/S5P ADC resolution is 12-bit */
+		data0 &= 0xfff;
+		data1 &= 0xfff;
 	}
 
 	if (client->convert_cb)
@@ -320,7 +326,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	}
 
 exit:
-	if (cpu != TYPE_ADCV1) {
+	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3) {
 		/* Clear ADC interrupt */
 		writel(0, adc->regs + S3C64XX_ADCCLRINT);
 	}
@@ -332,6 +338,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct adc_device *adc;
 	struct resource *regs;
+	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned tmp;
 
@@ -394,10 +401,13 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	clk_enable(adc->clk);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1) {
-		/* Enable 12-bit ADC resolution */
+
+	/* Enable 12-bit ADC resolution */
+	if (cpu == TYPE_ADCV11)
+		tmp |= S3C2416_ADCCON_RESSEL;
+	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
 		tmp |= S3C64XX_ADCCON_RESSEL;
-	}
+
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	dev_info(dev, "attached adc driver\n");
@@ -464,6 +474,7 @@ static int s3c_adc_resume(struct device *dev)
 	struct platform_device *pdev = container_of(dev,
 			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	enum s3c_cpu_type cpu = platform_get_device_id(pdev)->driver_data;
 	int ret;
 	unsigned long tmp;
 
@@ -474,9 +485,13 @@ static int s3c_adc_resume(struct device *dev)
 	enable_irq(adc->irq);
 
 	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
+
 	/* Enable 12-bit ADC resolution */
-	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1)
+	if (cpu == TYPE_ADCV11)
+		tmp |= S3C2416_ADCCON_RESSEL;
+	if (cpu == TYPE_ADCV2 || cpu == TYPE_ADCV3)
 		tmp |= S3C64XX_ADCCON_RESSEL;
+
 	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	return 0;
@@ -492,6 +507,12 @@ static struct platform_device_id s3c_adc_driver_ids[] =
{
 		.name           = "s3c24xx-adc",
 		.driver_data    = TYPE_ADCV1,
 	}, {
+		.name		= "s3c2416-adc",
+		.driver_data	= TYPE_ADCV11
+	}, {
+		.name		= "s3c2443-adc",
+		.driver_data	= TYPE_ADCV12
+	}, {
 		.name           = "s3c64xx-adc",
 		.driver_data    = TYPE_ADCV2,
 	}, {

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Heiko
> 
> >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >
> > >  arch/arm/plat-samsung/adc.c |   29 +++++++++++++++++++++++++++++
> > >  1 files changed, 29 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> > > index ee8deef..b209d58 100644
> > > --- a/arch/arm/plat-samsung/adc.c
> > > +++ b/arch/arm/plat-samsung/adc.c
> > > @@ -45,6 +45,35 @@ enum s3c_cpu_type {
> > >
> > >  	TYPE_ADCV3, /* S5PV210, S5PC110, EXYNOS4210 */
> > >
> > >  };
> > >
> > > +/*
> > > + * Resolution of the ADC - 10 or 12 bit
> > > + */
> >
> > /* ... */
> >
> > > +#define S3C_ADC_QUIRK_10BIT		0
> > > +#define S3C_ADC_QUIRK_12BIT		(1<<0)
> >
> > According to coding style, should be added blank around <<.
> >
> > > +
> > > +/*
> > > + * 12bit ADC can switch resolution between 10 bit and 12 bit
> > > + * ADCCON bit 03 for S3C2416
> > > + * ADCCON bit 16 for S3C64XX and up
> > > + */
> > > +#define S3C_ADC_QUIRK_RESSEL03		(1<<1)
> > > +#define S3C_ADC_QUIRK_RESSEL16		(1<<2)
> >
> > Same as above.
> >
> > > +
> > > +/*
> > > + * Input channel select can either be in
> > > + * - reg ADCCON, bit for S3C24XX and S3C64XX
> > > + * - reg base+0x18 for 2443/2416/2450
> > > + * - reg base+0x1C for S5P
> > > + */
> > > +#define S3C_ADC_QUIRK_MUXADCCON		(1<<3)
> > > +#define S3C_ADC_QUIRK_MUX18		(1<<4)
> > > +#define S3C_ADC_QUIRK_MUX1C		(1<<5)
> >
> > Same.
> >
> > > +
> > > +/*
> > > + * CLRINT register on S3C64xx
> > > + */
> >
> > /* ... */
> >
> > > +#define S3C_ADC_QUIRK_CLRINT		(1<<6)
> >
> > Same.
> >
> > > +
> > >
> > >  struct s3c_adc_client {
> > >
> > >  	struct platform_device	*pdev;
> > >  	struct list_head	 pend;
> > >
> > > --
> > > 1.7.2.3
> >
> > Thanks.
> >
> > Best regards,
> > Kgene.
> > --
> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> > SW Solution Development Team, Samsung Electronics Co., Ltd.
