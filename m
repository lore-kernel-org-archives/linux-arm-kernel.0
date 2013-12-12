From: mporter@linaro.org (Matt Porter)
Date: Thu, 12 Dec 2013 06:50:03 -0500
Subject: [PATCH v4 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <20131212112715.GK4360@n2100.arm.linux.org.uk>
References: <1386847117-21240-1-git-send-email-mporter@linaro.org>
 <1386847117-21240-2-git-send-email-mporter@linaro.org>
 <20131212112715.GK4360@n2100.arm.linux.org.uk>
Message-ID: <20131212115003.GB20773@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:27:15AM +0000, Russell King wrote:
> On Thu, Dec 12, 2013 at 06:18:29AM -0500, Matt Porter wrote:
> >  /**
> > + * struct phy_attrs - represents phy attributes
> > + * @bus_width: Data path width implemented by PHY
> > + */
> > +struct phy_attrs {
> > +	u32			bus_width;
> 
> Why u32?

Kishon suggested it and I changed it on this rev...forgetting about the
error path below.

> >  int phy_power_off(struct phy *phy);
> > +static inline u32 phy_get_bus_width(struct phy *phy)
> > +{
> > +	return phy->attrs.bus_width;
> ...
> >  
> > +static inline u32 phy_get_bus_width(struct phy *phy)
> > +{
> > +	return -ENOSYS;
> 
> Why u32, especially as you're returning a negative number here.
> 
> If the bus width is a small integer (I'm assuming you don't have up to
> 2^30 bus signals) then what's wrong with it being an 'int' ?

Yes, very correct...it's expected to always be a small positive integer
value or zero (when not populated as it's optional). I agree it should
go back to 'int' especially due to the negative value when GENERIC_PHY
isn't enabled.

-Matt
