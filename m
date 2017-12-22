From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Fri, 22 Dec 2017 10:17:55 +0100
Subject: [PATCH v5 06/11] thermal: armada: Add support for Armada AP806
In-Reply-To: <87zi6dg0e1.fsf@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
 <20171219135719.9531-7-miquel.raynal@free-electrons.com>
 <87zi6dg0e1.fsf@free-electrons.com>
Message-ID: <20171222101755.5b307299@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

On Wed, 20 Dec 2017 11:27:18 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On mar., d?c. 19 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > From: Baruch Siach <baruch@tkos.co.il>
> >
> > The AP806 component is integrated in the Armada 8K and 7K lines of
> > processors.
> >
> > The thermal sensor sample field on the status register is a signed
> > value. Extend armada_get_temp() and the driver structure to handle
> > signed values.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > [<miquel.raynal@free-electrons.com>: Changes when applying over the
> > previous patches, including the register names changes, also
> > switched the coefficients values to s64 instead of unsigned long to
> > deal with negative values and used do_div instead of the
> > traditionnal '/'] Signed-off-by: Miquel Raynal
> > <miquel.raynal@free-electrons.com> Reviewed-by: Gregory CLEMENT
> > <gregory.clement@free-electrons.com> ---
> >  drivers/thermal/armada_thermal.c | 74
> > ++++++++++++++++++++++++++++++++-------- 1 file changed, 59
> > insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c index ceebabf45c53..c7dcac39cbf9
> > 100644 --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -47,6 +47,11 @@
> >  #define CONTROL0_OFFSET			0x0
> >  #define CONTROL1_OFFSET			0x4
> >  
> > +/* TSEN refers to the temperature sensors within the AP */
> > +#define CONTROL0_TSEN_START		BIT(0)
> > +#define CONTROL0_TSEN_RESET		BIT(1)
> > +#define CONTROL0_TSEN_ENABLE		BIT(2)
> > +
> >  struct armada_thermal_data;
> >  
> >  /* Marvell EBU Thermal Sensor Dev Structure */
> > @@ -66,10 +71,11 @@ struct armada_thermal_data {
> >  	bool (*is_valid)(struct armada_thermal_priv *);
> >  
> >  	/* Formula coeficients: temp = (b - m * reg) / div */
> > -	unsigned long coef_b;
> > -	unsigned long coef_m;
> > -	unsigned long coef_div;
> > +	s64 coef_b;
> > +	s64 coef_m;
> > +	u32 coef_div;
> >  	bool inverted;
> > +	bool signed_sample;
> >  
> >  	/* Register shift and mask to access the sensor
> > temperature */ unsigned int temp_shift;
> > @@ -155,6 +161,18 @@ static void armada380_init_sensor(struct
> > platform_device *pdev, }
> >  }
> >  
> > +static void armada_ap806_init_sensor(struct platform_device *pdev,
> > +				     struct armada_thermal_priv
> > *priv) +{
> > +	u32 reg;
> > +
> > +	reg = readl_relaxed(priv->control0);
> > +	reg &= ~CONTROL0_TSEN_RESET;
> > +	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
> > +	writel(reg, priv->control0);
> > +	msleep(10);
> > +}
> > +
> >  static bool armada_is_valid(struct armada_thermal_priv *priv)
> >  {
> >  	u32 reg = readl_relaxed(priv->status);
> > @@ -166,8 +184,8 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, int *temp)
> >  {
> >  	struct armada_thermal_priv *priv = thermal->devdata;
> > -	unsigned long reg;
> > -	unsigned long m, b, div;
> > +	u32 reg, div;
> > +	s64 sample, b, m;
> >  
> >  	/* Valid check */
> >  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> > @@ -178,6 +196,11 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, 
> >  	reg = readl_relaxed(priv->status);
> >  	reg = (reg >> priv->data->temp_shift) &
> > priv->data->temp_mask;
> > +	if (priv->data->signed_sample)
> > +		/* The most significant bit is the sign bit */
> > +		sample = sign_extend32(reg,
> > fls(priv->data->temp_mask) - 1);
> > +	else
> > +		sample = reg;
> >  
> >  	/* Get formula coeficients */
> >  	b = priv->data->coef_b;
> > @@ -185,9 +208,12 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, div = priv->data->coef_div;
> >  
> >  	if (priv->data->inverted)
> > -		*temp = ((m * reg) - b) / div;
> > +		*temp = (m * sample) - b;
> >  	else
> > -		*temp = (b - (m * reg)) / div;
> > +		*temp = b - (m * sample);
> > +
> > +	do_div(*temp, div);  
> 
> I wanted to test in on ARMv7 and this line failed to compile:
> In file included from arch/arm/include/asm/div64.h:127:0,
>                  from include/linux/kernel.h:173,
>                  from include/linux/list.h:9,
>                  from include/linux/kobject.h:20,
>                  from include/linux/device.h:17,
>                  from drivers/thermal/armada_thermal.c:16:
> drivers/thermal/armada_thermal.c: In function ?armada_get_temp?:
> include/asm-generic/div64.h:208:28: warning: comparison of distinct
> pointer types lacks a cast (void)(((typeof((n)) *)0) == ((uint64_t
> *)0)); \ ^
> drivers/thermal/armada_thermal.c:247:2: note: in expansion of macro
> ?do_div? do_div(*temp, div);
>   ^~~~~~
> In file included from include/linux/ioport.h:13:0,
>                  from include/linux/device.h:16,
>                  from drivers/thermal/armada_thermal.c:16:
> include/asm-generic/div64.h:221:25: warning: right shift count >=
> width of type [-Wshift-count-overflow] } else if (likely(((n) >> 32)
> == 0)) {  \ ^
> include/linux/compiler.h:175:40: note: in definition of macro ?likely?
>  # define likely(x) __builtin_expect(!!(x), 1)
>                                         ^
> drivers/thermal/armada_thermal.c:247:2: note: in expansion of macro
> ?do_div? do_div(*temp, div);
>   ^~~~~~
> In file included from arch/arm/include/asm/div64.h:127:0,
>                  from include/linux/kernel.h:173,
>                  from include/linux/list.h:9,
>                  from include/linux/kobject.h:20,
>                  from include/linux/device.h:17,
>                  from drivers/thermal/armada_thermal.c:16:
> include/asm-generic/div64.h:225:22: error: passing argument 1 of
> ?__div64_32? from incompatible pointer type
> [-Werror=incompatible-pointer-types] __rem = __div64_32(&(n),
> __base); \ ^ drivers/thermal/armada_thermal.c:247:2: note: in
> expansion of macro ?do_div? do_div(*temp, div);
>   ^~~~~~
> In file included from include/linux/kernel.h:173:0,
>                  from include/linux/list.h:9,
>                  from include/linux/kobject.h:20,
>                  from include/linux/device.h:17,
>                  from drivers/thermal/armada_thermal.c:16:
> arch/arm/include/asm/div64.h:33:24: note: expected ?uint64_t * {aka
> long long unsigned int *}? but argument is of type ?int *? static
> inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> 

Indeed, I also have this compilation error with a 32-bit toolchain but
not with the 64-bit one. Anyway I fixed it and tested on a 32-bit
platform also.

Thanks for reporting it.
Miqu?l
