From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 20 Nov 2014 15:38:06 -0400
Subject: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
In-Reply-To: <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141120193804.GA7252@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel and Jason,

On Sat, Nov 08, 2014 at 10:16:46PM -0500, Jason Cooper wrote:
> On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> > The Armada 375 Z1 SoC revision is no longer supported. This commit
> > removes the quirk needed for the thermal sensor.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
> >  drivers/thermal/armada_thermal.c                     | 20 --------------------
> >  2 files changed, 28 deletions(-)
> 
> As Thomas and Ezequiel rightfully mentioned, the compatible string below
> has never been in a dts file.  Our arch code detected the Z1, and
> changed the compatible on the fly.  As a result, there shouldn't be any
> dtbs in the wild with this compatible string.  If there are, it will be
> held by the few developers (Marvell, partners) that know what they are
> doing.

First of, I would like to mention that best thing to avoid such
situation is to be careful when documenting dt entries that represent hw
that no one has access to (except internal people).

> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 

OK Jason. I saw you picked patch 2. Does it mean I can queue this one? 

BR, 

Eduardo Valentin

> thx,
> 
> Jason.
> 
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > index 4cf0249..4698e0e 100644
> > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -5,17 +5,9 @@ Required properties:
> >  - compatible:	Should be set to one of the following:
> >  		marvell,armada370-thermal
> >  		marvell,armada375-thermal
> > -		marvell,armada375-z1-thermal
> >  		marvell,armada380-thermal
> >  		marvell,armadaxp-thermal
> >  
> > -		Note: As the name suggests, "marvell,armada375-z1-thermal"
> > -		applies for the SoC Z1 stepping only. On such stepping
> > -		some quirks need to be done and the register offset differs
> > -		from the one in the A0 stepping.
> > -		The operating system may auto-detect the SoC stepping and
> > -		update the compatible and register offsets at runtime.
> > -
> >  - reg:		Device's register space.
> >  		Two entries are expected, see the examples below.
> >  		The first one is required for the sensor register;
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> > index 9d1420a..9c8e783 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -35,10 +35,6 @@
> >  #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
> >  #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
> >  
> > -#define A375_Z1_CAL_RESET_LSB		0x8011e214
> > -#define A375_Z1_CAL_RESET_MSB		0x30a88019
> > -#define A375_Z1_WORKAROUND_BIT		BIT(9)
> > -
> >  #define A375_UNIT_CONTROL_SHIFT		27
> >  #define A375_UNIT_CONTROL_MASK		0x7
> >  #define A375_READOUT_INVERT		BIT(15)
> > @@ -124,24 +120,12 @@ static void armada375_init_sensor(struct platform_device *pdev,
> >  				  struct armada_thermal_priv *priv)
> >  {
> >  	unsigned long reg;
> > -	bool quirk_needed =
> > -		!!of_device_is_compatible(pdev->dev.of_node,
> > -					  "marvell,armada375-z1-thermal");
> > -
> > -	if (quirk_needed) {
> > -		/* Ensure these registers have the default (reset) values */
> > -		writel(A375_Z1_CAL_RESET_LSB, priv->control);
> > -		writel(A375_Z1_CAL_RESET_MSB, priv->control + 0x4);
> > -	}
> >  
> >  	reg = readl(priv->control + 4);
> >  	reg &= ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_SHIFT);
> >  	reg &= ~A375_READOUT_INVERT;
> >  	reg &= ~A375_HW_RESETn;
> >  
> > -	if (quirk_needed)
> > -		reg |= A375_Z1_WORKAROUND_BIT;
> > -
> >  	writel(reg, priv->control + 4);
> >  	mdelay(20);
> >  
> > @@ -260,10 +244,6 @@ static const struct of_device_id armada_thermal_id_table[] = {
> >  		.data       = &armada375_data,
> >  	},
> >  	{
> > -		.compatible = "marvell,armada375-z1-thermal",
> > -		.data       = &armada375_data,
> > -	},
> > -	{
> >  		.compatible = "marvell,armada380-thermal",
> >  		.data       = &armada380_data,
> >  	},
> > -- 
> > 2.1.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141120/8a096fb4/attachment.sig>
