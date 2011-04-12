From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 12 Apr 2011 19:12:18 +0800
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302604228.2035.2.camel@laptop>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<1302349235.9086.1270.camel@twins>
	<20110412153937.07a2311e@tom-lei> <1302604228.2035.2.camel@laptop>
Message-ID: <BANLkTikK_YCu-hMH=2hD25WJS7Lu15p+7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

2011/4/12 Peter Zijlstra <peterz@infradead.org>:
> On Tue, 2011-04-12 at 15:39 +0800, Ming Lei wrote:
>> > I just haven't figured out a way to dynamically add files/directories
>>
>> Seems not very difficult, we have pmu_bus already, so introduce the
>> .match to find driver according device name, then implement a
>> driver for the pmu device to add this needed attributes(files).
>
> It probably isn't very hard, but I'm not sysfs/driver skilled and
> haven't been able to put a lot of time in.
>
>> > in the whole struct device sysfs muck (that also pleases the
>> > driver/sysfs folks). Nor have we agreed on a sane layout for such
>> > events there.
>>
>> You mean we can find this event names here and pass them to perf -e ?
>
> That's the purpose yes. The intermediate problem is how to represent
> these events in the sysfs hierarchy such that not every pmu
> implementation does it differently.

How about the below idea?

      - for each pmu device, one attribute group(directory) named as 'events'
     is created to accommodate all events this pmu can handle, such as:

                /sys/devices/cpu/events/ for pmu of 'cpu'

     - perf_pmu_register will populate all events that this pmu can handle under
      the directory of 'events' using information from the defined pmu instance

     - 'perf' utility can get all events for each pmu by walking the
directory of
     'events' for all pmu devices, which can be got from
'/sys/bus/event_source/devices'.

thanks,
-- 
Ming Lei
