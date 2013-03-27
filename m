From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Wed, 27 Mar 2013 10:03:15 +0530
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1364301443.5053.9.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301443.5053.9.camel@laptop>
Message-ID: <5152768B.3020306@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 03/26/2013 06:07 PM, Peter Zijlstra wrote:
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
> 
> PJT, do you have any sane solution for this, I forgot what the result
> of the last discussion was -- was there any?

The conclusion after last discussion between PJT and Alex was that the
load contribution of a fresh task be set to "full" during "__sched_fork()".

task->se.avg.load_avg_contrib = task->se.load.weight during
__sched_fork() is reflected in the latest power aware scheduler patchset
by Alex.

Thanks

Regards
Preeti U Murthy
> 
