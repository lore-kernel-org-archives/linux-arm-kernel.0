From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 20:04:05 +0000
Subject: [PATCH 0/4] [RFC] ARM: multiplatform: rename all mach headers
In-Reply-To: <50353689.6060404@wwwdotorg.org>
References: <201208221253.07278.arnd@arndb.de> <50353689.6060404@wwwdotorg.org>
Message-ID: <201208222004.06179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 August 2012, Stephen Warren wrote:
> On 08/22/2012 06:53 AM, Arnd Bergmann wrote:
> > I've created this series some time ago, and updated it now to
> > v3.6-rc1. The idea is to get us a big step closer to the
> > single zImage kernel across multiple ARM platforms by
> > untangling the duplicate header file names.
> > 
> > There are two branches available in the arm-soc tree:
> > 
> > 1. This series,
> >    http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/testing/mach-headers
> >    This just moves header files around and changes most of the
> >    files including them. There are a few remaining drivers
> >    and platform files that keep including a generic file name
> >    like <mach/uncompress.h>....
> 
> FWIW, I merged this with next-20120820, ignored all the non-Tegra
> conflicts, and it built and ran just fine on Tegra. There were a lot of
> conflicts overall though...

Ah, very cool, thanks for the testing. If you want, you can also
try to merge in the testing/randconfig branch and see how far
you get with enabling tegra in there. That does however require
that you also use the COMMON_CLK and SPARSE_IRQ options, and I'm
not sure what your status on those is.

> > I would like to get the first series merged in v3.7 if we can agree
> > on the general approach. So far, feedback in Linaro internal
> > meetings has been very positive, but Russell had concerns when
> > we first discussed it a few months ago.
> > 
> > A patch set this large means a lot of churn, and there are a few
> > ways we could deal with this:
> > 
> > a) Put the branch into linux-next now, and have everyone who
> > encounters conflicts pull it into their own branch to resolve
> > the conflicts. This can be a lot of work, and it means we
> > cannot rebase this branch any more.
> 
> I did a very quick test of rebasing all the Tegra branches onto this,
> and it worked out to be very easy; very few conflicts and mostly just
> files deleted in the Tegra tree this time around. One of the Tegra
> branches depends on v3.6-rc2 in order to pick up some changes that
> conflict with changes made there. If we convert to dmaengine in 3.7,
> then we'll probably depend on a later v3.6-rc for a dmaengine driver
> bug-fix. Does it make sense to rebase this mach-headers onto a later
> v3.6-rc? I suppose I could branch from v3.6-rc2, merge in mach-headers,
> and then build on that if needed.

It's only problematic if multiple people merge the same branch with
later -rc releases and fix the same conflicts in different ways.
If we get such conflicts, it would probably be best if I merge a
new -rc into my branch and let other people base on my merge
commit.

> > b) Involve Linus Torvalds in the process and get him to
> > take the series at the end of the v3.7 merge window, after
> > rebasing it on top of all the other branches he merged.
> > This means it happens pretty much ad-hoc and there is little
> > testing on the patches that actually get merged.
> 
> Given the number of merge conflicts this has with next-20120820, that
> sounds like a lot of work you need to do at the end of the merge window,
> but I suppose if it's mostly scripted, it wouldn't be too hard to
> recreate the series in a short time.

Yes, I've done it a few times.

	Arnd
