From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 10 Jun 2011 15:11:19 -0600
Subject: [PATCH v4 1/4] dt: check root nodes for match on
	of_platform_populate
In-Reply-To: <201106102306.48426.arnd@arndb.de>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-2-git-send-email-robherring2@gmail.com>
	<201106102306.48426.arnd@arndb.de>
Message-ID: <20110610211119.GA28994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 11:06:48PM +0200, Arnd Bergmann wrote:
> On Friday 10 June 2011 22:48:40 Rob Herring wrote:
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 9b785be..dc56a77 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -318,6 +318,8 @@ int of_platform_populate(struct device_node *root,
> >                 return -EINVAL;
> >  
> >         for_each_child_of_node(root, child) {
> > +               if (!of_match_node(matches, child))
> > +                       continue;
> >                 rc = of_platform_bus_create(child, matches, parent, true);
> >                 if (rc)
> >                         break;
> 
> 
> Why doesn't of_platform_populate just call of_platform_bus_create on the
> root node? That should normally take care of matching all children.

of_platform_bus_create creates a device for the 'bus' node, where
of_platform_populate() creates children as direct children of the
'parent' device; which I think is the behaviour wanted here.

Also, of_platform_bus_create checks for a compatible property on the bus
node, whereas of_platform_populate does not, and should not.

g.
