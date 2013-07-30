From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 30 Jul 2013 16:09:02 +0800
Subject: [RFC][PATCH 1/2] ARM64: add cpu topology definition
In-Reply-To: <20130729133625.GA2280@localhost.localdomain>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
 <CAKfTPtBpo41LJ3V8TB8YwudwqpURuA2u_Lvu4KYVK=qSs+gFuQ@mail.gmail.com>
 <20130729095400.GB32383@mudshark.cambridge.arm.com>
 <20130729133625.GA2280@localhost.localdomain>
Message-ID: <51F7749E.1010005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-7-29 21:36, Dave Martin wrote:
> On Mon, Jul 29, 2013 at 10:54:01AM +0100, Will Deacon wrote:
>> On Mon, Jul 29, 2013 at 10:46:06AM +0100, Vincent Guittot wrote:
>>> On 27 July 2013 12:42, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>>> Power aware scheduling needs the cpu topology information to improve the
>>>> cpu scheduler decision making.
>>>
>>> It's not only power aware scheduling. The scheduler already uses
>>> topology and cache sharing when  CONFIG_SCHED_MC and/or
>>> CONFIG_SCHED_SMT are enable. So you should also add these configs for
>>> arm64 so the scheduler can use it
>>
>> ... except that the architecture doesn't define what the AFF fields in MPIDR
>> really represent. Using them to make key scheduling decisions relating to
> 
> In fact, the ARM Architecture doesn't place any requirements on MPIDRs to
> force the aff fields to exist _at all_.  It's just a recommendation.
> Instead, you have a 24 or 32-bit number which is unique per CPU, and which
> is _probably_ assigned in a way resembling the aff fields.
> 
>> cache proximity seems pretty risky to me, especially given the track record
>> we've seen already on AArch32 silicon. It's a convenient register if it
>> contains the data we want it to contain, but we need to force ourselves to
>> come to terms with reality here and simply use it as an identifier for a
>> CPU.
> 
> +1
> 
> Also, we should align arm and arm64.  The problem is basically exactly
> the same, and the solution needs to be the same.  struct cputopo_arm is
> already being abused  -- for example, TC2 describes the A15 and A7
> clusters on a single die as having different "socket_id" values, even
> though this is obviously nonsense.  But there's no other way to describe
> that system today.
> 
>> Can't we just use the device-tree to represent this topological data for
>> arm64? Lorenzo has been working on bindings in this area.
> 
> This may become more important as we start to see things like asymmetric
> topologies appearing (different numbers of nodes and different
> interdependence characteristics in adjacent branches of the topology
> etc.)

Agreed.
I would like to mention that the ACPI Static Resource Affinity Table (SRAT)
stores topology information for all the processors and memory, describing
the physical locations of the processors and memory in the system. ACPI will
be another available solution for this.

Thanks
Hanjun
