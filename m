From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Mon, 02 Jun 2014 11:51:10 +0530
Subject: [PATCH v2 11/11] sched: replace capacity by activity
In-Reply-To: <20140529135510.GG11074@laptop.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-12-git-send-email-vincent.guittot@linaro.org>
 <20140529135510.GG11074@laptop.programming.kicks-ass.net>
Message-ID: <538C17D6.60100@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2014 07:25 PM, Peter Zijlstra wrote:
> On Fri, May 23, 2014 at 05:53:05PM +0200, Vincent Guittot wrote:
>> The scheduler tries to compute how many tasks a group of CPUs can handle by
>> assuming that a task's load is SCHED_LOAD_SCALE and a CPU capacity is
>> SCHED_POWER_SCALE.
>> We can now have a better idea of the utilization of a group fo CPUs thanks to
>> group_actitvity and deduct how many capacity is still available.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
> 
> Right, so as Preeti already mentioned, this wrecks SMT. It also seems to
> loose the aggressive spread, where we want to run 1 task on each 'core'
> before we start 'balancing'.

True. I just profiled the ebizzy runs and found that ebizzy threads were
being packed onto a single core which is SMT-8 capable before spreading.
This was a 6 core, SMT-8 machine. So for instance if I run 8 threads of
ebizzy. the load balancing as record by perf sched record showed that
two cores were packed upto 3 ebizzy threads and one core ran two ebizzy
threads while the rest of the 3 cores were idle.

I am unable to understand which part of this patch is aiding packing to
a core.  There is this check in this patch right?

if (sgs->group_capacity < 0)
		return true;

which should ideally prevent such packing? Because irrespective of the
number of SMT threads, the capacity of a core is unchanged. And in the
above scenario, we have 6 tasks on 3 cores. So shouldn't the above check
have caught it?

Regards
Preeti U Murthy
> 
> So I think we should be able to fix this by setting PREFER_SIBLING on
> the SMT domain, that way we'll get single tasks running on each SMT
> domain before filling them up until capacity.
> 
> Now, its been a while since I looked at PREFER_SIBLING, and I've not yet
> looked at what your patch does to it, but it seems to me that that is
> the first direction we should look for an answer to this.
> 
