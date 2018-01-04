From: john.garry@huawei.com (John Garry)
Date: Thu, 4 Jan 2018 17:17:56 +0000
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <20171221193917.GB1105@krava>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
 <20171221193917.GB1105@krava>
Message-ID: <850a0774-9442-c836-f457-69e1e0d72fb2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/2017 19:39, Jiri Olsa wrote:
>> Hi Jirka,
>> >
>> > When you say reasonable size for x86, I ran a string duplication finder on
>> > the x86 JSONs and the results show a huge amount of duplication. Please
>> > check this:
>> > https://gist.githubusercontent.com/johnpgarry/68bc87e823ae2ce0f7b475b4e55e5795/raw/f4cea138999d8b34151b9586d733592e01774d7a/x86%2520JSON%2520duplication
>> >
>> > Extract:
>> > "Found a 65 line (311 tokens) duplication in the following files:
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
>> > Starting at line 76 of
>> > /linux/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
>> > Starting at line 76 of
>> > /linux/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
>> > Starting at line 100 of
>> > /linux/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json"
>> >


Hi Jirka,

Sorry for the slow reply.

>> > Won't this all potentially have a big maintainence cost?
> as Andi said it's mostly just the disk space,
> which is not big deal
>
> I'm not doing JSON file updates, but I think having
> simple single dir for platform/cpu could save us some
> confusion in future

Understood. But for ARM, which has very standardised architecture 
events, it is good to reduce this event duplication between platforms.

>
> however I won't oppose if you want to add this logic,
> but please:
>   - use the list_head ;-)

Of course

>   - leave the process_one_file function simple
>     and separate the level0 processing

ok, this is how it should look already, albeit a couple of 
process_one_file() modifications. I'll re-check this.

>   - you are using 'EventCode' as an unique ID to find
>     the base, but it's not unique for x86, you'll need
>     to add some other ID scheme that fits to all archs

Right, so you mentioned earlier using a new keyword token to identify 
whether we use the standard event, so we can go his way - ok?

I would also like to mention at this point why I did the event 
pre-processing in jevents, and not a separate script:
- current build does not transverse the arch tree
	- tree transversal for JSON processing is done in jevents
- a script would mean derived objects, which means:
	- makefile changes for derived objects
	- jevents would have to deal with derived objects
- jevents already has support for JSON processing

The advantage of using a script is that we keep the JSON processing in 
jevents simple.

All the best,
John

>
> thanks,
> jirka
>
