From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Jan 2016 22:07:15 +0100
Subject: [PATCH 1/2] clk: sunxi: delay protected clocks until arch initcall
In-Reply-To: <20160127203816.GU4317@lukather>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <7334994.mKnQpNNMP2@diego> <20160127203816.GU4317@lukather>
Message-ID: <1991025.ABeYDSZEGp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Januar 2016, 21:38:16 schrieb Maxime Ripard:
> Hi,
> 
> On Wed, Jan 27, 2016 at 05:14:17PM +0100, Heiko St?bner wrote:
> > Hi,
> > 
> > Am Mittwoch, 27. Januar 2016, 16:37:22 schrieb Maxime Ripard:
> > > I thought the patches were simply dropped and the
> > > rockchip people just took another approach.
> > 
> > nope still on track ... especially as it was Stephen's believe that
> > orphans
> > shouldn't even be usable to general clock users :-).
> > 
> > I just remember that the proposed general solution was based on Mike's
> > upcoming generic critical clock handling (the handoff thingy), which would
> > move critical clock handling out of architecture-specific code, so I've
> > been prodding Mike mainly.
> > 
> > Another option might be to allow clock-controllers to handle orphans and
> > only deny orphan usage to outside clock users, maybe expanding on what I
> > did with the clock-conf part in patch2.
> 
> I'm not sure that would solve anything in our case. All our clocks
> drivers are different ones, so I'm not sure how we could handle that.

the core issue is, that a clk_get on an orphan is going to return EPROBE_DEFER 
after the second patch, which is also true for sunxi critical clocks.

The clock-conf has the same issue in the case where you know on the board-
level that a clock will stay orphaned indefinitly and want to reparent it away 
to some sane parent.

That's why I added of_clk_get_from_provider_with_orphans() (limited to use in 
the ccf) in the second patch to allow orphans to be reparented via assigned-
clocks foo. In theory one could argue that clock controller generally know 
what they're doing and add something like clk_get_with_orphans() or whatever 
that might be called then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/e73aa75f/attachment.sig>
