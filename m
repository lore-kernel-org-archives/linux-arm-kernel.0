From: mike.turquette@linaro.org (Mike Turquette)
Date: Wed, 23 Jul 2014 17:33:14 -0700
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
 <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
 <53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
Message-ID: <20140724003314.6419.51564@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2014-07-20 05:07:32)
> On 19 July 2014 20:54, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > Sorry for jumping late
> 
> No, you aren't late. Its just 2 days old thread :)
> 
> > but one of the point I was raising as part of your
> > other series was to extend the CPU topology bindings to cover the voltage
> > domain information which is probably what is really needed to let the
> > CPUfreq extract the information. Not sure if it was already discussed.
> 
> Not it wasn't.
> 
> > After all the CPU clocks, cluster, clock-gating, power domains are pretty much
> > related. So instead of having new binding for CPUFreq, I was wondering whether
> > we can extend the CPU topology binding information to include missing information.
> > Scheduler work anyway needs that information.
> >
> > Ref: Documentation/devicetree/bindings/arm/topology.txt
> >
> > Does that make sense ?
> 
> Yeah it does, but I am not sure what exactly the bindings should look then.
> So, the most basic step could be moving the new bindings to topology.txt
> and name clock-master to dvfs-master.
> 
> What else?

If we're going to model the hardware then the binding should not use the
CPU phandles in "clock-master" or "dvfs-master". The correct thing to
model for a given CPU is which clock consumes. It's not accurate to say
that one CPU is the "master", at least not in this context.

A previous approach tried to compare struct clk pointers, which is a bad
idea since those are just cookies and should not be deref'd by drivers.
However a similar approach would be to compare the phandle, right?

Regards,
Mike

> 
> If its going to be much controversial then we *can* go for just dvfs bindings
> for now and then update them later.
> 
> Doesn't make sense? :)
