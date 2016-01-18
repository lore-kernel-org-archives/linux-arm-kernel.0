From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jan 2016 16:25:38 +0000
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160117000434.GB7774@rob-hp-laptop>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
Message-ID: <20160118162538.GH6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2016 at 06:04:34PM -0600, Rob Herring wrote:
> On Fri, Jan 15, 2016 at 09:57:34AM +0100, Maxime Ripard wrote:

> > We could push that code in the consumer drivers, but that has some
> > significant drawbacks:
> >   - That would duplicate that code in all the drivers, leading to the
> >     usual drawbacks of code duplication, especially when it's not
> >     really trivial to handle (or at least, when there's a few
> >     gotchas).

> Either you could keep the driver and the consumer driver is responsible 
> for instantiating the regulator. It could also be implemented as a helper 
> library in the regulator core. 

No, anything that is visible to consumer drivers is completely silly.
The whole point with both the DT bindings and the API is to hide details
of how the supply is implemented from the consumers, any implementation
must be transparent to consumers otherwise it's unusable.

> >   - When you come to consider it from an hardware point of view, the
> >     device usually have a single pin that powers it. It's the board
> >     designer that chose to route that pin to multiple regulators, so
> >     it's really the board that is wired that way, and putting that
> >     code in the consumer drivers would be an abstraction leak imho.

> That's a good point. Perhaps the regulator core needs to be able to 
> parse the list and return the single ptr to the virtual regulator.

Exactly, if we don't want to represent the combination directly.  For
most uses it's probably OK but I can see us in a situation where we
might want to do things like only use one of the regulators in low load
situations where we might want to attach properties to the merge of the
two regulators rather than just referencing them both.  I'm not sure
that's realistic though or that we wouldn't just be working that use
case out dynamically at runtime.

I'm ambivalent on which way is better, it does complicate the
implementation to support doing this as lists and while it makes the DT
more elegant I'm not clear that it's worth the effort especially when it
comes to constraint combining.  But perhaps the implementation turns out
to be simpler than I would anticiapte.

> >   - We might not even have a driver for these regulators, or at least
> >     one that play by the rules. In our case, that's an out-of-tree
> >     WiFi driver.

> Support of out of tree things has never been a winning argument for 
> upstream.

> With an out of tree binding as well?

Since the consumer driver shouldn't be worrying about implementation
details of the supply it doesn't matter if the device on this particular
board is out of tree.

> > In the latter case, I remember Mark saying several times that he was
> > not in favour of such a change, even recently:
> > https://lkml.org/lkml/2015/10/14/238

> I think this case is somewhat different. What I'm suggesting is closer 

Yes, that's a different case - that's the case where all the supplies
in the device are combined into a single list rather than the case where
we have one supply with multiple regulators providing it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160118/92d23aef/attachment.sig>
