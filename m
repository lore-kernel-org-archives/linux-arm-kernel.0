From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 18:04:23 +0100
Subject: [RFC PATCH v4 01/18] ARM: kernel: fix arm_dt_init_cpu_maps() to
 skip non-cpu nodes
In-Reply-To: <CAL_JsqLdbbsBeEaUT5BcxjZnbjEiu=qsPsynxCXdgi1J=ejzTg@mail.gmail.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368804061-4421-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLdbbsBeEaUT5BcxjZnbjEiu=qsPsynxCXdgi1J=ejzTg@mail.gmail.com>
Message-ID: <20130517170422.GF27589@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 05:31:18PM +0100, Rob Herring wrote:
> On Fri, May 17, 2013 at 10:20 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The introduction of the cpu-map topology node in the cpus node implies
> > that cpus node might have children that are not cpu nodes. The DT
> > parsing code needs updating otherwise it would check for cpu nodes
> > properties in nodes that are not required to contain them, resulting
> > in warnings that have no bearing on bindings defined in the dts source file.
> 
> Great, so a new DT with cpu-map entries may not work with old kernels.
> Please check the behavior. This should go to stable kernels.

You are right, and I do not see any other solution if we want the
cpu-map node to live in the cpus node; at the time we added the cpus/cpu
bindings we thought that the cpus node's children would be restricted to cpu
nodes, and well, we are changing that, this is one of the consequences.

Yes, this patch should go to stable kernels, I will do that.

Lorenzo

> Rob
> 
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/kernel/devtree.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> > index 5af04f6..904cad5 100644
> > --- a/arch/arm/kernel/devtree.c
> > +++ b/arch/arm/kernel/devtree.c
> > @@ -92,6 +92,9 @@ void __init arm_dt_init_cpu_maps(void)
> >         for_each_child_of_node(cpus, cpu) {
> >                 u32 hwid;
> >
> > +               if (of_node_cmp(cpu->type, "cpu"))
> > +                       continue;
> > +
> >                 pr_debug(" * %s...\n", cpu->full_name);
> >                 /*
> >                  * A device tree containing CPU nodes with missing "reg"
> > --
> > 1.8.2.2
> >
> >
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss at lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
