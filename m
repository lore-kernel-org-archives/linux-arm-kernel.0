From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 6 Sep 2018 16:48:07 +0200
Subject: [PATCH 02/10] phy: Add configuration interface
In-Reply-To: <8397722.XVQDA25ZU6@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <8397722.XVQDA25ZU6@avalon>
Message-ID: <20180906144807.pn753tgfyovvheil@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 04:39:46PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Wednesday, 5 September 2018 12:16:33 EEST Maxime Ripard wrote:
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
> 
> s/deal/deal with/
> 
> > multiple PHYs, or when multiple consumers need to deal with the same PHY (a
> > DSI driver and a CSI driver for example).
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
> >  drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/phy/phy.h | 42 ++++++++++++++++++++++++++++-
> >  2 files changed, 104 insertions(+)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > index 35fd38c5a4a1..6eaf655e370f 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -408,6 +408,68 @@ int phy_calibrate(struct phy *phy)
> >  EXPORT_SYMBOL_GPL(phy_calibrate);
> > 
> >  /**
> > + * phy_configure() - Changes the phy parameters
> > + * @phy: the phy returned by phy_get()
> > + * @mode: phy_mode the configuration is applicable to.
> > + * @opts: New configuration to apply
> > + *
> > + * Used to change the PHY parameters. phy_init() must have
> > + * been called on the phy.
> > + *
> > + * Returns: 0 if successful, an negative error code otherwise
> > + */
> > +int phy_configure(struct phy *phy, enum phy_mode mode,
> > +		  union phy_configure_opts *opts)
> > +{
> > +	int ret;
> > +
> > +	if (!phy)
> > +		return -EINVAL;
> > +
> > +	if (!phy->ops->configure)
> > +		return 0;
> 
> Shouldn't you report an error to the caller ? If a caller expects the PHY to 
> be configurable, I would assume that silently ignoring the requested 
> configuration won't work great.

I'm not sure. I also expect a device having to interact with multiple
PHYs, some of them needing some configuration while some other do
not. In that scenario, returning 0 seems to be the right thing to do.

> > +	mutex_lock(&phy->mutex);
> > +	ret = phy->ops->configure(phy, mode, opts);
> > +	mutex_unlock(&phy->mutex);
> > +
> > +	return ret;
> > +}
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
> > +{
> > +	int ret;
> > +
> > +	if (!phy)
> > +		return -EINVAL;
> > +
> > +	if (!phy->ops->validate)
> > +		return 0;
> > +
> > +	mutex_lock(&phy->mutex);
> > +	ret = phy->ops->validate(phy, mode, opts);
> > +	mutex_unlock(&phy->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> >   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
> >   * @np: device_node for which to get the phy
> >   * @index: the index of the phy
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index 9cba7fe16c23..3cc315dcfcd0 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -44,6 +44,12 @@ enum phy_mode {
> >  };
> > 
> >  /**
> > + * union phy_configure_opts - Opaque generic phy configuration
> > + */
> > +union phy_configure_opts {
> > +};
> > +
> > +/**
> >   * struct phy_ops - set of function pointers for performing phy operations
> >   * @init: operation to be performed for initializing phy
> >   * @exit: operation to be performed while exiting
> > @@ -60,6 +66,38 @@ struct phy_ops {
> >  	int	(*power_on)(struct phy *phy);
> >  	int	(*power_off)(struct phy *phy);
> >  	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
> > +
> > +	/**
> > +	 * @configure:
> > +	 *
> > +	 * Optional.
> > +	 *
> > +	 * Used to change the PHY parameters. phy_init() must have
> > +	 * been called on the phy.
> > +	 *
> > +	 * Returns: 0 if successful, an negative error code otherwise
> > +	 */
> > +	int	(*configure)(struct phy *phy, enum phy_mode mode,
> > +			     union phy_configure_opts *opts);
> 
> Is this function allowed to modify opts ? If so, to what extent ? If not, the 
> pointer should be made const.

That's a pretty good question. I guess it could modify it to the same
extent than validate could. Would that make sense?

> > +	/**
> > +	 * @validate:
> > +	 *
> > +	 * Optional.
> > +	 *
> > +	 * Used to check that the current set of parameters can be
> > +	 * handled by the phy. Implementations are free to tune the
> > +	 * parameters passed as arguments if needed by some
> > +	 * implementation detail or constraints. It must not change
> > +	 * any actual configuration of the PHY, so calling it as many
> > +	 * times as deemed fit by the consumer must have no side
> > +	 * effect.
> > +	 *
> > +	 * Returns: 0 if the configuration can be applied, an negative
> > +	 * error code otherwise
> 
> When should this operation modify the passed parameters, and when should it 
> return an error ? I understand that your goal is to implement a negotiation 
> mechanism for the PHY parameters, and to be really useful I think we need to 
> document it more precisely.

My initial idea was to reject a configuration that wouldn't be
achievable by the PHY, ie you're asking something that is outside of
the operating boundaries, while you would be able to change settings
that would be operational, but sub-optimal.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/3167888b/attachment.sig>
