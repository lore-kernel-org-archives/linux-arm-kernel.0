From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Nov 2013 18:58:46 +0100
Subject: [PATCH v2 1/9] phy: add phy_get_bus_width()/phy_set_bus_width()
 calls
In-Reply-To: <20131102174709.GE17505@beef>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <52753387.5030202@ti.com> <20131102174709.GE17505@beef>
Message-ID: <1391452.2H43C6z4fl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 of November 2013 13:47:09 Matt Porter wrote:
> On Sat, Nov 02, 2013 at 10:46:55PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Tomasz,
> > 
> > On Saturday 02 November 2013 06:44 PM, Tomasz Figa wrote:
> > >Hi Matt,
> > >
> > >On Friday 01 of November 2013 15:45:50 Matt Porter wrote:
> > >>This adds a pair of APIs that allows the generic PHY subsystem to
> > >>provide information on the PHY bus width. The PHY provider driver
> > >>may
> > >>use phy_set_bus_width() to set the bus width that the PHY supports.
> > >>The controller driver may then use phy_get_bus_width() to fetch the
> > >>PHY bus width in order to properly configure the controller.
> > >
> > >I somehow does not like this. If we take this path for any further
> > >properties that we may need, we will end up with a lot of consumer
> > >specific properties stored in a PHY object having their own accessor
> > >functions.
> > 
> > Only after all of us feel that a property is *generic* enough, we
> > allow it to be added in the PHY object.
> 
> I also want to note that this was discussed over in another thread [2]
> where you did consider my rough stab at a more generic attribute
> accessor. It was definitely my first reaction as the way to do it like
> Tomasz has said. The specific accessors are more readable to me besides
> the justification you mention above.
> 
> [2] http://lkml.indiana.edu/hypermail/linux/kernel/1310.3/00673.html

Personally I like that version much better, but still it would need to be 
polished a bit.

How I imagine such interface to be implemented:

phy.h:

struct phy {
	// ...
	const struct phy_attrs *attrs;
	// ...
};

static inline const struct phy_attrs *phy_get_attrs(struct phy *phy) {
	return phy->attrs;
};

phy driver:

static const struct phy_attrs my_phy_attrs = {
	// ...
};

static int my_phy_probe(...)
{
	// ...
	phy = devm_phy_create_attrs(dev, &ops, &my_phy_attrs, NULL);
	// ...
}

phy consumer:

	// ...
	const struct phy_attrs *phy_attrs;

	phy_attrs = phy_get_attrs(phy);
	// ...

Why I think it is better than what I've seen in this and previous instance 
of this thread? (in random order)
 a) Only the PHY driver can set the attrs.
 b) PHY consumer has access only to a const pointer.
 c) PHY attributes can be placed in a static struct inside a driver file, 
without the need to call any functions to set particular attributes.
 d) Can be extended with more attributes easily.

Best regards,
Tomasz
