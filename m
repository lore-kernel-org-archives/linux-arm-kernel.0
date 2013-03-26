From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Mar 2013 14:00:50 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1364301443.5053.9.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301443.5053.9.camel@laptop>
Message-ID: <CAKfTPtBU40WZU8n-vS=APG4oirBuVR4LB8VNRQ6OT2pr1PhcKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2013 13:37, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
>> +static bool is_light_task(struct task_struct *p)
>> +{
>> +       /* A light task runs less than 20% in average */
>> +       return ((p->se.avg.runnable_avg_sum  * 5) <
>> +                       (p->se.avg.runnable_avg_period));
>> +}
>
> OK, so we have a 'problem' here, we initialize runnable_avg_* to 0, but
> we want to 'assume' a fresh task is fully 'loaded'. IIRC Alex ran into
> this as well.
Hi Peter,

The packing small tasks is only applied at wake up and not during fork
or exec so the runnable_avg_* should have been initialized. As you
mentionned, we assume that a fresh task is fully loaded and let the
default scheduler behavior to select a target CPU

Vincent

>
> PJT, do you have any sane solution for this, I forgot what the result
> of the last discussion was -- was there any?
>
