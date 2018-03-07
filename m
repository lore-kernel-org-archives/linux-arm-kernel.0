From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 7 Mar 2018 10:39:04 -0600
Subject: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
In-Reply-To: <20180303154113.GH25201@hirez.programming.kicks-ass.net>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
 <20180224084106.GC25201@hirez.programming.kicks-ass.net>
 <7cab1b91545e81e4b6b09e85c2f81d7e@codeaurora.org>
 <20180303154113.GH25201@hirez.programming.kicks-ass.net>
Message-ID: <dcf756fa-4e12-68de-2848-b3192a064a6f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/03/2018 09:41 AM, Peter Zijlstra wrote:
> On Mon, Feb 26, 2018 at 05:53:57PM -0800, skannan at codeaurora.org wrote:
>> On 2018-02-24 00:41, Peter Zijlstra wrote:
>>> On Fri, Feb 23, 2018 at 04:19:38PM -0800, Saravana Kannan wrote:
>>>> Some PMUs events can be read from any CPU. So allow the PMU to mark
>>>> events as such. For these events, we don't need to reject reads or
>>>> make smp calls to the event's CPU and cause unnecessary wake ups.
>>>>
>>>> Good examples of such events would be events from caches shared across
>>>> all CPUs.
>>>
>>> So why would the existing ACTIVE_PKG not work for you? Because clearly
>>> your example does not cross a package.
>>
>> Because based on testing it on hardware, it looks like the two clusters in
>> an ARM DynamIQ design are not considered part of the same "package". When I
>> say clusters, I using the more common interpretation of "homogeneous CPUs
>> running on the same clock"/CPUs in a cpufreq policy and not ARM's new
>> redefinition of cluster. So, on a SoC with 4 little and 4 big cores, it'll
>> still trigger a lot of unnecessary smp calls/IPIs that cause unnecessary
>> wakeups.
> 
> arch/arm64/include/asm/topology.h:#define topology_physical_package_id(cpu)     (cpu_topology[cpu].cluster_id)
> 
> *sigh*... that's just broken...
> 

Its being reworked in the PPTT (currently v7) patch set. For ACPI 
systems (and hopefully DT machines with the package property set) 
topology_physical_package and core siblings represent the socket as one 
would expect.

Thanks,
