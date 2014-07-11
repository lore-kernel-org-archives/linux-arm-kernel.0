From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 11 Jul 2014 17:17:44 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140711145138.GC3935@laptop>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
 <20140710111833.GY3935@laptop>
 <CAKfTPtD=TiURcppZ+oVUmhMf6Ofxbp4BPA0SCFViu0SDb05oRw@mail.gmail.com>
 <20140711145138.GC3935@laptop>
Message-ID: <CAKfTPtCdd6uR_qBuW2W4asMgEV=OfsNvrOCVQCci+w3C8RAoCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2014 16:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Jul 10, 2014 at 04:03:51PM +0200, Vincent Guittot wrote:
>> On 10 July 2014 13:18, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Mon, Jun 30, 2014 at 06:05:39PM +0200, Vincent Guittot wrote:
>> >> +             /*
>> >> +              * If the CPUs share their cache and the src_cpu's capacity is
>> >> +              * reduced because of other sched_class or IRQs, we trig an
>> >> +              * active balance to move the task
>> >> +              */
>> >> +             if ((sd->flags & SD_SHARE_PKG_RESOURCES)
>> >> +              && ((capacity_orig_of(src_cpu) * 100) > (capacity_of(src_cpu) *
>> >> +                                                     sd->imbalance_pct)))
>> >>                       return 1;
>> >
>> > Why is this tied to shared caches?
>>
>> It's just to limit the change of the policy to a level that can have
>> benefit without performance regression. I'm not sure that we can do
>> that at any level without risk
>
> Similar to the other change; so both details _should_ have been in the
> changelogs etc..

i'm going to add details in the v4

>
> In any case, its feels rather arbitrary to me. What about machines where
> there's no cache sharing at all (the traditional SMP systems). This
> thing you're trying to do still seems to make sense there.

ok, I thought that traditional SMP systems have this flag set at core
level. I mean ARM platforms have the flag for CPUs in the same cluster
(which include current ARM SMP system) and the corei7 of my laptop has
the flag at the cores level.

>
