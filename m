From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2012 18:12:46 +0000
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <7vty438575.fsf@alter.siamese.dyndns.org>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
 <7vty438575.fsf@alter.siamese.dyndns.org>
Message-ID: <201201111812.46431.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012, Junio C Hamano wrote:
> 
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Tue, Jan 10, 2012 at 12:39 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >>
> >> What about using -C instead (which implies -M, but also detects copies) ?
> >
> > I don't mind -C. It sometimes causes differences to what I see by
> > default, but those differences are often interesting.
> >
> > But while it's interesting and relevant (unlike the non-rename patch
> > that is just noisy), it also can hide lots of lines. With -C, you can
> > get a diffstat that is actually fairly small, but that adds a lot of
> > lines to the kernel (because somebody just copied large files with
> > small changes), and if that happens I do want to see it as a "big
> > change". So for me, the plain "just show renames" is a good default.
> >
> > So there is absolutely nothing wrong with -C. It's not what I use, but
> > when I see that the diffstats don't match, it's easy to notice why,
> > and that information is often fairly interesting, so I don't mind.
> 
> How about encouraging people to use stock "git request-pull" instead?
> 
> Then best/better practices can be captured as improvement patches to it,
> instead of being spread as updates to many people's homebrew scripts, no?

I keep having trouble in multiple ways with git request-pull, so I ended
up running it as part of a script on fictional commits, removing the
diffstat output, adding a new diffstat output that actually refered to
the contents I was sending (though forgetting to use -M, as Linus noted)
and adding the necessary headers that let me send out the series of
pull requests using git send-email.

I think that request-pull is fixable, but I'm not completely sure
if I'm misunderstanding something myself.

To give a realistic example, lets assume I have three branches I
want to send out as individual pull requests. Each of these branch
is the result of merging multiple of my downstream branches:

* Branch A (fixes) contains a bunch of bug fixes collected from
various people that have sent me a pull request. Some of these
are based on v3.3-rc2, others are based on v3.3-rc3 or v3.3-rc4,
so the resulting tree is based on v3.3-rc4.

* Branch B (cleanups) contains cleanup patches from multiple
sources. Some of the branches I pulled in here also contain
commits that I have on the fixes branches from the same
people, but most don't. The latest branch I have pulled in is
based on v3.3-rc5, so this has a newer base than Branch A,
but is not a complete superset of it.

* Branch C (features) contains new stuff from various people,
some of whom are basing them on top of branches that went into
A and/or B. It also contains v3.3-rc4 but no later upstream
code. However, one of the branches has a dependency on an external
tree (typically Russell's devel-stable branch), so that gets
pulled into C and I would wait for the dependency to get upstream
before submitting C.

Now let's assume that all dependencies are merged upstream already
and I just want to send out three pull requests. The first
pull request generally works fine, though it could be that some
version of git in the past would include the diff between v3.3-rc2
and v3.3-rc4 in the diffstat. For the second pull request, I merge
v3.3 with A and send do 'git request-pull B origin
tmp-merge-of-upstream-and-A'. This seems to generate the correct
list of patches, but the wrong diffstat (diffstat also contains
the diff between v3.3-rc4 and v3.3-rc5, although that is indeed
part of tmp-merge-of-upstream-and-A. For submitting branch C,
I have to merge upstream, A, B and the dependencies together
and then send a pull request against that. This typically also
includes the external dependencies in the diffstat.

	Arnd
