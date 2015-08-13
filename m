From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 13 Aug 2015 13:27:13 -0600
Subject: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
In-Reply-To: <55CCD35C.4000901@arm.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
 <20150813150154.GB13356@red-moon>
 <20150813154503.GO52339@linaro.org> <55CCD35C.4000901@arm.com>
Message-ID: <20150813192713.GA84868@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13 2015 at 11:26 -0600, Sudeep Holla wrote:
>
>
>On 13/08/15 16:45, Lina Iyer wrote:
>>On Thu, Aug 13 2015 at 09:01 -0600, Lorenzo Pieralisi wrote:
>>>On Thu, Aug 06, 2015 at 04:14:51AM +0100, Rob Herring wrote:
>>>>On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>[..]
>
>>>>
>>>>>+ARM CPU Power domains
>>>>>+
>>>>>+The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
>>>>>+CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
>>>>>+caches, VFP and power controller and other peripheral hardware. Generally,
>>>>>+when the CPUs in the cluster are idle/suspended, the shared resources may also
>>>>>+be suspended and resumed before any of the CPUs resume execution.
>>>>>+
>>>>>+CPUs are the defined as the PM domain consumers and there is a PM domain
>>>>>+provider for the CPUs. Bindings for generic PM domains (genpd) is described in
>>>>>+[1].
>>>>>+
>>>>>+The ARM CPU PM domain follows the same binding convention as any generic PM
>>>>>+domain. Additional binding properties are -
>>>>>+
>>>>>+- compatible:
>>>>>+       Usage: required
>>>>>+       Value type: <string>
>>>>>+       Definition: Must also have
>>>>>+                       "arm,pd"
>>>>>+               inorder to initialize the genpd provider as ARM CPU PM domain.
>>>>
>>>>A compatible string should represent a particular h/w block. If it is
>>>>generic, it should represent some sort of standard programming
>>>>interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
>>>>is rather just a mapping of what "driver" you want to use.
>>>>
>>>>I would expect that identifying a cpu's or cluster's power domain
>>>>would be done by a phandle between the cpu/cluster node and power
>>>>domain node. But I've not really looked at the power domain bindings
>>>>so who knows.
>>>
>>>I would expect the same, meaning that a cpu node, like any other device
>>>node would have a phandle pointing at the respective HW power domain.
>>>
>>CPUs have phandles to their domains. That is how the relationship
>>between the domain provider (power-controller) and the consumer (CPU) is
>>established.
>>
>>>I do not really understand why we want a "generic" CPU power domain, what
>>>purpose does it serve ? Creating a collection of cpu devices that we
>>>can call "cluster" ?
>>>
>>Nope, not for calling a cluster, a cluster :)
>>
>>This compatible is used to define a generic behavior of the CPU domain
>>controller (in addition to the platform specific behavior of the domain
>>power controller). The kernel activities for such power controller are
>>generally the same which otherwise would be repeated across platforms.
>
>Having gone through this series and the one using it[1], the only common
>activity is just cluster pm notifiers. Other than that it's just
>creating indirection for now. The scenario might change in future, but
>for now it seems unnecessary.
>
Not sure, what seems unnecessary to you. Platforms do have to send
cluster PM notifications, and they have to duplicate reference counting.
Also PM domain framework allows hierarchy which is quite desirable to
power down parts of the SoC that are powered on or have to clocked high,
until the CPU is running.

Cluster PM notifications are just one aspect of this that we currently
handle in the first submission. The patchset as a whole provides a way
to determine in Linux the last man down and the first man up and carry
out activities. There are a bunch of things that are done to power save
when the last man goes down - Turn off debuggers, switch off PLLs,
reduce bus clocks, flush caches amongst a few that I know of. Some of it
are platform specific and some of it arent. This patches provide the way
for both of them to be done easily. The CPU runtime PM and PM domains as
a framework, closely track what the hardware does.

Mentioned in an other mail in this thread, is also an option to
determine the cluster flush state and use it in conjunction with PSCI to
do OS-Initiated cluster power down.

>Also if you look at the shmobile power controller driver, it covers all
>the devices including CPUs unlike QCOM power controller which handles
>only CPU. Yes we can skip CPU genpd creation there only for CPU, IMO
>creating the power domains should be part of power controller driver.
>
>You can add helper functions for all the ARM specific code that can be
>reused by multiple power controller drivers handling CPU/Cluster power
>domain.
>
Sure, some architectures may desire that. I have them addressed in [2].

>>An analogy to this would be the "arm,idle-state" that defines the DT
>>node as something that also depicts a generic cpuidle C state.
>>
>
>I tend to disagree. In idle-states, the nodes define that generic
>properties and they can be parsed in a generic way. That's not the case
>here. Each power controller binding differs.
>
Yes, may be we will have common elements like latency, residency of
powering on/off a domain that a genpd governor can utilize in
determining if its worth powering off the domain or not.

>Yes the generic compatible might be useful to identify that this power
>domain handles CPU/Cluster, but there will be more power controller
>specific things compared to generic code.
>
Agreed, not debating that. Power controller is very SoC specific, but
not debuggers, GIC, caches, buses etc. Many SoCs have almost similiar
needs for many of these supplemental hardware to the CPUs and trend
seems to be generalizing on many of these components.

Thanks,
Lina

>[1] http://www.spinics.net/lists/arm-kernel/msg437304.html
[2] http://www.spinics.net/lists/arm-kernel/msg438971.html
