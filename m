From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 16:47:38 +0100
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160205153258.GW4455@sirena.org.uk>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
 <20160121154649.GE3997@lukather>
 <20160121162802.GL6588@sirena.org.uk>
 <20160205143328.GD31506@lukather>
 <20160205153258.GW4455@sirena.org.uk>
Message-ID: <20161107154738.ewliwzx5plams4ni@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Feb 05, 2016 at 03:32:58PM +0000, Mark Brown wrote:
> On Fri, Feb 05, 2016 at 03:33:28PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 21, 2016 at 04:28:02PM +0000, Mark Brown wrote:
> > > On Thu, Jan 21, 2016 at 04:46:49PM +0100, Maxime Ripard wrote:
> 
> > > > Anyway, I'm fine with both approaches, just let me know what you
> > > > prefer.
> 
> > > Without seeing an implementation of the lists it's hard to say.
> 
> > Just to make sure we're on the same page: you want to keep the
> > regulator, but instead of giving the parent through vinX-supplies
> > properties, you want to have a single *-supply property, with a list
> > of regulators, right?
> 
> Either that or an explicit regulator describing the merge.  Rob wants
> the list I think but I really don't care.

So, I'm reviving this old thread after speaking to you about it at
ELCE and trying to code something up, and getting lost..

To put a bit of context, I'm still trying to tackle the issue of
devices that have two regulators powering them on the same pin for
example when each regulator cannot provide enough current alone to
power the device (all the setups like this one I've seen so far were
for WiFi chips, but it might be different).

I guess we already agreed on the fact that the DT binding should just
be to allow a *-supply property to take multiple regulators, and mark
them as "coupled" (or whatever name we see fit) in such a case.

Since regulator_get returns a struct regulator pointer, it felt
logical to try to add the list of parent regulators to it, especially
as this structure is per-consumer, and different consumers might have
different combinations of regulators.

However, this structure embeds a pointer to a struct regulator_dev,
which seems to model the regulator itself, but will also contain
pointer to the struct regulator, probably to model its parent? I guess
my first question would be do we care about nesting? or having a
regulator with multiple parents?

It also contains the constraints on each regulator, which might or
might not be different for each of the coupled regulators, but I'm
guessing the couple might have contraints of its own too I guess. Is
it something that might happen? Should we care about it?

And finally, my real question is, do we want to aggregate them in
struct regulator, at the consumer level, which might make the more
sense, or do we want to create an intermediate regulator internally?
What is your take on this?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/133eabc8/attachment.sig>
