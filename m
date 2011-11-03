From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 22:44:52 +0000
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <201111031816.37427.vapier@gentoo.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<201111031816.37427.vapier@gentoo.org>
Message-ID: <20111103224452.GS12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 06:16:33PM -0400, Mike Frysinger wrote:
> On Thursday 03 November 2011 13:00:44 Peter De Schrijver wrote:
> > This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested by
> > Russel King. It also converts some platforms to the new model.
> > 
> > Peter De Schrijver (3):
> >   ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
> >   ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
> >   ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
> > 
> >  arch/arm/Kconfig                           |   10 ++++++++++
> >  arch/arm/include/asm/gpio.h                |    4 ++++
> >  arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
> >  arch/arm/mach-ux500/include/mach/gpio.h    |    5 -----
> >  4 files changed, 14 insertions(+), 7 deletions(-)
> 
> i'm not sure how this is an improvement.  we go from declaring the define in 
> the right mach-specific subdir (arch/arm/mach-xxx/include/mach/gpio.h) to an 
> arm-global file (arm/Kconfig).  i'd think the ideal would be to keep all the 
> mach cruft in the mach-xxx/ subdir.

It most certainly is an improvement.

One of the things that we (the ARM community as a whole) is focused on to
is to reduce the amount of code in arch/arm through consolidation, removing
as much duplication as practical between the various SoCs.

One of the other factors that we're also focused on is:
(a) reducing the number of configurations which have to be built to properly
    build-test ARM
(b) reducing the number of kernels which have to be built to support a
    range of ARM platforms

Those two things together dictate that we remove the mach/ header files
which are included outside of the individual mach-* directories, so that
the entire kernel does not depend on anything in those mach/ header files.
That includes mach/gpio.h.

It is the long term goal of Linaro to move the ARM kernel forward to such
a point.

Having ARCH_NR_GPIO definitions in mach/gpio.h is a blocker to both these
efforts and, therefore, must be removed.  Therefore, before we have a
better solution (such as sparse gpios in the same way as we have sparse
irqs) we're going to stop the problem escalating still further by removing
the need for new definitions of this constant in yet more new mach/gpio.h
headers - which could otherwise be empty.

It's one reason why I won't be acking your patch which pushes new stuff
into the mach/gpio.h headers at a time when we're trying to get rid of
them.
