From: matt.porter@linaro.org (Matt Porter)
Date: Wed, 27 Nov 2013 11:55:37 -0500
Subject: [PATCH v3 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <529474FA.9080103@ti.com>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
 <1385403367-18144-2-git-send-email-matt.porter@linaro.org>
 <529474FA.9080103@ti.com>
Message-ID: <20131127165537.GB31091@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:46:26PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 25 November 2013 11:45 PM, Matt Porter wrote:
> > This adds a pair of APIs that allows the generic PHY subsystem to
> > provide information on the PHY bus width. The PHY provider driver may
> > use phy_set_bus_width() to set the bus width that the PHY supports.
> > The controller driver may then use phy_get_bus_width() to fetch the
> > PHY bus width in order to properly configure the controller.
> > 
> > Signed-off-by: Matt Porter <matt.porter@linaro.org>
> > ---
> >  include/linux/phy/phy.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index 6d72269..6ca6c61 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -46,6 +46,7 @@ struct phy_ops {
> >   * @mutex: mutex to protect phy_ops
> >   * @init_count: used to protect when the PHY is used by multiple consumers
> >   * @power_count: used to protect when the PHY is used by multiple consumers
> > + * @bus_width: used to specify data width of the PHY bus
> >   */
> >  struct phy {
> >  	struct device		dev;
> > @@ -55,6 +56,7 @@ struct phy {
> >  	struct mutex		mutex;
> >  	int			init_count;
> >  	int			power_count;
> > +	int			bus_width;
> 
> the bus_width can be part of the attrs struct which you initially proposed.
> Soon there will be requests for other attributes being added (e.g., speed).

Agreed, I'll merge the accessors with the original attrs struct.

> >  };
> >  
> >  /**
> > @@ -127,6 +129,14 @@ int phy_init(struct phy *phy);
> >  int phy_exit(struct phy *phy);
> >  int phy_power_on(struct phy *phy);
> >  int phy_power_off(struct phy *phy);
> > +static inline int phy_get_bus_width(struct phy *phy)
> > +{
> > +	return phy->bus_width;
> > +}
> > +static inline void phy_set_bus_width(struct phy *phy, int bus_width)
> 
> u32 bus_width?

will update

> > +{
> > +	phy->bus_width = bus_width;
> > +}
> >  struct phy *phy_get(struct device *dev, const char *string);
> >  struct phy *devm_phy_get(struct device *dev, const char *string);
> >  void phy_put(struct phy *phy);
> > @@ -199,6 +209,16 @@ static inline int phy_power_off(struct phy *phy)
> >  	return -ENOSYS;
> >  }
> >  
> > +static inline int phy_get_bus_width(struct phy *phy)
> > +{
> > +	return -ENOSYS;
> > +}
> > +
> > +static inline void phy_set_bus_width(struct phy *phy, bus_width)
> 
> er.. has this been compile tested?

*sigh* obviously not, will address this.

-Matt
