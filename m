From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Sep 2016 09:13:12 -0600
Subject: [PATCH V7 5/5] perf tools: adding sink configuration for cs_etm
 PMU
In-Reply-To: <69b45eb1-6b4b-329d-c833-5846f222119e@arm.com>
References: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
 <1472573965-3881-6-git-send-email-mathieu.poirier@linaro.org>
 <94a6e940-cce8-a179-fe0c-c69a543e302c@arm.com>
 <CANLsYkzeS=1fY6uQVNpJMpOfqnT_BtUOfh+YHzZWi+XA+C=dwQ@mail.gmail.com>
 <69b45eb1-6b4b-329d-c833-5846f222119e@arm.com>
Message-ID: <CANLsYkzgTw9LvdiXqi+URDi0kiOZBfoBo6ShRLsPfDwG+N96iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2016 at 03:04, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 31/08/16 15:14, Mathieu Poirier wrote:
>>
>> On 31 August 2016 at 03:37, Suzuki K Poulose <Suzuki.Poulose@arm.com>
>> wrote:
>>>
>>> On 30/08/16 17:19, Mathieu Poirier wrote:
>>>>
>>>>
>>>> Using the PMU::set_drv_config() callback to enable the CoreSight
>>>> sink that will be used for the trace session.
>>>
>>>
>>>
>>>> +int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
>>>> +{
>>>> +       int ret;
>>>> +       char enable_sink[ENABLE_SINK_MAX];
>>>> +
>>>> +       snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
>>>> +                term->val.drv_cfg, "enable_sink");
>>>> +
>>>> +       ret = cs_device__print_file(enable_sink, "%d", 1);
>>>> +       if (ret < 0)
>>>> +               return ret;
>>>> +
>>>> +       return 0;
>>>> +}
>>>
>>>
>>>
>>>
>>> Don't we have to disable the sink at the end of the session ? How is that
>>> taken care of ? Did I miss that ?
>>>
>>
>> Correct - the sink has to be disabled once it is no longer needed.  It
>> is a little tricky to do and I haven't decided on the best way to
>> proceed.  Fortunately that aspect doesn't affect this patchset.
>
>
> Well, this patchset when used, could leave a sink enabled.

At this time it does yes, but that is a problem inherent to the
CoreSight framework rather than perf's ability to push driver specific
configuration to the PMU drivers.  That is the reason why I decided to
address this issue in a later patch.  There is also the fact that I
haven't heard back from Arnaldo on this approach - if I get asked to
proceed differently then the method for disabling sinks will have to
change.

> If we a choose
> a different sink (say an ETF) from the perf, which occurs before the
> previous sink (say an ETR) in the coresight path, the perf wouldn't get any
> trace data, without any clue.
>
> May be we could register an atexit() handler for clearing the sink ? So that
> it is guaranteed to clear it irrespective of the path taken by perf to exit
> ?

Yes, that would be the most intuitive solution but it won't work for
CoreSight.  The PMU driver allows multiple traces session to exist
concurrently and that, with different sinks for each session (if the
HW topology supports it).  As such the sink for a session needs to be
disabled at driver level as soon as it got recognised in the
configuration of a path.  That way the next session, which may start
before the previous one ended, doesn't trip on the sink that was
selected earlier.

I thought about a solution and I think it can work but before moving
ahead with it, I need to have an idea of how this patchset will go.

Thanks for the comments,
Mathieu


>
> Cheers
> Suzuki
>
