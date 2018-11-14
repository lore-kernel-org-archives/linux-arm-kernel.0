From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 14 Nov 2018 11:51:52 +0100
Subject: [PATCH v2 2/9] phy: Add configuration interface
In-Reply-To: <3a9a28df-8139-1036-a884-0de64aa07df1@ti.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4d0506aa0a61d234610b42a268a8326d9ea18466.1541516029.git-series.maxime.ripard@bootlin.com>
 <3a9a28df-8139-1036-a884-0de64aa07df1@ti.com>
Message-ID: <20181114105152.sgk454t34hmzstkn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon

On Mon, Nov 12, 2018 at 03:32:25PM +0530, Kishon Vijay Abraham I wrote:
> On 06/11/18 8:24 PM, Maxime Ripard wrote:
> > The phy framework is only allowing to configure the power state of the PHY
> > using the init and power_on hooks, and their power_off and exit
> > counterparts.
> > 
> > While it works for most, simple, PHYs supported so far, some more advanced
> > PHYs need some configuration depending on runtime parameters. These PHYs
> > have been supported by a number of means already, often by using ad-hoc
> > drivers in their consumer drivers.
> > 
> > That doesn't work too well however, when a consumer device needs to deal
> > with multiple PHYs, or when multiple consumers need to deal with the same
> > PHY (a DSI driver and a CSI driver for example).
> > 
> > So we'll add a new interface, through two funtions, phy_validate and
> > phy_configure. The first one will allow to check that a current
> > configuration, for a given mode, is applicable. It will also allow the PHY
> > driver to tune the settings given as parameters as it sees fit.
> > 
> > phy_configure will actually apply that configuration in the phy itself.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/phy/phy-core.c  | 61 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/phy/phy.h | 58 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 119 insertions(+)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 35fd38c5a4a1..7bd3ed65c708 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -408,6 +408,67 @@ int phy_calibrate(struct phy *phy)
> >  EXPORT_SYMBOL_GPL(phy_calibrate);
> >  
> >  /**
> > + * phy_configure() - Changes the phy parameters
> > + * @phy: the phy returned by phy_get()
> > + * @opts: New configuration to apply
> > + *
> > + * Used to change the PHY parameters. phy_init() must have been called
> > + * on the phy. The configuration will be applied on the current phy
> > + * mode, that can be changed using phy_set_mode().
> > + *
> > + * Returns: 0 if successful, an negative error code otherwise
> > + */
> > +int phy_configure(struct phy *phy, union phy_configure_opts *opts)
> > +{
> > +	int ret;
> > +
> > +	if (!phy)
> > +		return -EINVAL;
> > +
> > +	if (!phy->ops->configure)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&phy->mutex);
> > +	ret = phy->ops->configure(phy, opts);
> > +	mutex_unlock(&phy->mutex);
> > +
> > +	return ret;
> > +}
> 
> EXPORT_SYMBOL_GPL is missing here and below.

Consider it done.

> > +
> > +/**
> > + * phy_validate() - Checks the phy parameters
> > + * @phy: the phy returned by phy_get()
> > + * @mode: phy_mode the configuration is applicable to.
> > + * @opts: Configuration to check
> > + *
> > + * Used to check that the current set of parameters can be handled by
> > + * the phy. Implementations are free to tune the parameters passed as
> > + * arguments if needed by some implementation detail or
> > + * constraints. It will not change any actual configuration of the
> > + * PHY, so calling it as many times as deemed fit will have no side
> > + * effect.
> > + *
> > + * Returns: 0 if successful, an negative error code otherwise
> > + */
> > +int phy_validate(struct phy *phy, enum phy_mode mode,
> > +		  union phy_configure_opts *opts)
> 
> We are planning to switch to mode/submode combination [1], so this might have
> to change.

Yes, I'm aware of that. If needed, it shouldn't be too hard to rework.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/a55e0a4a/attachment.sig>
