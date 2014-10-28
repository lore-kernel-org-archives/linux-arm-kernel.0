From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 17:03:28 +0100
Subject: [PATCH v2 3/5] ARM: restrict CPU_BIG_ENDIAN configuration option
In-Reply-To: <20141028145319.GJ27405@n2100.arm.linux.org.uk>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <3137318.QMDnWOWDgo@wuerfel> <20141028145319.GJ27405@n2100.arm.linux.org.uk>
Message-ID: <3079221.bd19bgau9Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 14:53:19 Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 03:37:52PM +0100, Arnd Bergmann wrote:
> > On Tuesday 28 October 2014 14:00:22 Russell King - ARM Linux wrote:
> > > On Tue, Oct 28, 2014 at 09:31:33PM +0800, Xia Kaixu wrote:
> > > > Some platforms don't work when CPU_BIG_ENDIAN is enabled.
> > > > So It can get a dependency on !ARCH_MULTIPLATFORM_STRICT.
> > > 
> > > What if big endian wants to build a multiplatform kernel?
> > 
> > They can turn off ARCH_MULTIPLATFORM_STRICT easily.
> 
> Why should they?  Building a kernel for a group of big endian platforms
> is no different from building the kernel for a group of little endian
> platforms.
> 
> Look, think about the set.  There are three distinct possibilities.
> 
> 1. The group of platforms which can be big endian.
> 2. The group of platforms which can be little endian.
> 3. The intersection of both groups which can be either endian.
> 
> Why should ARCH_MULTIPLATFORM_STRICT effectively platforms falling in
> set 1 from being built?  What's special about them?  The answer is,
> absolutely nothing.  This has /nothing/ what so ever to do with
> multiplatform-ness.

It's an empty set at the moment. Nobody has built an ARM CPU core that
is big-endian only, at least none that we support.

All platforms support little-endian, and some platforms have at least
some drivers that work when building for big-endian.

> What it does have to do with is whether the platforms can be built with
> one endian-ness or the other.  That's why I said:
> 
> > > This doesn't look right to me.  Instead, we should be arranging for
> > > those which do not work in BE mode to depend on !CPU_BIG_ENDIAN.
> > > Yes, it's a larger patch but IMHO is a much more correct solution.
> 
> which means that the platforms which are part of a multiplatform kernel
> need to depend on CPU_BIG_ENDIAN, !CPU_BIG_ENDIAN, or nothing depending
> on which of the three groups above they belong to.
> 
> Making them depend on some weird new "strict" idea is soo absurd it's
> broken.  It's not looking at the real picture here.

I prototyped an earlier version of this path that had a
BROKEN_MULTIPLATFORM option with the opposite meaning of
ARCH_MULTIPLATFORM_STRICT. I liked the old naming a little better,
because writing

	config MMU
		bool "MMU-based Paged Memory Management Support" if !BROKEN_MULTIPLATFORM
		default y

seemed to be a clearer wording, but having the positive logic made
it easier to have the defaults I wanted for allmodconfig.

My earlier patch also didn't include CPU_BIG_ENDIAN in the dependencies,
because as you say it's not a hardware dependency, but I still think
it's not too much of a stretch.

> > I've also asked Kaixu to put this one in, mostly for the side-effect
> > of getting an allmodconfig kernel to be little-endian, but also
> > because we don't really know which platforms are ok to run on
> > big-endian.
> 
> Why should an allmodconfig kernel be little endian?  It's just as valid
> to have an allmodconfig big endian kernel.

Because it would be extremely helpful to be able to test an allmodconfig
kernel easily. I know you can do it with KCONFIG_ALLCONFIG=
but I think it's valuable if a lot of people can do a very simple
test by building an allmodconfig kernel and running it in qemu (or
a random piece of ARMv7 hardware) with their own kernel changes and a
prebuilt user space image that contains the kselftest binaries.

We talked a lot about simplifying this kind of automated regression
testing at the kernel summit, and the main message was to make it
as simple as humanly possible if we want people to run it.

> > I would assume that most platforms have at least some
> > platform-specific drivers that are not endian-clean, and even if
> > the platform works big-endian in principle, it's unclear if
> > everything works.
> 
> Right, which means we start off with everything falling into sets (1) or
> (2) initially, and if people care about the "either" case, that's up for
> them to sort out.  Generally, what people care about are the first two
> cases, because they specifically intend to run their platform in BE or
> LE mode.
> 
> It is /very/ rare to decide to switch endianness on a platform from day
> to day.

The people that are interested in big-endian builds usually just use
a platform that is otherwise used in little-endian mode, and they care
about only a small subset of the drivers, so it's safe to assume that
a large chunk of all ARM specific drivers are broken.

When the goal is testing for regressions, we have to start out with
the largest possible subset of the kernel that actually works.

There is also value in building a big-endian kernel and testing that
on a large set of machines (which Kevin also does with multi_v7_defconfig),
but I don't think it's useful to make that the default.

	Arnd
