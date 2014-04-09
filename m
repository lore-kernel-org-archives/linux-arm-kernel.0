From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Apr 2014 15:06:25 +0100
Subject: [PATCH 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <20140408201212.067d526d@skate>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140408172424.GE16373@arm.com> <20140408201212.067d526d@skate>
Message-ID: <20140409140625.GI13737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 07:12:12PM +0100, Thomas Petazzoni wrote:
> On Tue, 8 Apr 2014 18:24:25 +0100, Catalin Marinas wrote:
> 
> > >  	of_init = true;
> > >  	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
> > > +
> > > +	/*
> > > +	 * PL310 doesn't need an outer cache sync operation when the
> > > +	 * system is operating with hardware coherency enabled, as it
> > > +	 * is done directly in hardware.
> > > +	 */
> > > +	if (of_device_is_compatible(np, "arm,pl310-cache") && is_coherent)
> > > +		outer_cache.sync = NULL;
> > > +
> > 
> > For this particular case, you can add a specific l2x0_of_data structure
> > with the right compatible string for your platform where
> > outer_cache.sync is NULL,
> 
> In fact, I'm not sure using a separate compatible string is possible,
> because there are situations where the hardware platform may be I/O
> coherent, and some situations where it is not the case. For example, in
> the current kernel, the platform is I/O coherent when CONFIG_SMP is
> enabled, but not I/O coherent when CONFIG_SMP is disabled. And it's the
> same hardware platform, so same Device Tree in both cases.

I think Russell has a better solution in his L2 cache cleanup series.
Patch 18/44 introduces a .fixup function which takes the outer_cache_fns
pointer and that's a place where your code can check whether coherency
is present or not (and turn .sync into NULL).

-- 
Catalin
