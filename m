From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 22 May 2011 17:16:04 +0530
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <201105221335.03688.arnd@arndb.de>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<201105221154.28211.arnd@arndb.de> <4DD8F177.9020809@ti.com>
	<201105221335.03688.arnd@arndb.de>
Message-ID: <4DD8F77C.9050206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2011 5:05 PM, Arnd Bergmann wrote:
> On Sunday 22 May 2011 13:20:23 Santosh Shilimkar wrote:
>>>>    /*
>>>>     * Intercept ioremap() requests for addresses in our fixed mapping regions.
>>>
>>> The only thing that the ioremap functions for omap do as a special case
>>> is to handle the fixed mappings. Maybe a better approach would be to
>>> make handling this in omap (and others) unnecessary, using one of
>>> two approaches:
>>>
>>> * Remove all fixed mappings that are also ioremapped, and rely on every
>>>     user calling ioremap correctly. I don't see why we would want to allow
>>>     both methods anyway.
>>>
>> What do you mean by "Remove all fixed mappings that are also
>> ioremapped" ?
>
> I mean don't call iotable_init() for regions that is ioremapped
> into a device driver. Having both iotable_init and ioremap
> on the same area is a bit fishy anyway, so we should only have one
> of the two: If the ioremap specifies different attributes from
> the existing mapping, the code will still just return a pointer,
> which may not be what the driver asks for, although it avoids
> the problems that arise from having conflicting mappings.
>
At least on OMAP, the fixed mappings used are mainly the interconnect,
infrastructure, memory controller and most of these are not associated
with any driver.

On OMAP, the fixed mappings are handled directly so nothing fishy there.

Attributes are already provided via io descriptor for fixed mapping
and that should remain fixed. O.w there is no meaning for the fixed
mapping.

For dynamic mapping, different attributes work as usual via
__ioremap().

So I don't see why you will have conflicting mapping at all?

Infact we have a problem today in the dynamic ioremap() code,
where if you called ioremap() with same PA, multiple times,
it will keep creating new mappings, and this is where you
can land up in problem.

But this problem is separate and needs some kind of io_list
storage for dymamic mappings too.

>> Why will you ioremap() it again if the fixed mapping is already
>> registered through iotable_init()
>
> Evidently, drivers call ioremap on regions that have a mapping
> installed by iotable_init, otherwise the omap_ioremap function
> would not make any sense whatsoever.
>
See above. Driver's space is generally avoided in fixed
mappings.

Regards
Santosh
