From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 14 Dec 2017 12:33:01 +0100
Subject: [PATCH v3 06/11] thermal: armada: Add support for Armada CP110
In-Reply-To: <87tvwto96y.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-7-miquel.raynal@free-electrons.com>
 <87tvwto96y.fsf@free-electrons.com>
Message-ID: <20171214123301.1729df4f@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Dec 2017 12:11:49 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On jeu., d?c. 14 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > From: Baruch Siach <baruch@tkos.co.il>
> >
> > The CP110 component is integrated in the Armada 8k and 7k lines of
> > processors.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > [<miquel.raynal@free-electrons.com>: renamed the register
> > pointers]  
> 
> Actually you did more thant this see below
> 
> 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > ---
> >  drivers/thermal/armada_thermal.c | 30
> > ++++++++++++++++++++++++------ 1 file changed, 24 insertions(+), 6
> > deletions(-)
> >
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c index 279d01937bb8..f5c911524656
> > 100644 --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -37,7 +37,6 @@
> >  #define A375_UNIT_CONTROL_MASK		0x7
> >  #define A375_READOUT_INVERT		BIT(15)
> >  #define A375_HW_RESETn			BIT(8)
> > -#define A380_HW_RESET			BIT(8)
> >  
> >  /* Legacy bindings */
> >  #define LEGACY_CONTROL_MEM_LEN		0x4
> > @@ -52,6 +51,10 @@
> >  #define CONTROL0_TSEN_RESET		BIT(1)
> >  #define CONTROL0_TSEN_ENABLE		BIT(2)
> >  
> > +/* EXT_TSEN refers to the external temperature sensors, out of the
> > AP */ +#define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
> > +#define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)  
> You added or rename these values
> 
> > +
> >  struct armada_thermal_data;
> >  
> >  /* Marvell EBU Thermal Sensor Dev Structure */
> > @@ -153,11 +156,10 @@ static void armada380_init_sensor(struct
> > platform_device *pdev, u32 reg = readl_relaxed(priv->control1);
> >  
> >  	/* Reset hardware once */
> > -	if (!(reg & A380_HW_RESET)) {
> > -		reg |= A380_HW_RESET;
> > -		writel(reg, priv->control1);
> > -		msleep(10);
> > -	}
> > +	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
> > +	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
> > +	writel(reg, priv->control1);  
> 
> And here you modified the behavior of this function.
> Did you checked that it is valid for Armada 38x?

There is nothing about it the documentation and anyway this register
can be accessed later, so writing it is harmless ayway.

> 
> Given the comment we had, I thought we should not do anything if
> CONTROL1_EXT_TSEN_HW_RESETn was not set.

That is the opposite, if it is not set (ie. reset is active), you have
to set it (reset is then disabled).

> 
> By the way, if the new sequence is valid, this comment should be
> removed or at least updated.

That's right, I will in v4.

Thanks for reviewing,
Miqu?l
