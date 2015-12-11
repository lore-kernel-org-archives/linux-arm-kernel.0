From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Dec 2015 17:49:40 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151210175820.GE14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
Message-ID: <20151211174940.GQ5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 05:58:20PM +0000, Juri Lelli wrote:
> On 10/12/15 15:30, Mark Brown wrote:
> > On Mon, Nov 23, 2015 at 08:06:31PM -0600, Rob Herring wrote:

> > > In other words, I want to see these numbers have a defined method 
> > > of determining them and don't want to see random values from every 
> > > vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> > > me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> > > value of 1024 is not what I want to see. Of course things like cache 
> > > sizes can vary the performance, but is a baseline value good enough? 

> > > However, no vendor will want to publish their values if these are 
> > > absolute values relative to other vendors.

> > > If you expect these to need frequent tuning, then don't put them in DT.

> > I agree strongly.  Putting what are essentially tuning numbers for the
> > system into the ABI is going to lead us into a mess long term since if
> > we change anything related to the performance of the system the numbers
> > may become invalid and we've no real way of recovering sensible
> > information.

> I'm not entirely getting here why you consider capacity values to be
> tunables. As part of the EAS effort, we are proposing ways in which users

The purpose of the capacity values is to influence the scheduler
behaviour and hence performance.  Without a concrete definition they're
just magic numbers which have meaining only in terms of their effect on
the performance of the system.  That is a sufficiently complex outcome
to ensure that there will be an element of taste in what the desired
outcomes are.  Sounds like tuneables to me.

> should be able to fine tune their system as needed, when required
> (don't know if you had a chance to have a look at the SchedTune posting
> back in August for example [1]). This patch tries to only standardize
> where do we get default values from and how we specify them. I'm not
> seeing them changing much after an initial benchmarking phase has been
> done. Tuning should happen using different methods, not by changing
> these values, IMHO.

If you are saying people should use other, more sensible, ways of
specifying the final values that actually get used in production then
why take the defaults from direct numbers DT in the first place?  If you
are saying that people should tune and then put the values in here then
that's problematic for the reasons I outlined.

> > It would be better to have the DT describe concrete physical properties
> > of the system which we can then map onto numbers we like, that way if we
> > get better information in future or just decide that completely
> > different metrics are appropriate for tuning we can just do that without
> > having to worry about translating the old metrics into new ones.  We can
> > then expose the tuning knobs to userspace for override if that's needed.
> > If doing system specific tuning on vertically integrated systems really
> > is terribly important it's not going to matter too much where the tuning
> > is but we also have to consider more general purpose systems.

> As replied to Rob, I'm not sure it is so easy to find any physical
> property that expresses what we essentially need (without maybe relying
> on a complex mix of hardware details and a model to extract numbers from
> them). Instead, we propose to have reasonable, per SoC, default numbers;
> and then let users fine tune their platform afterwards, without changing
> those default values.

If users are supposed to do fine tuning elsewhere after the fact why
bother with this initial callibration?  Something that's ballpark good
enough like just knowing the core used and perhaps some important
options on it should give an adequate starting point and not have the
issues with having the tuning numbers present as magic numbers.  Perhaps
we might also feed cache information in at some point.  If in future
we're able to improve those default numbers (or just adapt at runtime)
then even better.

It also seems a bit strange to expect people to do some tuning in one
place initially and then additional tuning somewhere else later, from
a user point of view I'd expect to always do my tuning in the same
place.

> > We're not going to get out of having to pick numbers at some point,
> > pushing them into DT doesn't get us out of that but it does make the
> > situation harder to manage long term and makes the performance for the
> > general user less relaible.  It's also just more work all round,
> > everyone doing the DT for a SoC is going to have to do some combination
> > of cargo culting or repeating the callibration.

> I'm most probably a bit naive here, but I see the calibration phase
> happening only once, after the platform is stable. You get default
> capacity values by running a pretty simple benchmark on a fixed
> configuration; and you put them somewhere (DTs still seem to be a
> sensible place to me). Then you'll be able to suit tuning needs using
> different interfaces.

My point is that everyone making any kind of SoC with asymmetries is
expected to go and do some kind of callibration based on some unclear
criteria, if these are just ballpark accurate starting points that seems
like wasted effort - the kernel should be making a reasonable effort to
do something sensible without this information which is going to be less
effort all round.  It doesn't need to wait for real silicon (this seems
like the sort of core bit of DT which will be being written pre-tapeout)
and doesn't have marketing implications.

Doing that and then switching to some other interface for real tuning
seems especially odd and I'm not sure that's something that users are
going to expect or understand.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151211/9f896f5f/attachment.sig>
