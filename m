From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Wed, 23 Jul 2014 15:08:49 -0400
Subject: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <20140723173204.GB21746@e102568-lin.cambridge.arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJ5Y-eY9YACzk_8LpZ9mnaj4stqOF_uWWt1+tL7nexqZj-ZFyQ@mail.gmail.com>
 <20140723173204.GB21746@e102568-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-eZrFJzG_47OZg2vx=ZgYw0tBDdXNxPJXreJeKoipPh5kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 23 July 2014 13:32, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > +/**
>> > + * dt_init_idle_driver() - Parse the DT idle states and initialize the
>> > + *                        idle driver states array
>> > + *
>> > + * @drv:         Pointer to CPU idle driver to be initialized
>> > + * @start_idx:    First idle state index to be initialized
>> > + *
>> > + * On success the states array in the cpuidle driver contains
>> > + * initialized entries in the states array, starting from index start_idx.
>> > + *
>> > + * Return:
>> > + *     0 on success
>> > + *     <0 on failure
>> > + */
>> > +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
>> > +{
>> > +       unsigned int i, state_idx = start_idx;
>> > +       struct cpuidle_state *idle_state;
>> > +       struct device_node *state_node, *cpu_node;
>> > +
>> > +
>> > +       if (state_idx >= CPUIDLE_STATE_MAX)
>> > +               return -EINVAL;
>> > +       /*
>> > +        * We get the idle states for the first logical cpu in the
>> > +        * driver mask. The kernel does not check idle states on all
>> > +        * cpus in the driver mask, they are assumed to be the same
>> > +        * by default.
>> > +        */
>> > +       cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
>>
>> Is this an assumption for the short term? My understanding from the
>> corresponding ACPI discussions is that the order of idle states may
>> not necessarily be same for all CPUs, even for big.Little?
>
> Well, it is more of a problem of the CPUidle infrastructure than related
> to this specific patchset. The idle states for a specific cpumask (ie CPUidle
> driver) are expected to be all the same, same order same data.
>
> Current driver can be used on homegeneous ARM64 SMP systems, but I am fairly
> confident we can extend it for big.LITTLE and also other funky SMP
> configurations, the parsing code only expects all cpus in the mask
> to have the same set of idle states (and so does the CPUidle core), if that's
> not the case, the cpus belong in different CPUidle drivers (ie a CPUidle
> driver is a set of states valid on a cpumask).
>
> So my answer is yes, it is a proper assumption and not only for the
> short term, but in general.
>
> HTH,
> Lorenzo

Ok. Thanks for the explanation. I just had a look at
drivers/cpuidle/cpuidle-big_little.c. So, you'll need another call to
cpuidle_register() should there be another cpumask with a different
set of idle states.

Cheers,
Ashwin
