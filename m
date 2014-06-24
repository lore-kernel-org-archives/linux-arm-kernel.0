From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 20:08:18 +0100
Subject: [PATCH RFC 3/8] component: add support for component match array
In-Reply-To: <20140428092131.GE19455@ulmo>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBba-0002Gd-9p@rmk-PC.arm.linux.org.uk> <20140428092131.GE19455@ulmo>
Message-ID: <20140624190818.GA20555@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:21:32AM +0200, Thierry Reding wrote:
> On Sun, Apr 27, 2014 at 12:01:58AM +0100, Russell King wrote:
> > Add support for generating a set of component matches at master probe
> > time, and submitting them to the component layer.  This allows the
> > component layer to perform the matches internally without needing to
> > call into the master driver, and allows for further restructuring of
> > the component helper.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/component.c  | 118 ++++++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/component.h |   7 +++
> >  2 files changed, 122 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/component.c b/drivers/base/component.c
> [...]
> > +void component_match_add(struct device *dev, struct component_match **matchptr,
> > +	int (*compare)(struct device *, void *), void *compare_data)
> > +{
> > +	struct component_match *match = *matchptr;
> > +
> > +	if (IS_ERR(match))
> > +		return;
> > +
> > +	if (!match || ++match->num == match->alloc) {
> > +		size_t new_size = match ? match->alloc + 16 : 15;
> 
> Doesn't this allocate prematurely? If component_match_add() is called on
> the final component of a master, then match->num will be incremented to
> it's final value. If that matches match->alloc, then things are just
> fine, aren't they? No need to allocate another 16 entries.

This code appears to be correct - `num' is actually one less than the
number of components.

However, that makes code elsewhere wrong... v2 coming up soon with this
fixed.  Good catch.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
