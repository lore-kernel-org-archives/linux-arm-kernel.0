From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 18 Nov 2011 12:20:47 +0000
Subject: [PATCH 2/5] ARM: vexpress: Remove platform SMP functions from
 ct_desc
In-Reply-To: <20111117153102.GQ9581@n2100.arm.linux.org.uk>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-3-git-send-email-pawel.moll@arm.com>
 <20111117153102.GQ9581@n2100.arm.linux.org.uk>
Message-ID: <1321618847.24216.321.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-11-17 at 15:31 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 11, 2011 at 06:27:03PM +0000, Pawel Moll wrote:
> > This patch removes platform SMP callbacks from ct_desc struct
> > and replaces them with global symbols in preparation for
> > DT-based support code.
> 
> Will and myself discussed how to do this, and we came up with the
> ct_desc solution.  Now you're doing something different.  It seems to
> me like there's a disconnect between various different parts of ARM Ltd
> between people who have different ideas about how problems are to be
> solved.

There are gaps (about 50-100m) between the buildings here indeed. And
you have to cross a road... Thankfully we have some network cables
underneath it. 

> So, what's the technical reason for this change?

I was remember when Will was adding the tile-detection code. That seemed
the best solution at the time (and spared us getting new mach type
number for every new tile), with no DT at the horizon. Situation changed
since and the tiles are just separate DT-only machine descriptions, as
your original implementation. There will be no more users of the
ct_desc.

> I can't see how this improves anything. 

It's not a improvement, just a workaround because that:

 void __init smp_init_cpus(void)
 {
-       ct_desc->init_cpu_map();
 }

implies existence of the ct_desc. But fair enough, I'll simply create
fake ones for the DT cases so this code won't have to be changed. As
soon as the platform SMP calls are abstracted, which as I understand is
one of steps on the mythical "single binary kernel" way, the problem
will disappear.

>  In fact, this patch reintroduces
> a bug which have been previously fixed:
> 
> > +static void ct_ca9x4_init_cpu_map(void)
> > +{
> > +	int i, ncores;
> > +	ncores = scu_get_core_count(V2T_PERIPH_P2V(A9_MPCORE_SCU));
> > +
> > +	for (i = 0; i < ncores; ++i)
> > +		set_cpu_possible(i, true);
> > +
> > +	set_smp_cross_call(gic_raise_softirq);
> > +}
> vs
> > -static void ct_ca9x4_init_cpu_map(void)
> > -{
> > -	int i, ncores = scu_get_core_count(V2TILE_PERIPH_P2V(A9_MPCORE_SCU));
> > -
> > -	if (ncores > nr_cpu_ids) {
> > -		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> > -			ncores, nr_cpu_ids);
> > -		ncores = nr_cpu_ids;
> > -	}
> > -
> > -	for (i = 0; i < ncores; ++i)
> > -		set_cpu_possible(i, true);
> > -
> > -	set_smp_cross_call(gic_raise_softirq);
> > -}
> 
> When you rebase, please pay better attention to the conflicts.

Thanks for spotting that, fixed.

All comments appreciated as always, thanks!

Pawel
