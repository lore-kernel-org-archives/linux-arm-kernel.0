From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 23 Aug 2016 20:02:22 +0300
Subject: [PATCH V5 0/9] perf: Driver specific configuration for PMU
In-Reply-To: <CANLsYkxQNB-ZU6obSKvJZMMmZQT5kMfuUuA1PpF8YYeZqujwbQ@mail.gmail.com>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
 <878tvon8b7.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkxQNB-ZU6obSKvJZMMmZQT5kMfuUuA1PpF8YYeZqujwbQ@mail.gmail.com>
Message-ID: <87y43nl8pt.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 22 August 2016 at 09:15, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>>> As such something that used to be a two-step process:
>>>
>>> # echo 1 > /sys/bus/coresight/devices/20070000.etr/enable_sink
>>> # perf record -e cs_etm//u --per-thread  uname
>>>
>>> is integrated in a single command:
>>>
>>> # perf record -e cs_etm/@sink=20070000.etr/u --per-thread  uname
>>
>> Can't we simply teach perf record to write 1 to that sysfs attribute and
>> avoid parsing more ascii strings in the kernel? I suspect that would also
>> take way less code.
>
> That, in my opinion, would be a big hack.  Peter and Jiri, any thoughts on this?

Why would you say it's a hack? The whole tracer->sink configuration is
outside of scope of perf framework, there is absolutely no reason why
perf core should do this, especially, add this to perf ABI.

It would have somewhat made sense if you could configure different
events on the same pmu to send data to different sinks, but even that
won't work, because you simply cannot guarantee sink's availability if
you have to release it when your event gets scheduled out.

>> Are there any other use cases for this besides specifying @sink for a
>> ETM?
>
> Not at this time but there is so many configuration option for the
> ETM/PTM tracers (that aren't filters) that I wanted the right
> infrastructure to be there should/when we need to expand.

As I've asked before, what exactly is the need for expansion? That is,
something more than purely hypothetical that needs to be configured in
the tracer, on per event basis, *and* does not fit into the event
attribute. Note that the sink configuration also doesn't fit the bill.

Regards,
--
Alex
