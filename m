From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Nov 2018 10:17:24 +0100
Subject: [PATCH v2 8/9] phy: Add Cadence D-PHY support
In-Reply-To: <5f5bcc06-51b2-d565-56a0-083c66c1f01a@ti.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4ec9e47fb5aa9794f69a8e75a04108055094c056.1541516029.git-series.maxime.ripard@bootlin.com>
 <5f5bcc06-51b2-d565-56a0-083c66c1f01a@ti.com>
Message-ID: <20181116091724.4wwdrgn5hfcdao6b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Nov 12, 2018 at 03:21:56PM +0530, Kishon Vijay Abraham I wrote:
> > +static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode,
> > +			      union phy_configure_opts *opts)
> > +{
> > +	struct cdns_dphy_cfg cfg = { 0 };
> > +
> > +	if (mode != PHY_MODE_MIPI_DPHY)
> > +		return -EINVAL;
> > +
> > +	return cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> > +}
> > +
> > +static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > +{
> > +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> > +	struct cdns_dphy_cfg cfg = { 0 };
> > +	int ret;
> > +
> > +	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> > +	if (ret)
> > +		return ret;
> 
> Can you explain why you need the same function to be invoked from both validate
> and configure callback? I see this to be redundant.

Sure.

Validate and configure serve two rather different purposes. validate
is here to make sure that a configuration can work with the PHY, and
to let the phy adjust the configuration to find a more optimal one.

configure, on the other hand, apply a configuration. We still have to
make sure that the configuration can work, since:
  - We might have called validate any number of times, with any number
    of configurations before calling configure, so we don't know which
    configuration we validate is actually going to be applied later on
    (if it's even applied)
  - If we don't care about the validation at all, we might just call
    configure directly

Does that make sense?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/2ab0c490/attachment-0001.sig>
