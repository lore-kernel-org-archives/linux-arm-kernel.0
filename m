From: valentin.schneider@arm.com (Valentin Schneider)
Date: Wed, 4 Apr 2018 11:44:04 +0100
Subject: [PATCH] sched: support dynamiQ cluster
In-Reply-To: <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
 <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
Message-ID: <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/04/18 13:17, Vincent Guittot wrote:
> Hi Valentin,
> 
[...]
>>
>> I believe ASYM_PACKING behaves better here because the workload is only
>> sysbench threads. As stated above, since task utilization is disregarded, I
> 
> It behaves better because it doesn't wait for the task's utilization
> to reach a level before assuming the task needs high compute capacity.
> The utilization gives an idea of the running time of the task not the
> performance level that is needed
> 

That's my point actually. ASYM_PACKING disregards utilization and moves those
threads to the big cores ASAP, which is good here because it's just sysbench
threads.

What I meant was that if the task composition changes, IOW we mix "small"
tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
sysbench threads), we shouldn't assume all of those require to run on a big
CPU. The thing is, ASYM_PACKING can't make the difference between those, so
it'll all come down to which task spawned first.

Furthermore, ASYM_PACKING will forcefully move tasks via active balance
regardless of the imbalance as long as a big CPU is idle.

So we could have a scenario where loads of "small" tasks spawn, and they all
get moved to a big CPU until they're all full (because they're periodic tasks
so the big CPUs will eventually be idle and will pull another task as long as
they get some idle time).

Then, before the load tracking signals of those tasks ramp up high enough 
that the load balancer would try to move those to LITTLE CPUs, some "big"
tasks spawn. They get scheduled on LITTLE CPUs, and now the system will look
balanced so nothing will be done.


I acknowledge this all sounds convoluted but I hope it highlights what I
think could go wrong with ASYM_PACKING on asymmetric systems.

Regards,
Valentin
