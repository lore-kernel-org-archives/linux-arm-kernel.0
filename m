From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Nov 2012 09:08:27 -0800
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <201211261306.57407.arnd@arndb.de>
References: <pull-1353733874-990435> <201211261028.26334.arnd@arndb.de>
 <20121126113506.06c431cd@skate> <201211261306.57407.arnd@arndb.de>
Message-ID: <20121130170827.GC697@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 01:06:57PM +0000, Arnd Bergmann wrote:
> On Monday 26 November 2012, Thomas Petazzoni wrote:
> > Arnd,
> > 
> > On Mon, 26 Nov 2012 10:28:26 +0000, Arnd Bergmann wrote:
> > > On Monday 26 November 2012, Thomas Petazzoni wrote:
> > > > Right. The problem is that some of the last developments had many
> > > > dependencies against the previous developments, from various branches.
> > > > So I wasn't sure how to do this last developments, and I did merge the
> > > > branches containing the previous developments that I needed.
> > > > 
> > > > I am really open to suggestions on how to improve my Git workflow to
> > > > handle this better. It certainly wasn't my intention to have this
> > > > "test-the-merge" thing appear publicly.
> > > 
> > > One thing that Sascha Hauer first introduced was an extra branch that
> > > has everything merged together to show how you want to handle
> > > the conflicts. We'll then merge the individual branches and in the
> > > end can check if there is any difference to what you had.
> > 
> > Maybe I don't understand correctly, but the problem that I had is not a
> > problem of conflicts, but rather the need to do development *on top* of
> > branches for which pull requests had already been sent.
> 
> Ok, sorry for the confusion on my part.
> 
> > For example, the clk support in the network driver depended on:
> >  * The branch containing the new network driver to be there
> >  * The branch containing the mvebu clk infrastructure to be there
> > 
> > What should I have done to do this clk support in the network driver,
> > if not a merge of the network driver branch + the mvebu clk
> > infrastructure branch?
> 
> No, this all sounds good, there is not easier way really. Sometimes
> you can do the branches in a way that each branch works by itself
> but you don't have to do a third branch to combine the features.
> 
> In other cases, where you have multiple branches that all get
> merged through arm-soc (or another tree that uses branches like
> this), you can try to get everyone to agree on an order in advance,
> and then you just mandate that one branch has another one as
> a prerequisite.
> 
> Yet another option is to have a few patches that serve as a
> common base for multiple branches: E.g. have one patch introduce
> a new interface as a stub and base two branches on top of the
> same commit, one that uses the interface and another one that
> implements it. Again, this is not always possible.
> 
> If you do a lot of reworks at the same time, this always gets
> very hard.

Hi,

Following up on this since I'm sitting down to do the merges now. Apologies for
the delay.

What Arnd is saying is correct, and it does get hard, especially when doing
things that layer on top of each other.

What we've seen work reasonably well in some cases, is to have a set of
"cascading" branches that gets merged individually to keep the topics
together, but then get merged as bases for others. So, for example in this
case, Jason could have sent on each of the driver branches independently
or grouped them in similar groups to our branches if it made sense. The
xor branches seem to already be cascading in this sense, since the base
one (xor-cleanup-dt-binding) is base for xor-board-dt-cleanup, and so on.

Then, in your last branch that depends on everything else, merge the needed
branches together and use that as a base.

All of this is essentially what was already done, with the following tweaks:

* We don't mind seeing the individual branches instead of the "everything"
  branch in the end, even if they are a handful in number.
* Name the branch the real name when you start merging in dependencies, not
  "testmerge". :)

Because of the former, it's hard for us to spread out the mvebu pull request
across the branches like we usually do (fixes, cleanup, soc, board, dt, etc).

I'll merge this branch in now as a "late/mvebu" for the same reason as last
merge window -- it doesnt fit our branch model and it's easier to keep them as
a separate branch for that reason. I hope we can figure out a way to make this
work without doing this again for 3.9 though! :)


-Olof
