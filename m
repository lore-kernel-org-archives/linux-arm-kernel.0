From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 12:18:39 +0000
Subject: [GIT PULL] at91 first cleanup series for 3.4
In-Reply-To: <4F4CB824.5010801@atmel.com>
References: <4F4674F2.8090603@atmel.com> <201202271731.03230.arnd@arndb.de>
 <4F4CB824.5010801@atmel.com>
Message-ID: <201202281218.39428.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Nicolas Ferre wrote:
> On 02/27/2012 06:31 PM, Arnd Bergmann :
> > On Thursday 23 February 2012, Nicolas Ferre wrote:
> > 
> > I cannot merge this into the next/cleanup branch because you have based it
> > on top of a non-cleanup branch. There are three ways out of this:
> > 
> > 1. rebase the entire branch on a changeset that only contains upstream and
> > cleanup branches, and let me deal with merge conflicts against the at91/9x5
> > branch.
> 
> Not only at91/9x5 branch but also at91/pm_cleanup

at91/pm_cleanup is part of the next/cleanup series, so that is fine.
You can have dependencies on anything that is part of the same set
or something that I want to send before, the one thing I cannot handle
is circular dependencies.

> > 2. Split this series into two parts, with the simple cleanups going directly
> > in as in 1, but cleanups on top of the at91/9x5 branch get applied to that
> > branch only.
> 
> The issue with this is that we remove entirely some functions: it is the
> goal of this series. So it will be difficult to split it...
> 
> It bothers me a little bit to artificially split a logical series of
> patches just because it should stand on top of unrelated branches...

Right.

> Yes this series is dependent on material already pulled in arm-soc for
> AT91 during this cycle, but I think it is still better to try to
> integrate patches "early and often".

Yes, definitely.

> > 3. Create a new next/cleanup2 branch with this pull request that I submit
> > to Linus separately from the other cleanups.
> 
> Yes, maybe it is the way to go. It is very AT91 specific and this
> cleanup spread across all AT91 SoCs and platforms. Why not create an
> at91/devel branch with all at91 material + this cleanup branch?
> 
> The problem that I see now is that it sounds difficult to build
> incremental enhancements during a development cycle: for example, I have
> several patch series which deals with the device tree that will go on
> top of this "cleanup" branch. The questions are: which branch should I
> base my work upon? Will you be able to manage those incremental
> dependencies as it seems already difficult to deal with what will be the
> base of our 3.4 DT work?

Incremental dependencies are fine as long as they are not circular.
My goal is to have something at the start of the merge window that
follows a logical structure across all platforms.

Since cleanups tend to be both large and rather obvious, the idea is
to have all cleanups done first, and then build on top of that with
patch series that do something very specific, starting out wiht a
clean implementation.

When you send DT pull requests, there is no problem having them based on
cleanups, and in fact that is very much expected to be the case.
You can also build DT patches on top of soc specific patches, or the other
way round, but not both at the same time because that would be a circular
dependency. 

Have a look at the arch/arm/arm-soc-for-next-contents.txt file
in the arm-soc tree, that lists the branches that we are preparing, their
contents and the dependencies (if any). Right now, there are very few
hard dependencies, meaning that each next/* branch is pretty much standalone.
That is very convenient for me but it typically doesn't last because people
have dependencies. If you send me a branch for next/dt that is based on
the at91/9x5 branch from next/soc, I will record that dependency in there
and we can no longer accept any pull requests for next/soc that are based
on next/dt. However, we already have next/soc2 because that has a dependency
on the external driver-core tree, so other soc specific changes that are
based on dt changes can also go in there. We can have more of those
(next/dt2, next/soc3, next/board2) when needed, but at some point it might
get a bit silly.

> > I'm also still not entirely happy with the contents because the newly
> > introduced macros all still use __raw_readl() instead of readl_relaxed(),
> 
> This "cleanup" series was not meant to modify this in addition to the
> removal of at91_sys_xxx() functions. It has already been a long effort
> and we do not want to mix all modifications together.
> I think that Jean-Christophe already told you that, BTW.

Hmm I think I missed that part. My point was that we try to reduce the number
of instances of __raw_readl. These patches spread them to more places that
will require cleaning up later. I can see how you want to keep the two changes
(__raw_readl -> readl_relaxed and at91_sys_xxx -> at91_yyy_xxx) separate, but
it would be less churn to add one patch first that converts at91_sys_xxx
to use readl_relaxed and then spread that out than converting them all after
the fact.

> > and because the rtt setup appears unnecessarily complex while at the same
> > time still not sufficient for a combined at91 kernel. It would be nice
> 
> Well, complexity of this code is pretty low and I do not see a simple
> way to deal with this (resource with/without drivers, multiple resources
> on some SoC / single on another, etc.).

The main problem here is that the presence of devices is determined by
a CONFIG_* symbol that controls the compilation of the respective
device driver. It would be nicer if the set of devices that is created
on a given board is always the same, but the arbitration between the
drivers is handled independent of which drivers are built into the kernel.

> > I've applied your series to the staging/cleanup branch for now, which
> > means it gets into linux-next but I won't send to Linus unless I get
> > an update.
> 
> So, tell me if you can create a next/cleanup2 (or any kind of "devel")
> branch with this pull request. In addition, can you please give me
> advice for my future work that is dependent on this series (and Grant's
> irqdomain work actually)...

I can do that, which would pin down the following branches:

1. next/fixes-non-critical
2. next/cleanup
3. next/soc
4. next/cleanup2

These can no longer get reordered when I do that, but any other branches are
still independent of these and can be arbitrarily moved around anywhere after
next/cleanup.

We can easily put the irqdomain tree into one of the next/* branches as a
dependency, which causes that particular branch to get delayed until Grant
has got his patches upstream. If you send me a series for next/boards that
depend on irqdomain, I would probably put that into a next/boards2 branch
or into a next/irqdomain branch in case I get similar things from multiple
people. If Grant's patches are already upstream by the time I get to send
out the next/boards branch to Linus, I would probably merge next/boards2
into next/boards and send all of it together.

	Arnd
