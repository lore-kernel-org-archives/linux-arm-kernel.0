From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Apr 2014 22:39:04 -0400 (EDT)
Subject: [PATCH v2 06/12] ARM: mcpm: change max clusters to 4
In-Reply-To: <20140410095650.GA5499@e103592.cambridge.arm.com>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-7-git-send-email-haojian.zhuang@linaro.org>
 <20140410095650.GA5499@e103592.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1404102203590.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Apr 2014, Dave Martin wrote:

> On Tue, Apr 08, 2014 at 04:00:46PM +0800, Haojian Zhuang wrote:
> > In order to support 4 clusters with 4 Cortex A15 Cores in each cluster,
> > enlarge maximum clusters from 2 to 4 in MCPM.
> 
> CC Nico on mcpm patches please.  I'm happy to be CC'd as well.

Indeed.

> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> > ---
> >  arch/arm/include/asm/mcpm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
> > index 608516e..68f82cf 100644
> > --- a/arch/arm/include/asm/mcpm.h
> > +++ b/arch/arm/include/asm/mcpm.h
> > @@ -20,7 +20,7 @@
> >   * to consider dynamic allocation.
> >   */
> >  #define MAX_CPUS_PER_CLUSTER	4
> > -#define MAX_NR_CLUSTERS		2
> > +#define MAX_NR_CLUSTERS		4
> 
> Because of the need for alignment to the biggest cacheline size in the
> system, the MCPM low-level locking structures consume a non-trivial
> amount of memory.
> 
> Therefore, I'm not keen on the idea of simply increasing this #define
> every time a platform appears with a larger number of clusters.
> If hip04 is not built into the kernel, this just wastes memory.
> 
> I'll leave it to Nico to decide whether we can increase the #define
> to 4 or whether this needs a proper fix now.  Ideally, we would have
> a way of choosing the maximum value required by the set of boards built
> into the kernel, or switch to dynamic allocation.

I think we should go with the ability to select a maximum based on the 
configured platforms. That could be as simple as having a 
CONFIG_MCPM_QUAD_CLUSTER symbol to be selected by those platforms that 
need it.

The memory usage is still relatively low: 4 clusters containing 6 
independent cache lines each, so for a 64-byte cache line this means 
1536 bytes.  That is rather insignificant compared to the amount of 
memory fitted to typical multi-cluster systems, especially quad cluster 
systems.  Unless there is yet more expansion of clusters and/or CPUs per 
cluster to come amongst MCPM users, I don't think we've yet reached the 
tipping point where the complexity of dynamic memory allocation for this 
is worth it.

However, changing MAX_NR_CLUSTERS cannot be done without also modifying 
the code in bL_switcher_init() or the b.L switcher won't work anymore on 
dual cluster systems as soon as a quad cluster system is configured in. 
Simply removing the test against MAX_NR_CLUSTERS should be sufficient as 
there is already a runtime validation test in bL_switcher_halve_cpus().


Nicolas
