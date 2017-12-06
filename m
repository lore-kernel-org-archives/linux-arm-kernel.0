From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 15:20:14 +0000
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <20171206133607.GA12508@krava>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
Message-ID: <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2017 13:36, Jiri Olsa wrote:
> On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
>> For some architectures (like arm64), there are architecture-
>> defined recommended events. Vendors may not be obliged to
>> follow the recommendation and may implement their own pmu
>> event for a specific event code.
>>
>> This patch adds support for parsing events from arch-defined
>> recommended JSONs, and then fixing up vendor events when
>> they have implemented these events as recommended.
>
> in the previous patch you added the vendor support, so
> you have arch|vendor|platform key for the event list
> and perf have the most current/local event list
>
> why would you need to fix it? if there's new event list,
> the table gets updated, perf is rebuilt.. I'm clearly
> missing something ;-)

The 2 patches are quite separate. In the first patch, I just added 
support for the vendor subdirectory.

So this patch is not related to rebuilding when adding a new event list 
or dependency checking.

Here we are trying to allow the vendor to just specify that an event is 
supported as standard in their platform, without duplicating all the 
standard event fields in their JSON. When processing the vendor JSONs, 
the jevents tool can figure which events are standard and create the 
proper event entries in the pmu events table, referencing the 
architecture JSON.

>
>> In the vendor JSON, to specify that the event is supported
>> according to the recommendation, only the event code is
>> added to the JSON entry - no other event elements need be
>> added, like below:
>> [
>>     {
>>         "EventCode": "0x40",
>>     },
>>
>> ]
>>
>> The pmu event parsing will check for "BriefDescription"
>> field presence only for this.
>>
>> If "BriefDescription" is present, then it is implied
>> that the vendor has implemented their own custom event,
>> and there is no fixup. Other fields are ignored.
>
> if we are going this way, please use some new token,
> this list is supposed to be human readable

A new token could work also, but it would be just a flag to mark the 
event "standard".

Ideally we could reference another entry in another JSON, like a 
pointer, but I don't think that this is possible with JSONs; not unless 
we introduce some elaborate custom scheme to allow JSONs to be 
cross-referenced.

Cheers,
John

>
> thanks,
> jirka
>
> .
>
