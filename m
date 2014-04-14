From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Apr 2014 14:43:53 +0100
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <20140414151236.75f8816d@skate>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
 <20140414151236.75f8816d@skate>
Message-ID: <20140414134353.GI24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 03:12:36PM +0200, Thomas Petazzoni wrote:
> Dear Chao Xie,
> 
> On Fri, 21 Mar 2014 15:01:58 +0800, Chao Xie wrote:
> 
> > +/*
> > + * Marvell's PJ4 core is based on V7 version. It has some modification
> > + * for coprocessor setting. For this reason, we need a way to distinguish
> > + * it.
> > + */
> > +#ifndef CONFIG_CPU_PJ4
> > +#define cpu_is_pj4()	0
> > +#else
> > +static inline int cpu_is_pj4(void)
> > +{
> > +	unsigned int id;
> > +
> > +	id = read_cpuid_id();
> > +	if ((id & 0xfffffff0) == 0x562f5840)
> > +		return 1;
> 
> Unfortunately, this doesn't work correctly, because this cpuid check
> also matches Armada XP, which uses the PJ4B-MP core, but does not have
> the iWMMXt extension. Therefore, when you build mach-mvebu with Dove
> support enabled, it does not boot on Armada XP: it fails with an
> undefined instruction.

Grr, that's annoying.  And we can't just revert this because of the
arm-soc debacle - doing so will break the boot for a whole pile of
other platforms.

This is a nice illustration of why the arm-soc process - with arm-soc
effectively *forcing* me to take patches - is rather broken.  I hope
arm-soc people start behaving more responsibly in the future.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
