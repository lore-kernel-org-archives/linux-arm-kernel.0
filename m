From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 5 Jun 2018 10:07:13 +0530
Subject: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180602081418.jcl2vjc6saoj3z3d@localhost>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
 <20180528111358.meyle364fy6wuruf@vireshk-i7>
 <20180602081418.jcl2vjc6saoj3z3d@localhost>
Message-ID: <20180605043713.p7wxdccniowvbsi3@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-06-18, 01:14, Olof Johansson wrote:
> And what I am saying is that it sounds like a broken binding if you don't allow
> that, especially since it'll be a super common case that all CPUs will specify
> the same cooling-device specifier.

I am fine with allowing the #cooling-cells property in the cpus node if the DT
maintainers are fine with it.

@Rob: comments ?

@Olof: What about other properties which are still going to be duplicated for
the most common cases today, like: clocks, supply information, cache
information, cpu-idle-states and others. When we can duplicate these properties,
why not keep following the same for #cpu-cooling property ?

Note that the OPP table doesn't really need to get duplicated (for new
platforms) as the platforms use the v2 bindings now which just duplicates a
phandle assignment for all CPUs. Its a mess with older platforms which use the
earlier version of OPP table.

> > This property is required to declare a device as a cooling-device and
> > the device here is CPU. We use it as a cooling device by limiting its
> > higher range of frequencies, so that it doesn't generate too much
> > heat.
> > 
> > It is already there for CPU0 and CPU4, but it should really be there
> > for all the CPUs, like we have clock, supply, caches, etc.
> 
> You have #cooling-cells in the cpu node, but the actual data is in the
> thermal-zones nodes. Why isn't #cooling-cells under thermal-zones, next to
> cooling-maps?

Actually I thought about that when I worked on these patches initially and this
is why I felt convinced that the CPU nodes are the right place for this.

We add #interrupt-cells to an Interrupt controller's DT node, #gpio-cells to a
GPIO controller's DT node, #clock-cells to a clock controller's DT node and
that's exactly why we should (and we do) add #cooling-cells property to a
cooling device's DT node. This information is used in two ways, first it enables
the OS to know that the device is capable of being a cooling device and second
it tells us how many arguments will be required with a phandle of this device.

And so the cooling-maps always contain two arguments with the cooling device's
phandle (which is mostly a CPU or a gpio fan) as the #cooling-cells currently
is fixed to 2.

And so I am not really sure if thermal-zones is the right place to define this
thing. Is my understanding correct ?

-- 
viresh
