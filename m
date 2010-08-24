From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Tue, 24 Aug 2010 17:47:41 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <201008241726.08797.arnd@arndb.de>
References: <4C61EE55.5030506@codeaurora.org>
	<201008191309.15425.arnd@arndb.de>
	<20100824150655.GB2160@osiris.boeblingen.de.ibm.com>
	<201008241726.08797.arnd@arndb.de>
Message-ID: <20100824154740.GD2160@osiris.boeblingen.de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 05:26:08PM +0200, Arnd Bergmann wrote:
> On Tuesday 24 August 2010, Heiko Carstens wrote:
> > > (Taking Martin and Heiko on Cc for s390)
> > > 
> > > I'd strongly suggest making the behavior the same for everyone. It should
> > > be fairly easy to make sure none of these warnings ever triggers
> > > on s390, because most of the Linux device driver code does not get build
> > > there anyway.
> > 
> > Please don't do that. An s390 allyesconfig still triggers 45 warnings and
> > I'm currently not willing to "patch" working code just to get rid of these
> > warnings which are most likely all false positives.
> > That's the reason why we currently don't error out and only generate
> > warnings.
> 
> Can't you just turn that option off then? Or are you worried about
> allyesconfig builds?

I'd like to keep an allyesconfig compiling and booting.
With the proposed change we would never see a green entry at
http://kisskb.ellerman.id.au/kisskb/branch/9/ for s390's allyesconfig
build ;)
And it would make it a bit harder to find the usual !HAS_DMA and
!HAS_IOMEM build breakages we see quite frequently. No reason to make
it even more difficult to keep s390 compiling.

> The current state is confusing because on s390
> CONFIG_DEBUG_STRICT_USER_COPY_CHECKS means that gcc will warn rather
> than ignore the finding, while on all others, the same option turns
> a warning into an error.

Then maybe add a "choice" Kconfig option in a way that both allyesconfig
as well as allnoconfig will build?
