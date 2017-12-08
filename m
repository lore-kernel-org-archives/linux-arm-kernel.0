From: jolsa@redhat.com (Jiri Olsa)
Date: Fri, 8 Dec 2017 13:29:18 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
Message-ID: <20171208122918.GE2799@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 03:20:14PM +0000, John Garry wrote:
> On 06/12/2017 13:36, Jiri Olsa wrote:
> > On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
> > > For some architectures (like arm64), there are architecture-
> > > defined recommended events. Vendors may not be obliged to
> > > follow the recommendation and may implement their own pmu
> > > event for a specific event code.
> > > 
> > > This patch adds support for parsing events from arch-defined
> > > recommended JSONs, and then fixing up vendor events when
> > > they have implemented these events as recommended.
> > 
> > in the previous patch you added the vendor support, so
> > you have arch|vendor|platform key for the event list
> > and perf have the most current/local event list
> > 
> > why would you need to fix it? if there's new event list,
> > the table gets updated, perf is rebuilt.. I'm clearly
> > missing something ;-)
> 
> The 2 patches are quite separate. In the first patch, I just added support
> for the vendor subdirectory.
> 
> So this patch is not related to rebuilding when adding a new event list or
> dependency checking.
> 
> Here we are trying to allow the vendor to just specify that an event is
> supported as standard in their platform, without duplicating all the
> standard event fields in their JSON. When processing the vendor JSONs, the
> jevents tool can figure which events are standard and create the proper
> event entries in the pmu events table, referencing the architecture JSON.

I think we should keep this simple and mangle this with some pointer logic

now you have arch/vendor/platform directory structure.. why don't
you add events for every such directory? I understand there will
be duplications, but we already have them for other archs and it's
not big deal:

	[jolsa at krava perf]$ grep -r L2_RQSTS.DEMAND_DATA_RD_MISS pmu-events/arch/*
	pmu-events/arch/x86/broadwell/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/haswell/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/broadwellde/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/haswellx/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/skylake/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/skylakex/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
	pmu-events/arch/x86/broadwellx/cache.json:        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",

thanks,
jirka
