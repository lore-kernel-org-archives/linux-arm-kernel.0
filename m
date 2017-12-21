From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 21 Dec 2017 20:39:17 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
Message-ID: <20171221193917.GB1105@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 11:22:50AM +0000, John Garry wrote:
> > > Actually having a scalable JSON standard format for pmu events, which allows
> > > us to define common events per architecture / vendor and reference them per
> > > platform JSON could be useful.
> > > 
> > > Here we're dealing with trade-off between duplication (simplicity) vs
> > > complexity (or over-engineering).
> > 
> > understood, but as I said we already are ok with duplicates,
> > if it's reasonable size as is for x86 now..  how much amount
> > are we talking about for arm?
> > 
> 
> Hi Jirka,
> 
> When you say reasonable size for x86, I ran a string duplication finder on
> the x86 JSONs and the results show a huge amount of duplication. Please
> check this:
> https://gist.githubusercontent.com/johnpgarry/68bc87e823ae2ce0f7b475b4e55e5795/raw/f4cea138999d8b34151b9586d733592e01774d7a/x86%2520JSON%2520duplication
> 
> Extract:
> "Found a 65 line (311 tokens) duplication in the following files:
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> Starting at line 76 of
> /linux/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> Starting at line 76 of
> /linux/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> Starting at line 100 of
> /linux/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json"
> 
> Won't this all potentially have a big maintainence cost?

as Andi said it's mostly just the disk space,
which is not big deal

I'm not doing JSON file updates, but I think having
simple single dir for platform/cpu could save us some
confusion in future

however I won't oppose if you want to add this logic,
but please:
  - use the list_head ;-)
  - leave the process_one_file function simple
    and separate the level0 processing
  - you are using 'EventCode' as an unique ID to find
    the base, but it's not unique for x86, you'll need
    to add some other ID scheme that fits to all archs

thanks,
jirka

> 
> For example, I saw multiple JSON update patches which look identical:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/pmu-events/arch/x86?h=v4.15-rc3&id=7347bba5552f479d4292ffd008d18d41a965f021
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/pmu-events/arch/x86?h=v4.15-rc3&id=984d91f4c62f64026cbfef51f609971025934cec
> 
> I just don't know how this schema scales with more archs and more platforms
> supported. It's just early days now...
> 
> Regards,
> John
> 
> > jirka
> > 
> > .
> > 
> 
> 
