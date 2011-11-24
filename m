From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Thu, 24 Nov 2011 11:33:41 +0100
Subject: [PATCH v7 3/5] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <201111231618.45951.arnd@arndb.de>
References: <cover.1322062555.git.n.voss@weinmann.de>
 <ee23c49c5a190a2cce0859f7828c2dc771ff3207.1322062555.git.n.voss@weinmann.de>
 <201111231618.45951.arnd@arndb.de>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B44FEAF@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arnd Bergmann wrote on 2011-11-23:
> On Tuesday 08 November 2011, Nikolaus Voss wrote:
> 
> 
> > +
> > +static unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg)
> > +{
> > +	return __raw_readl(dev->base + reg);
> > +}
> > +
> > +static void at91_twi_write(struct at91_twi_dev *dev, unsigned reg, unsigned
> val)
> > +{
> > +	__raw_writel(val, dev->base + reg);
> > +}
> 
> Better use readl/writel or readl_relaxed/writel_relaxed.

ok, changed.

> 
> > +/*
> > + * Calculate and set symmetric clock as stated in datasheet:
> > + * twi_clk = F_MAIN / (2 * cdiv * (1 << ckdiv) + 4)
> > + */
> > +static void __devinit at91_set_twi_clock(struct at91_twi_dev *dev, int
> twi_clk)
> > +{
> > +	const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 2;
> > +	int ckdiv = fls(div >> 8);
> > +	const int cdiv = div >> ckdiv;
> > +
> > +	if (cpu_is_at91rm9200() && (ckdiv > 5)) {
> > +		dev_warn(dev->dev, "AT91RM9200 erratum 22: using ckdiv = 5.\n");
> > +		ckdiv = 5;
> > +	}
> 
> Don't check a global property like this locally in the driver. Instead,
> make it a property of the device that you check here and set it based on
> the the device name set by the platform, or by a device tree property.

Yes, this is a known problem and was discussed in
https://lkml.org/lkml/2011/11/8/217 . The main problem is that there a no
revisions for specific at91 IP devices but the revision is implicitly
defined by the cpu type and version. Changing this would need to add some
arch infrastructure which I think is beyond the scope of this driver.

> > diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> > new file mode 100644
> > index 0000000..a898159
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-at91.h
> > @@ -0,0 +1,80 @@
> > +
> > +#ifndef AT91_TWI_H
> > +#define AT91_TWI_H
> > +
> 
> No need for a header file if all the values in it are used in only one
> source file. Just move everything to i2c_at91.c
> 
> > +#define	AT91_TWI_MMR		0x04		/* Master Mode Register */
> > +#define	AT91_TWI_IADRSZ		(3    <<  8)	/* Internal Device Address
> > +						 *  Size */
> > +#define	AT91_TWI_IADRSZ_NO	(0 << 8)
> > +#define	AT91_TWI_IADRSZ_1	(1 << 8)
> > +#define	AT91_TWI_IADRSZ_2	(2 << 8)
> > +#define	AT91_TWI_IADRSZ_3	(3 << 8)
> > +#define	AT91_TWI_MREAD		(1    << 12)	/* Master Read Direction
> */
> > +#define	AT91_TWI_DADR		(0x7f << 16)	/* Device Address */
> 
> These are harder to read than just using hexadecimal bitmasks:
> 
> #define	AT91_TWI_MMR		0x00000004
> #define	AT91_TWI_IADRSZ		0x00000300
> #define	AT91_TWI_IADRSZ_NO	0x00000000
> #define	AT91_TWI_IADRSZ_1	0x00000100
> ...

I agree, but this header file was already used by the old driver and
converting would add possible errors to register definitions which are
not (yet) used. That's why I've left it as is and just made it a local
include.

Thanks,
Niko
