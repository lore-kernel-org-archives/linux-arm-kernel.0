From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2016 12:48:05 +0100
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <20160603111941.GJ23566@e106497-lin.cambridge.arm.com>
References: <E1b8jze-00046l-K5@rmk-PC.armlinux.org.uk>
 <20160603094048.GI23566@e106497-lin.cambridge.arm.com>
 <20160603103633.GA1041@n2100.armlinux.org.uk>
 <20160603111941.GJ23566@e106497-lin.cambridge.arm.com>
Message-ID: <20160603114805.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 12:19:41PM +0100, Liviu Dudau wrote:
> On Fri, Jun 03, 2016 at 11:36:33AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jun 03, 2016 at 10:40:48AM +0100, Liviu Dudau wrote:
> > > On Fri, Jun 03, 2016 at 08:58:10AM +0100, Russell King wrote:
> > > > Convert DT component matching to use component_match_add_release().
> > > 
> > > Hi Russell,
> > > 
> > > Any reason for not keeping the component_match_add() calls in the drivers?
> > 
> > Sorry, I don't understand your comment.
> 
> As in: component_match_add() already exists as a macro that calls
> component_match_add_release(), but with a NULL release function. If it
> were to be changed to pass a default release_of() function then most of
> the drivers would not have to change, right? It is just one point of
> view and I was curious if there was a reason not to choose it, as it
> would have (probably) generated a smaller delta?

And what should the calls that don't pass a DT node be called?
What happens to new users who aren't passing a DT node but use
component_match_add() ?

What you're suggesting sound totally insane to me: you're making
the change a flag-day: component_match_add() currently takes anything
as the data pointer and users can pass anything that their compare
function can handle - and changing that to a function which can only
take a device_node.  That means all non-DT users of that function
need to change at the same time.

Flag days are really bad news in kernel development (or any
distributed development project), and I won't generate a patch which
causes a flag day to occur - especially not one which impacts a large
number of users.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
