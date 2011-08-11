From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2011 15:47:38 +0200
Subject: [Ksummit-2011-discuss] experience with the new arm-soc workflow
	(Was: Re: ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <20110806212932.GT31521@pengutronix.de>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
Message-ID: <201108111547.38520.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 August 2011, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sat, Aug 06, 2011 at 06:59:00AM -0700, Olof Johansson wrote:
> > I'd like to hear from Arnd what his experiences from this first merge
> > window were -- what worked well and where's room for improvement? Any
> > particular SoC workflow that should be tuned to make his life easier?
> > Where are the gaps where he needs help right now? And how did it work
> > out for the SoC maintainers?

I have actually submitted a proposal for LinuxCon for a session where
I would talk about the status and lessons learned so far.

My feeling with the 3.1 merge window was that it went better than I
had expected, once I actually started taking patches. I think initially
each of us (Nicolas, Thomas and me) was waiting for the others to
start doing something, and in the end it turned out to be me merging
almost all of the branches. I don't see this as a problem, but it
wasn't exactly how we had planned it initially.

> I'm neither Arnd nor a SoC maintainer, but another level further down
> (read: contributor).
> My thoughts about the fixes-cleanups-newfeatures separation is that it
> makes contributing harder than before.
> 
> Consider I want to contribute a series consisting of a cleanup and a new
> feature (that depends on the cleanup). And I want (or even need) to base
> this on (say) Sascha's imx tree that already has some other features.
> Now the cleanup patch should go on Sascha's (eventually empty) cleanup
> branch. But for the feature patch to go on top of both Sascha's feature
> branch and his new cleanup branch, he either needs so rebase his feature
> branch (which is (at least considered) bad) or he has to merge. I'd say
> merging is the correct approach, but the history tends to be more ugly
> than without the separation between cleanups and new features.
> And if Sascha wants to pull from me (opposed to apply the patches
> himself) he needs two merges. 
> (So it results in one merge more than before for both cases.)

The main reason for starting this separation was to have logically
distinct sets of pull requests to send forward to Linus.
The problem that I'm facing here is that there are a lot of
cleanups (I expect more for 3.2 than there were for 3.1) that
cross all platforms and that have possible conflicts with all
the other per-soc branches.

I think the scenario that you have outlined is relatively rare
and also easily worked around by having multiple sets of branches,
like

1. bug fixes
2. cleanups
3. invasive feature 1
4. cleanups based on 3
5. feature 2, based on 4
6. bug fixes based on 5

etc.

> I'm not sure how welcomed these additional merges are by Linus.
> 
> The obvious (to me) ways out are:
>  a) Linus can live with these merges; or
>  b) drop the separation between cleanup and features; or
>  c) Sascha doesn't publish a (fast-forward-only) tree but works with
>     a patch queue or git-rebase; or
>  d) Sascha keeps my series separate from his other stuff and requests
>     Arnd to pull two (or more) cleanup branches and two (or more)
>     feature branches; or
>  e) Sascha needs something like topgit;
> 
> As this problem didn't occur yet in real life, there might be
> 
>  f) there is no real problem.
> 
> I fear a) and f) don't apply, I don't like c) and d) and I know
> Sascha won't like e).

I really want to see d). Having a single branch per feature is
not the ideal situation, I would much rather see multiple such
branches, so for each new feature, you do:

1. all necessary cleanups in one branch
2. the actual new non-cleanup code, based on that branch

When a platform maintainer submits cleanups, it's normally ok
to have them all in one branch, since I expect them to be
totally uncontroversial.

For the features, I want to see one branch per major feature in
the arm-soc tree, which means that these branches need to come
through the platform maintainer tree separately. Moreover, we
often have dependencies between some features in the architecture
tree and code going through other trees (gpio, devicetree, mmc, ...).

It's totally fine for me to base one feature for a platform on
a commit from, e.g. the mmc tree plus some cleanups in the arch
code. I will then wait for the mmc tree to get merged upstream
before submitting the new feature based on it. However, if I get a
platform branch that relies on changes that went into five other
trees, I can't push any of those platform changes before all the
other trees have gone upstream.

	Arnd
