From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 23 Jul 2014 21:24:16 -0500
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <20140724003314.6419.51564@quantum>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
 <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
 <53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
 <20140724003314.6419.51564@quantum>
Message-ID: <CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 7:33 PM, Mike Turquette
<mike.turquette@linaro.org> wrote:
> Quoting Viresh Kumar (2014-07-20 05:07:32)
>> On 19 July 2014 20:54, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> > Sorry for jumping late
>>
>> No, you aren't late. Its just 2 days old thread :)
>>
>> > but one of the point I was raising as part of your
>> > other series was to extend the CPU topology bindings to cover the voltage
>> > domain information which is probably what is really needed to let the
>> > CPUfreq extract the information. Not sure if it was already discussed.
>>
>> Not it wasn't.
>>
>> > After all the CPU clocks, cluster, clock-gating, power domains are pretty much
>> > related. So instead of having new binding for CPUFreq, I was wondering whether
>> > we can extend the CPU topology binding information to include missing information.
>> > Scheduler work anyway needs that information.
>> >
>> > Ref: Documentation/devicetree/bindings/arm/topology.txt
>> >
>> > Does that make sense ?
>>
>> Yeah it does, but I am not sure what exactly the bindings should look then.
>> So, the most basic step could be moving the new bindings to topology.txt
>> and name clock-master to dvfs-master.
>>
>> What else?
>
> If we're going to model the hardware then the binding should not use the
> CPU phandles in "clock-master" or "dvfs-master". The correct thing to
> model for a given CPU is which clock consumes. It's not accurate to say
> that one CPU is the "master", at least not in this context.
>
> A previous approach tried to compare struct clk pointers, which is a bad
> idea since those are just cookies and should not be deref'd by drivers.
> However a similar approach would be to compare the phandle, right?

I think there needs to be a way to query whether a rate change for a
clock affects other children. As pointed out previously, the clock to
a core may not be shared, but it's parent that can change rates could
be shared. This could be done with functions
clk_get_parent_rate_change to return the clock in heirarchy which can
change rates, and clk_is_parent_clk which tells if one clock is a
child of another clock. It's been a while since I've looked at the
clock api. It could also be done by experiment. Change the rate for
core 0 and see if core 1's rate is changed and still equal. There's
probably some ordering issue with doing that though.

Rob
