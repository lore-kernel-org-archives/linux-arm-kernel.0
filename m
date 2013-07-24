From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 24 Jul 2013 19:52:21 -0400
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <3403223.vsyjiUcZ9s@flatron>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
 <51F01D64.9060609@gmail.com>
 <20130724190315.GC23879@titan.lakedaemon.net>
 <3403223.vsyjiUcZ9s@flatron>
Message-ID: <20130724235221.GF23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 01:29:28AM +0200, Tomasz Figa wrote:
> On Wednesday 24 of July 2013 15:03:15 Jason Cooper wrote:
> > On Wed, Jul 24, 2013 at 01:31:00PM -0500, Rob Herring wrote:
> > > On 07/24/2013 10:27 AM, Olof Johansson wrote:
> > > > Every now and then I come across a binding that's just done
> > > > Wrong(tm),
> > > > merged through a submaintainer tree and hasn't seen proper review --
> > > > if it had, it wouldn't look the way it does. It's something we're
> > > > starting to address now since there's more people stepping up to be
> > > > maintainers, but there's a backlog of bad bindings already merged.
> > > > 
> > > > Often they are produced by translating the platform_data structures
> > > > directly over into device-tree properties without consideration to
> > > > describing the hardware or usual conventions, using key/value pairs
> > > > instead of boolean properties, etc.
> > > > 
> > > > Getting involved in cleaning up these kind of bindings is a great
> > > > way
> > > > to learn "the ways of device tree" for someone that has interest in
> > > > that.
> > > > 
> > > > Latest find in this area is the Maxim 8925 bindings, that I came
> > > > across since they caused a compile warning on some defconfig. I'll
> > > > post a patch to address the warning but if someone else feels like
> > > > fixing the bindings on top of it that would be appreciated!
> > > 
> > > Are they documented typically? Can we at a minimum update the
> > > documentation with a big fat warning to not use or propagate the crap.
> > > Or move the binding doc file to a fixme directory.
> > 
> > I agree, in order to do the janitorial work (which I'm not opposed to
> > helping with), we need a way to mark stable bindings.
> > 
> > fwiw, we could do a separate commit (like the kernel version commit)
> > where the only change is marking a binding as stable, and is obvious
> > from a 'git log --oneline'. eg:
> > 
> > ---->8------
> > 
> > From 65c069678cdbd5aaa6aca0d4062dab6eb9f9904c Mon Sep 17 00:00:00 2001
> > From: Jason Cooper <jason@lakedaemon.net>
> > Date: Wed, 24 Jul 2013 18:49:28 +0000
> > Subject: [PATCH] DT: binding: stable: gpio-regulator
> > 
> > A whole bunch of folks reviewed this and think it kicks ass.
> > 
> > List-of-people-responsible-for-this-travesty: ...
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  Documentation/devicetree/bindings/regulator/gpio-regulator.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> > b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt index
> > 63c6598..35ec635 100644
> > --- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> > @@ -1,3 +1,5 @@
> > +Binding status: Stable
> > +
> >  GPIO controlled regulators
> > 
> >  Required properties:
> 
> This looks fine for me, but what about adopting the scheme used for 
> drivers and having a staging subdirectory inside bindings/ directory where 
> a whole tree of staging bindings would be located? Then marking a binding 
> as stable would mean moving it out of this directory.

I'm not opposed to the concept of a staging directory per-se, I just
don't see a need for it.  We aren't coaxing horrible code into workable
form suitable for mainline.  I doubt the fixes to any given binding will
be a large patch series, much less span multiple merge windows.  It just
seems like churn to me to move stuff to 'staging', apply one patch, and
move it back.

The only advantage I see is that users would need to type 'staging' to
get to it, thus cluing them in to the tenuous state of the binding.
That is a definite advantage.  I'm at a loss to find a better
clue-hammer than this to make it clear as to the state of the binding.
To that end, I'd prefer 'unstable'.

Of course, the key question to ask is, how long will this take?  If we
think it will span multiple merge windows, then we should probably do
it.

> As for janitoring/cleanup itself, we should start some witch^Wbinding-hunt 
> to check all the existing binding for sanity and probably make a list of 
> bindings that are not acceptable and possibly contact people responsible 
> for them as they are primary candidates to work on fixing bindings they 
> introduced.
> 
> I also think we should start the periodic binding review meetings and get 
> some bindings stabilized, so they could be used as good examples for 
> people working on new bindings or fixing existing ones.

Once the witch-hunt is completed, there shouldn't be a need to do periodic
review.  It should be reviewed *before* merging.  That'll be easier once
it's a separate tree.

thx,

Jason.
