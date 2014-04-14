From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Apr 2014 17:27:04 +0200
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <20140414134353.GI24070@n2100.arm.linux.org.uk>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
 <20140414151236.75f8816d@skate>
 <20140414134353.GI24070@n2100.arm.linux.org.uk>
Message-ID: <36027355.fvRVpQ1JzM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 14:43:53 Russell King - ARM Linux wrote:
> On Mon, Apr 14, 2014 at 03:12:36PM +0200, Thomas Petazzoni wrote:
> > Dear Chao Xie,
> > 
> > On Fri, 21 Mar 2014 15:01:58 +0800, Chao Xie wrote:
> > 
> > > +/*
> > > + * Marvell's PJ4 core is based on V7 version. It has some modification
> > > + * for coprocessor setting. For this reason, we need a way to distinguish
> > > + * it.
> > > + */
> > > +#ifndef CONFIG_CPU_PJ4
> > > +#define cpu_is_pj4()       0
> > > +#else
> > > +static inline int cpu_is_pj4(void)
> > > +{
> > > +   unsigned int id;
> > > +
> > > +   id = read_cpuid_id();
> > > +   if ((id & 0xfffffff0) == 0x562f5840)
> > > +           return 1;
> > 
> > Unfortunately, this doesn't work correctly, because this cpuid check
> > also matches Armada XP, which uses the PJ4B-MP core, but does not have
> > the iWMMXt extension. Therefore, when you build mach-mvebu with Dove
> > support enabled, it does not boot on Armada XP: it fails with an
> > undefined instruction.
> 
> Grr, that's annoying.  And we can't just revert this because of the
> arm-soc debacle - doing so will break the boot for a whole pile of
> other platforms.

It is very unfortunate that the bug didn't get caught earlier in order
to get fixed before the merge window. Having Marvell Dove enabled in
multi_v7_defconfig in the branch I submitted to Linus was a stupid
mistake of mine, no malicious intentions, and I already apologized
for that before.

> This is a nice illustration of why the arm-soc process - with arm-soc
> effectively *forcing* me to take patches - is rather broken.  I hope
> arm-soc people start behaving more responsibly in the future.

Do you have a better idea?

We could for the moment make Dove mutually exclusive with the other
platforms it breaks in Kconfig for the moment if you think that would
be better. That would at least avoid the regression against 3.14
at the expense of losing the dove multiplatform support.

We can then decide later after we have a proper fix whether we are
confident enough that it works in all cases, or whether it's too
late for 3.15 by then.

	Arnd
