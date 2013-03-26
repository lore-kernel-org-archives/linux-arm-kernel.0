From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Mar 2013 14:06:38 +0100
Subject: [RFC PATCH v3 4/6] sched: secure access to other CPU statistics
In-Reply-To: <1364302242.5053.19.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-5-git-send-email-vincent.guittot@linaro.org>
 <1364302242.5053.19.camel@laptop>
Message-ID: <CAKfTPtA0xpGmyKr6pqiV9wjv4ZQ_xQGjR=+7h_xTe_LLA+Do9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2013 13:50, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
>> @@ -3364,13 +3364,16 @@ done:
>>  static bool is_buddy_busy(int cpu)
>>  {
>>         struct rq *rq = cpu_rq(cpu);
>> +       u32 sum = rq->avg.runnable_avg_sum;
>> +       u32 period = rq->avg.runnable_avg_period;
>> +
>> +       sum = min(sum, period);
>
> OK this makes sense; use a simple sanity constraint instead of going
> overboard on serialization -- however, why is this a separate patch?

There is no real reason other than explaining why I have added this
additional check

>
> That is, this could easily be part of the patch that introduces
> is_buddy_busy(); also you likely want part of this patch's changelog
> to become a comment that goes right above this min() :-)

Yes, i 'm going to do that

>
