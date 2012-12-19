From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 19 Dec 2012 11:03:58 -0600
Subject: CoreSight framework and drivers
In-Reply-To: <20121219112314.GA26329@mudshark.cambridge.arm.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
Message-ID: <50D1F37E.6000804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/19/2012 05:23 AM, Will Deacon wrote:
> Hi Pratik,
> 
> On Tue, Dec 18, 2012 at 07:19:17PM +0000, pratikp at codeaurora.org wrote:
>> This RFC is aimed at introducing CoreSight framework as well as
>> individual CoreSight trace component drivers adhering to ARM
>> CoreSight specification. Some prior discussion on this can be
>> referred at [1].
>>
>> There are 3 kinds of CoreSight trace components:
>>
>> * Sources: Responsible for producing trace data to provide
>>   visibility for the associated entity.
>>
>> * Links: Transport components that carry trace data.
>>
>> * Sinks: Collectors for storing trace data or acting as conduits
>>   for off-chip trace data collection.
>>
>> These components can be connected in various topologies to suite
>> a particular SoCs tracing needs.
>>
>> Framework is responsible for gathering and using the information
>> about the registered CoreSight components and their connections
>> to allow it to dynamically deduce the sequence of components
>> representing a connection from a CoreSight source to the
>> currently selected CoreSight sink. This helps the framework to
>> program the correct set of components to satisfy user request.
> 
> From a million miles up, this looks like a sensible sort of design but I
> really think you need to talk to Jon Hunter (he's at least on CC) about
> this, especially where bindings are concerned. If we can get something that
> you both agree on, then we can include the CTI with the other coresight
> components and do a more in-depth review at that point.

I need to look at these in closer detail, but there are a couple
high-level items that need to be aligned on which are ...

1. Why not use the AMBA bus framework?

You mentioned before that "AMBA bus is for PrimeCell devices (class 0xF)
as opposed to CoreSight devices (class 0x9)". I will not claim to be
that familiar with primecell and coresight devices and there
differences, but this statement does not help me understand why a new
bus type is needed. Furthermore, the existing ETM and ETB driver in
arch/arm/kernel/etm.c uses the AMBA bus today and so at least those
coresight devices are able to use the AMBA bus type.

2. What about the existing ETM/ETB drivers?

We have existing drivers for ETM and ETB in arch/arm/kernel/etm.c. We
should either move those drivers to the drivers directory or replace
them with the new one. However, no point in having two drivers for the
same coresight device.

Cheers
Jon
