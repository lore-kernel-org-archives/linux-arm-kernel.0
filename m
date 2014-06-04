From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 4 Jun 2014 11:35:15 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140604092313.GB11096@twins.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <CAKfTPtDxeBfZK1AxCRqEG91pi--Ti1RYFoQPDhvMVnGTCspQ-g@mail.gmail.com>
 <20140528154703.GJ19967@e103034-lin>
 <20140603155007.GZ30445@twins.programming.kicks-ass.net>
 <CAKfTPtDUvH--WxFATTW6YRAvLuohzyNHDUq6DRdfxc7gRKCX6Q@mail.gmail.com>
 <20140604080809.GK30445@twins.programming.kicks-ass.net>
 <20140604085542.GH29593@e103034-lin>
 <20140604092313.GB11096@twins.programming.kicks-ass.net>
Message-ID: <CAKfTPtBVyMMzXoFoL=kT8oP97BZ8S6P_2ySNhXLC1gR80jw6vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2014 11:23, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 04, 2014 at 09:55:42AM +0100, Morten Rasmussen wrote:
>> Both running_avg and runnable_avg are affected by other tasks on the
>> same cpus, but in different ways. They are equal if you only have one
>> task on a cpu. If you have more, running_avg will give you the true
>> requirement of the tasks until the cpu is fully utilized. At which point
>> the task running_avg will drop if you add more tasks (the unweighted sum
>> of task running_avgs remains constant).
>>
>> runnable_avg on the other hand, might be affected as soon as you have
>> two task running on the same cpu if they are runnable at the same time.
>> That isn't necessarily a bad thing for load-balancing purposes, because
>> tasks that are runnable at the same time are likely to be run more
>> efficiently by placing them on different cpus. You might view as at sort
>> of built in concurrency factor, somewhat similar to what Yuyang is
>> proposing. runnable_avg increases rapidly when the cpu is over-utilized.
>
> Agreed.
>
>> > I'm not sure I see how 100% is possible, but yes I agree that runnable
>> > can indeed be inflated due to this queueing effect.
>>
>> You should only be able to get to 75% worst case for runnable_avg for
>> that example. The total running_avg is 50% no matter if the tasks
>> overlaps or not.
>
> Yes, 75% is what I ended up with.

Can you explain how you reach 75% as it depends on the runtime and a
runtime longer than 345ms will end to a 100% load whatever the
idletime was previously ?


>
>> f you had five tasks on one cpu that each have a 25% requirement you can
>> get individual task runnable_avgs of up to 100% (cpu unweighted
>> runnable_load_avg can get up 500%, I think), but the task running_avgs
>> would be 20% each (total of 100%).
>
> Yeah, more or less so indeed. I had not considered the queueing effects
> on runnable_avg yesterday, so good that that got raised.
>
> That does indeed invalidate my: runnable - running := extra cpu required
> thing. It ends up being the extra cpu required for 0 latency but gobs of
> idle time, which is something else entirely.
