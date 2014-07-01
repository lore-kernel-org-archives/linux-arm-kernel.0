From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 15:22:10 +0100
Subject: [PATCH RFC v2 3/8] component: add support for component match
 array
In-Reply-To: <20140626144601.GS32514@n2100.arm.linux.org.uk>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
 <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
 <CA+gwMcdO5P-Yu+-FeHHGxkKwObsATL-ThVDwmEm2_cZ3enUXPQ@mail.gmail.com>
 <20140626144601.GS32514@n2100.arm.linux.org.uk>
Message-ID: <20140701142210.GS32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 03:46:01PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 26, 2014 at 02:34:17PM +0200, Philipp Zabel wrote:
> > Hi Russell,
> > 
> > On Tue, Jun 24, 2014 at 9:29 PM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> > [...]
> > > +/*
> > > + * Add a component to be matched.
> > > + *
> > > + * The match array is first created or extended if necessary.
> > > + */
> > > +void component_match_add(struct device *dev, struct component_match **matchptr,
> > > +       int (*compare)(struct device *, void *), void *compare_data)
> > > +{
> > > +       struct component_match *match = *matchptr;
> > > +
> > > +       if (IS_ERR(match))
> > > +               return;
> > > +
> > > +       if (!match || match->num == match->alloc) {
> > > +               size_t new_size = match ? match->alloc + 16 : 15;
> > > +
> > > +               match = component_match_realloc(dev, match, new_size);
> > > +
> > > +               *matchptr = match;
> > > +
> > > +               if (IS_ERR(match))
> > > +                       return;
> > > +       }
> > > +
> > > +       match->compare[match->num].fn = compare;
> > > +       match->compare[match->num].data = compare_data;
> > > +       match->num++;
> > > +}
> > 
> > component_match_add should be exported.
> 
> Fixed, thanks.

As there's no further comments, and Inki Dae has not responded, I'm
going to send these out without the RFC tag in the hope that people
will provide acks.  This allows us to move forward with this despite
the Exynos DRM blockage.

The ultimate plan is for patches 1 to 3 inclusive to be merged into
Greg's driver tree, 1 to 3 and 5 into Greg's staging tree, and 1 to
3 and 4 for David Airlie's DRM tree - patches 1 to 3 are needed for
both patches 4 and 5.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
