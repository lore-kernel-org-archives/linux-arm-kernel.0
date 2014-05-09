From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 9 May 2014 10:47:19 +0100
Subject: [PATCH RFC v3 3/6] drivers: cpuidle: implement OF based idle
 states infrastructure
In-Reply-To: <536c0f39.90ab420a.3da7.ffff86ca@mx.google.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-4-git-send-email-lorenzo.pieralisi@arm.com>
 <536c0f39.90ab420a.3da7.ffff86ca@mx.google.com>
Message-ID: <20140509094718.GD32007@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 12:12:19AM +0100, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-05-06 11:04:40)
> 
> > diff --git a/drivers/cpuidle/of_idle_states.c b/drivers/cpuidle/of_idle_states.c
> > new file mode 100644
> > index 0000000..360b7ad
> > --- /dev/null
> > +++ b/drivers/cpuidle/of_idle_states.c
> > @@ -0,0 +1,293 @@
> ...
> > +static int __init add_state_node(cpumask_t *cpumask,
> > +                                struct device_node *state_node)
> > +{
> > +       struct state_elem *el;
> > +       u32 tmp, val = 0;
> > +
> > +       pr_debug(" * %s...\n", state_node->full_name);
> > +
> > +       if (!state_cpus_valid(cpumask, state_node))
> > +               return -EINVAL;
> > +       /*
> > +        * Parse just the properties required to sort the states.
> > +        * Since we are missing a value defining the energy
> > +        * efficiency of a state, for now the sorting code uses
> > +        *
> > +        * min-residency-us+exit-latency-us
> > +        *
> > +        * as sorting rank.
> > +        */
> > +       if (of_property_read_u32(state_node, "min-residency-us",
> > +                                &tmp)) {
> > +               pr_debug(" * %s missing min-residency-us property\n",
> > +                        state_node->full_name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       val += tmp;
> > +
> > +       if (of_property_read_u32(state_node, "exit-latency-us",
> > +                                &tmp)) {
> > +               pr_debug(" * %s missing exit-latency-us property\n",
> > +                            state_node->full_name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       val += tmp;
> 
> Sorry if i'm rehashing old stuff, but I prefer not to use the
> min-residency + exit-latency to sort.  I saw Rob's comment suggesting it
> and your reply.  I'm not sure when it was decided.
> 
> Would it be possible to sort instead based on the order in the
> cpus->cpu-idle-states?  If not, my preference would be to either use
> index like you had before, or specify another sort order / rank value.

"power-rank" property ? We can't rely on the DT state nodes ordering.

I am ok with adding a power-rank property, as long as it is not frowned
upon by DT maintainers, I am running short of ideas for states sorting if
I can't use idle state properties to pull that off.

> I think there's potential for us to create lower power states that
> have lower min-residencies (reduced power consumption in the state,
> allowing us to more quickly recover the higher entrance cost)
> with higher exit latencies in such a way that the formula would not
> sort as we expect.  Having a separate value would allow us to control
> the sorting in those cases.
> 
> > +
> > +/*
> 
> For kernel-doc, I think you need a /** here, and a () after the
> of_init_idle_driver below.  Also maybe Return: instead of Returns:
> and I think the return paragraph goes at the end, but am not positive.
> 
> kernel-doc-nano-HOWTO.txt

Ok changes done.

Thanks,
Lorenzo

> > + * of_init_idle_driver - Parse the DT idle states and initialize the
> > + *                      idle driver states array
> > + *
> > + * @drv:         Pointer to CPU idle driver to be initialized
> > + * @state_nodes:  Array of struct device_nodes to be initialized if
> > + *               init_nodes == true. Must be sized CPUIDLE_STATE_MAX
> > + * @start_idx:    First idle state index to be initialized
> > + * @init_nodes:   Boolean to request device nodes initialization
> > + *
> > + * Returns:
> > + *     0 on success
> > + *     <0 on failure
> > + *
> > + *     On success the states array in the cpuidle driver contains
> > + *     initialized entries in the states array, starting from index start_idx.
> > + *     If init_nodes == true, on success the state_nodes array is initialized
> > + *     with idle state DT node pointers, starting from index start_idx,
> > + *     in a 1:1 relation with the idle driver states array.
> > + */
> > +int __init of_init_idle_driver(struct cpuidle_driver *drv,
> > +                              struct device_node *state_nodes[],
> > +                              unsigned int start_idx, bool init_nodes)
> > +{
> 
> Thanks!
> 
> Sebastian
> 
