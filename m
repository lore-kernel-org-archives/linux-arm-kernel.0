From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 23 Nov 2017 18:35:10 +0200
Subject: [PATCH 2/3] thermal: armada: add support for AP806
In-Reply-To: <20171123152416.GR31757@n2100.armlinux.org.uk>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
 <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
 <20171123152416.GR31757@n2100.armlinux.org.uk>
Message-ID: <20171123163510.q34rndd4b4p4da4s@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Nov 23, 2017 at 03:24:17PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 22, 2017 at 04:42:04PM +0200, Baruch Siach wrote:
> > The AP806 component is integrated in the Armada 8k and 7k lines of processors.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/thermal/armada_thermal.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> > index ae75328945f7..1f7f81628040 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -41,6 +41,10 @@
> >  #define A375_HW_RESETn			BIT(8)
> >  #define A380_HW_RESET			BIT(8)
> >  
> > +#define AP806_START			BIT(0)
> > +#define AP806_RESET			BIT(1)
> > +#define AP806_ENABLE			BIT(2)
> > +
> >  struct armada_thermal_data;
> >  
> >  /* Marvell EBU Thermal Sensor Dev Structure */
> > @@ -147,6 +151,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
> >  	}
> >  }
> >  
> > +static void armada_ap806_init_sensor(struct platform_device *pdev,
> > +				     struct armada_thermal_priv *priv)
> > +{
> > +	u32 reg = readl_relaxed(priv->control);
> > +
> > +	reg &= ~AP806_RESET;
> > +	reg |= AP806_START;
> > +	reg |= AP806_ENABLE;
> > +	writel(reg, priv->control);
> > +	mdelay(10);
> 
> Do you really need to make the CPU busy-wait for 10ms here?  This
> looks like it's called from a schedulable context, so won't msleep()
> do?

msleep() should be fine as well. I just mindlessly copied this code from the 
vendor kernel. I'll change that in the next iteration.

Thanks for reviewing,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
