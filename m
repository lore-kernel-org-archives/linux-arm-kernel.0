From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 3 Oct 2014 17:37:16 +0100
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
In-Reply-To: <CAFpQJXWkL_ge8XT9y6vSNwgQgXcvQtUh4PaWxdH1dK0QhFWu2A@mail.gmail.com>
References: <1408462379-27968-1-git-send-email-broonie@kernel.org>
 <CAFpQJXWkL_ge8XT9y6vSNwgQgXcvQtUh4PaWxdH1dK0QhFWu2A@mail.gmail.com>
Message-ID: <20141003163715.GB13939@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 06:01:50AM +0100, Ganapatrao Kulkarni wrote:
> Hi Mark,
> 
> On Tue, Aug 19, 2014 at 9:02 PM, Mark Brown <broonie@kernel.org> wrote:
> > From: Mark Brown <broonie@linaro.org>
> >
> > The only requirement the scheduler has on cluster IDs is that they must
> > be unique.  When enumerating the topology based on MPIDR information the
> > kernel currently generates cluster IDs by using the first level of
> > affinity above the core ID (either level one or two depending on if the
> > core has multiple threads) however the ARMv8 architecture allows for up
> > to three levels of affinity.  This means that an ARMv8 system may
> > contain cores which have MPIDRs identical other than affinity level
> > three which with current code will cause us to report multiple cores
> > with the same identification to the scheduler in violation of its
> > uniqueness requirement.
> >
> > Ensure that we do not violate the scheduler requirements on systems that
> > uses all the affinity levels by incorporating both affinity levels two
> > and three into the cluser ID when the cores are not threaded.
> >
> > While no currently known hardware uses multi-level clusters it is better
> > to program defensively, this will help ease bringup of systems that have
> > them and will ensure that things like distribution install media do not
> > need to be respun to replace kernels in order to deploy such systems.
> > In the worst case the system will work but perform suboptimally until a
> > kernel modified to handle the new topology better is installed, in the
> > best case this will be an adequate description of such topologies for
> > the scheduler to perform well.
> >
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index b6ee26b..5752c1b 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -255,7 +255,8 @@ void store_cpu_topology(unsigned int cpuid)
> >                 /* Multiprocessor system : Multi-threads per core */
> >                 cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> >                 cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > -               cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> > +               cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
> > +                                        MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
> >         } else {
> >                 /* Multiprocessor system : Single-thread per core */
> >                 cpuid_topo->thread_id  = -1;
> Can you please extend this for non-SMT case also?

To be honest with you all I would have preferred to sort this out with
DT, that's already doable now without this patch.

Having said that, for platforms setting MPIDR_EL1 to reasonable values,
I think that's what we should do, squash the upper MPIDR levels (for
the non SMT case too). Please stick a proper comment for that to the code.
We can always rely on DT to fix other cases that can't be treated
properly with code above.

AFAIK book topology level is unused in the kernel at the moment, that
would have been a candidate for the additional MPIDR level(s).

I took some time to think about that, since I am aware of tools (ie
powertop) taking the socket id value verbatim, which can become a big
number when we squash it. Since it is not a userspace API (or at least
it is written nowhere that the socket id value must be a sequential,
monotonic value starting from 0 and and on top of that that's an arch specific
id that as far as I know must only be unique) I think the change above (plus
additional code for non-SMT case) is acceptable.

Mark, do you want me to write the patch or you will do it ?

Fine either way by me, thanks.
Lorenzo
