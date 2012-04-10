From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 10 Apr 2012 13:28:57 +0300
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <4F7F0D52.8080305@linaro.org>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
 <4F7DA009.4010802@linux.intel.com>
 <CAMQu2gzwe0F3qcaTqASEPUASdG1SjpUxrBrSp-RrYLgy3W24OQ@mail.gmail.com>
 <4F7F0D52.8080305@linaro.org>
Message-ID: <20120410102857.GA22721@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 05:35:46PM +0200, Daniel Lezcano wrote:
> On 04/06/2012 12:32 PM, Shilimkar, Santosh wrote:
> > Peter,
> >
> > On Thu, Apr 5, 2012 at 7:07 PM, Arjan van de Ven<arjan@linux.intel.com>  wrote:
> >> On 4/5/2012 2:53 AM, Peter De Schrijver wrote:
> >>> This patch doesn't update all cpuidle device registrations. I will do that
> >>
> >> question is if you want to do per cpu latencies, or if you want to have
> >> both types of C state in one big table, and have each of the tegra cpyu
> >> types pick half of them...
> >>
> >>
> > Indeed !! That should work.
> > I thought the C-states are always per CPU based and during the
> > cpuidle registration you can register C-state accordingly based on the
> > specific CPU types with different latencies if needed.
> >
> > Am I missing something ?
> 
> That was the case before the cpuidle_state were moved from the 
> cpuidle_device to the cpuidle_driver structure [1].
> 
> That had the benefit of using a single latencies array instead of 
> multiple copy of the same array, which was the case until today.
> 
> I looked at the white paper for the tegra3 and understand this is no 
> longer true because of the 4-plus-1 architecture [2].
> 

The reason is not so much 4-plus-1, but in 4 CPU mode, only CPUs 1 - 3 can
be powergated individually. To turn off CPU0, the external regulator for
the entire cluster is turned off. This means latencies for CPU0 are different
from the other CPUs.

> With the increasing number of SoCs, we have a lot of new cpuidle drivers 
> and each time we modify something in the cpuidle core, that impacts all 
> the cpuidle drivers.
> 
> My feeling is we are going back and forth when patching the cpuidle core 
> and may be it is time to define a clear semantic before patching again 
> the cpuidle, no ?
> 
> What could nice is to have:
> 
>   * in case of the same latencies for all cpus, use a single array
> 
>   * in case of different latencies, group the same latencies into a 
> single array (I assume this is the case for 4-plus-1, right ?)
> 
> May be we can move the cpuidle_state to a per_cpu pointer like 
> cpuidle_devices in cpuidle.c and then add:
> 
> register_latencies(struct cpuidle_latencies l, int cpu);
> 
> If we have the same latencies for all the cpus, then we can register the 
> same array, which is only a pointer.

Maybe we also want to make the 'disabled' flag per CPU then or provide some
other way the number of C states can be different per CPU?

Cheers,

Peter.
