From: broonie@sirena.org.uk (Mark Brown)
Date: Thu, 3 Sep 2009 11:57:23 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903015608.GB3917@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
	<20090902191626.GP25153@trinity.fluff.org>
	<20090903015608.GB3917@prithivi.gnumonks.org>
Message-ID: <20090903105722.GA2954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 10:56:08AM +0900, Harald Welte wrote:
> On Wed, Sep 02, 2009 at 08:16:26PM +0100, Ben Dooks wrote:

> > Most GPIO setup is done in the bootloader, but there is more that sometimes
> > needs to be done in either the board file or occasionally the driver. The
> > drivers that need help with this, get passed a callback function with the
> > platform data to do the necessary setup (see the sdhci callbacks, i2c, etc).

> yes.  Though honestly speaking, I have my doubts if this is the best solution.
> On the OMAP keypad driver e.g. they simply pass an array of GPIO numbers into
> the driver, where the driver then simply makes gpiolib calls to reconfigure
> the GPIO's.  No special SoC specific API, no custom callbacks that every
> board will have to provide or at least assign.

There's also the approach used by some other platforms like PXA and i.MX
where you have a big table of all the MFP assignments in the machine
driver which gets done statically at system startup.  With that scheme
the drivers don't get involved in the pin function assignment at all.

> Which brings us to the next question: where and how should s3c/s5p related
> code be (re)based on?  Right now Samsung is working with 2.6.31-rc8 mainline
> (and will keep syncing) both for their submit-missing-6410 work, as well as
> for their current s5pc110 related development.

I can't speak for Ben.  However...

In general if you track only Linus' current tree then you're going to be
working with stale code, particularly as the development cycle
progresses since you'll be missing all the development that's gone on
since the last merge window.

The specific tree will depend on the part of the kernel you're working
against, but almost all of them are regularly merged into Stephen
Rothwell's linux-next tree so that's a good place to look:

	git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git

(though that's not a good thing to actually base development on directly
unless you're happy doing a lot of git rebasing and dealing with the odd
bit of bleeding edge breakage.)

> Can we somehow work on a model where Samsung accepts contributions into
> their tree?  As I understand s5pc1xx is still very fast moving ahead all the
> time and even Samsung does not consider their code as being finished by any
> means.

> I think the dualism of Samsung's code and Ben Dooks + mainline code has been a
> big resource waste in the past.  I'm looking for ways how this can be avoided
> for future code, where everyone works on one codebase, even before something is
> finished and considered ready for mainline.

I suspect that the easiest thing to achieve here will be to deal with
the issue by merging the current areas of overlap (the ones that need
regular active merging) into mainline as fast as possible and then
continuing to develop in mainline rather than waiting until the code is
perfect and feature complete.  It's been the standard kernel workflow
for a long time and things like staging are pushing towards merging even
earlier.  If required things like dependencies on BROKEN can be used to
mask the code out of Kconfig so that users don't see things that don't
work yet.

Apart from the arch/arm code this also makes life an awful lot easier
when working on drivers in the rest of the tree - dependencies on
underlying out of tree code for the architecture have been a long term
source of fun with some of the ASoC platforms, preventing build tests
and causing confusion for users.

In many ways the fact that maintaining large out of tree patch sets is
painful is a feature of the development process, not a bug :)
